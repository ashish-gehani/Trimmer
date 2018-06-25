//===-- LoopUnroll.cpp - Loop unroller pass -------------------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This pass implements a simple loop unroller.  It works best when loops have
// been canonicalized by the -indvars pass, allowing it to determine the trip
// counts of loops easily.
//===----------------------------------------------------------------------===//


// FIXITs:
// 1) Fix all hacks
// 2) Ensure full unrolling of loops - no conditional looping required 
// 3) Replace certain method calls 
// 4) TODO (new): Add tryToUnrollPragmaHints method
// 5) TODO (new): Pass Static file arguments to Loop Unroll and File IO
// 6) FIXIT (new): The large threshold value passed to the loop unroll must be replaced with something
//                   more sensible


#include "llvm/Transforms/Scalar.h"
#include "llvm/ADT/SetVector.h"
#include "llvm/Analysis/GlobalsModRef.h"
#include "llvm/Analysis/AssumptionCache.h"
#include "llvm/Analysis/CodeMetrics.h"
#include "llvm/Analysis/InstructionSimplify.h"
#include "llvm/Analysis/LoopPass.h"
#include "llvm/Analysis/ScalarEvolution.h"
#include "llvm/Analysis/ScalarEvolutionExpressions.h"
#include "llvm/Analysis/TargetTransformInfo.h"
#include "llvm/IR/DataLayout.h"
#include "llvm/IR/DiagnosticInfo.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/InstVisitor.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/IR/Metadata.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/Utils/UnrollLoop.h"
#include <climits>
#include <sys/stat.h>
#include <unistd.h>
#include "parse_args.h"
using namespace llvm;

#define DEBUG_TYPE "loop-unroll2"
#define debugPrint 0 // This macro enables/disables debug print messages

static cl::opt<unsigned>
UnrollThreshold("unroll-threshold2", cl::Hidden,
		cl::desc("The baseline cost threshold for loop unrolling"));

static cl::opt<unsigned> UnrollPercentDynamicCostSavedThreshold(								"unroll-percent-dynamic-cost-saved-threshold2", cl::Hidden,
      cl::desc("The percentage of estimated dynamic cost which must be saved by "
      "unrolling to allow unrolling up to the max threshold."));

static cl::opt<unsigned> UnrollDynamicCostSavingsDiscount(
      "unroll-dynamic-cost-savings-discount2", cl::Hidden,
       cl::desc("This is the amount discounted from the total unroll cost when "
      "the unrolled form has a high dynamic cost savings (triggered by "
      "the '-unroll-perecent-dynamic-cost-saved-threshold' flag)."));

static cl::opt<unsigned> UnrollMaxIterationsCountToAnalyze(
      "unroll-max-iteration-count-to-analyze2", cl::init(0), cl::Hidden,
      cl::desc("Don't allow loop unrolling to simulate more than this number of"
      "iterations when checking full unroll profitability"));

static cl::opt<unsigned>
UnrollCount("unroll-count2", cl::Hidden,
	    cl::desc("Use this unroll count for all loops including those with "
		     "unroll_count pragma values, for testing purposes"));

static cl::opt<bool>
UnrollAllowPartial("unroll-allow-partial2", cl::Hidden,
		   cl::desc("Allows loops to be partially unrolled until "
			    "-unroll-threshold loop size is reached."));

static cl::opt<bool>
UnrollRuntime("unroll-runtime2", cl::ZeroOrMore, cl::Hidden,
	      cl::desc("Unroll loops with run-time trip counts"));

static cl::opt<unsigned>
PragmaUnrollThreshold("pragma-unroll-threshold2", cl::init(16 * 1024), cl::Hidden,
		      cl::desc("Unrolled size limit for loop with an unroll(full) or "
			       "unroll_count pragma."));

static cl::opt<std::string> args("args",
				 cl::desc("':' colon seperated argument list"));


/// A magic value for use with the Threshold parameter to indicate
/// that the loop unroll should be performed regardless of how much
/// code expansion would result.
static const unsigned NoThreshold = UINT_MAX;


namespace {
  // This class is used to get an estimate of the optimization effects that we
  // could get from complete loop unrolling. It comes from the fact that some
  // loads might be replaced with concrete constant values and that could trigger
  // a chain of instruction simplifications.
  //
  // E.g. we might have:
  //   int a[] = {0, 1, 0};
  //   v = 0;
  //   for (i = 0; i < 3; i ++)
  //     v += b[i]*a[i];
  // If we completely unroll the loop, we would get:
  //   v = b[0]*a[0] + b[1]*a[1] + b[2]*a[2]
  // Which then will be simplified to:
  //   v = b[0]* 0 + b[1]* 1 + b[2]* 0
  // And finally:
  //   v = b[1]
  class UnrolledInstAnalyzer : private InstVisitor<UnrolledInstAnalyzer, bool> {
    typedef InstVisitor<UnrolledInstAnalyzer, bool> Base;
    friend class InstVisitor<UnrolledInstAnalyzer, bool>;
    struct SimplifiedAddress {
      Value *Base = nullptr;
      ConstantInt *Offset = nullptr;
    };

  public:
    UnrolledInstAnalyzer(unsigned Iteration,
			 DenseMap<Value *, Constant *> &SimplifiedValues,
			 ScalarEvolution &SE)
      : SimplifiedValues(SimplifiedValues), SE(SE) {
      IterationNumber = SE.getConstant(APInt(64, Iteration));
    }

    // Allow access to the initial visit method.
    using Base::visit;

  private:
    /// \brief A cache of pointer bases and constant-folded offsets corresponding
    /// to GEP (or derived from GEP) instructions.
    ///
    /// In order to find the base pointer one needs to perform non-trivial
    /// traversal of the corresponding SCEV expression, so it's good to have the
    /// results saved.
    DenseMap<Value *, SimplifiedAddress> SimplifiedAddresses;

    /// \brief SCEV expression corresponding to number of currently simulated
    /// iteration.
    const SCEV *IterationNumber;

    /// \brief A Value->Constant map for keeping values that we managed to
    /// constant-fold on the given iteration.
    ///
    /// While we walk the loop instructions, we build up and maintain a mapping
    /// of simplified values specific to this iteration.  The idea is to propagate
    /// any special information we have about loads that can be replaced with
    /// constants after complete unrolling, and account for likely simplifications
    /// post-unrolling.
    DenseMap<Value *, Constant *> &SimplifiedValues;

    ScalarEvolution &SE;

    /// \brief Try to simplify instruction \param I using its SCEV expression.
    ///
    /// The idea is that some AddRec expressions become constants, which then
    /// could trigger folding of other instructions. However, that only happens
    /// for expressions whose start value is also constant, which isn't always the
    /// case. In another common and important case the start value is just some
    /// address (i.e. SCEVUnknown) - in this case we compute the offset and save
    /// it along with the base address instead.
    bool simplifyInstWithSCEV(Instruction *I) {
      if (!SE.isSCEVable(I->getType()))
	return false;

      const SCEV *S = SE.getSCEV(I);
      if (auto *SC = dyn_cast<SCEVConstant>(S)) {
	SimplifiedValues[I] = SC->getValue();
	return true;
      }

      auto *AR = dyn_cast<SCEVAddRecExpr>(S);
      if (!AR)
	return false;

      const SCEV *ValueAtIteration = AR->evaluateAtIteration(IterationNumber, SE);
      // Check if the AddRec expression becomes a constant.
      if (auto *SC = dyn_cast<SCEVConstant>(ValueAtIteration)) {
	SimplifiedValues[I] = SC->getValue();
	return true;
      }

      // Check if the offset from the base address becomes a constant.
      auto *Base = dyn_cast<SCEVUnknown>(SE.getPointerBase(S));
      if (!Base)
	return false;
      auto *Offset =
        dyn_cast<SCEVConstant>(SE.getMinusSCEV(ValueAtIteration, Base));
      if (!Offset)
	return false;
      SimplifiedAddress Address;
      Address.Base = Base->getValue();
      Address.Offset = Offset->getValue();
      SimplifiedAddresses[I] = Address;
      return true;
    }

    /// Base case for the instruction visitor.
    bool visitInstruction(Instruction &I) {
      return simplifyInstWithSCEV(&I);
    }

    /// Try to simplify binary operator I.
    ///
    /// TODO: Probably it's worth to hoist the code for estimating the
    /// simplifications effects to a separate class, since we have a very similar
    /// code in InlineCost already.
    bool visitBinaryOperator(BinaryOperator &I) {
      Value *LHS = I.getOperand(0), *RHS = I.getOperand(1);
      if (!isa<Constant>(LHS))
	if (Constant *SimpleLHS = SimplifiedValues.lookup(LHS))
	  LHS = SimpleLHS;
      if (!isa<Constant>(RHS))
	if (Constant *SimpleRHS = SimplifiedValues.lookup(RHS))
	  RHS = SimpleRHS;

      Value *SimpleV = nullptr;
      const DataLayout &DL = I.getModule()->getDataLayout();
      if (auto FI = dyn_cast<FPMathOperator>(&I))
	SimpleV =
          SimplifyFPBinOp(I.getOpcode(), LHS, RHS, FI->getFastMathFlags(), DL);
      else
	SimpleV = SimplifyBinOp(I.getOpcode(), LHS, RHS, DL);

      if (Constant *C = dyn_cast_or_null<Constant>(SimpleV))
	SimplifiedValues[&I] = C;

      if (SimpleV)
	return true;
      return Base::visitBinaryOperator(I);
    }

    /// Try to fold load I.
    bool visitLoad(LoadInst &I) {
      Value *AddrOp = I.getPointerOperand();

      auto AddressIt = SimplifiedAddresses.find(AddrOp);
      if (AddressIt == SimplifiedAddresses.end())
	return false;
      ConstantInt *SimplifiedAddrOp = AddressIt->second.Offset;

      auto *GV = dyn_cast<GlobalVariable>(AddressIt->second.Base);
      // We're only interested in loads that can be completely folded to a
      // constant.
      if (!GV || !GV->hasDefinitiveInitializer() || !GV->isConstant())
	return false;

      ConstantDataSequential *CDS =
        dyn_cast<ConstantDataSequential>(GV->getInitializer());
      if (!CDS)
	return false;

      // We might have a vector load from an array. FIXME: for now we just bail
      // out in this case, but we should be able to resolve and simplify such
      // loads.
      if(!CDS->isElementTypeCompatible(I.getType()))
	return false;

      int ElemSize = CDS->getElementType()->getPrimitiveSizeInBits() / 8U;
      assert(SimplifiedAddrOp->getValue().getActiveBits() < 64 &&
	     "Unexpectedly large index value.");
      int64_t Index = SimplifiedAddrOp->getSExtValue() / ElemSize;
      if (Index >= CDS->getNumElements()) {
	// FIXME: For now we conservatively ignore out of bound accesses, but
	// we're allowed to perform the optimization in this case.
	return false;
      }

      Constant *CV = CDS->getElementAsConstant(Index);
      assert(CV && "Constant expected.");
      SimplifiedValues[&I] = CV;

      return true;
    }

    bool visitCastInst(CastInst &I) {
      // Propagate constants through casts.
      Constant *COp = dyn_cast<Constant>(I.getOperand(0));
      if (!COp)
	COp = SimplifiedValues.lookup(I.getOperand(0));
      if (COp)
	if (Constant *C =
	    ConstantExpr::getCast(I.getOpcode(), COp, I.getType())) {
	  SimplifiedValues[&I] = C;
	  return true;
	}

      return Base::visitCastInst(I);
    }

    bool visitCmpInst(CmpInst &I) {
      Value *LHS = I.getOperand(0), *RHS = I.getOperand(1);

      // First try to handle simplified comparisons.
      if (!isa<Constant>(LHS))
	if (Constant *SimpleLHS = SimplifiedValues.lookup(LHS))
	  LHS = SimpleLHS;
      if (!isa<Constant>(RHS))
	if (Constant *SimpleRHS = SimplifiedValues.lookup(RHS))
	  RHS = SimpleRHS;

      if (!isa<Constant>(LHS) && !isa<Constant>(RHS)) {
	auto SimplifiedLHS = SimplifiedAddresses.find(LHS);
	if (SimplifiedLHS != SimplifiedAddresses.end()) {
	  auto SimplifiedRHS = SimplifiedAddresses.find(RHS);
	  if (SimplifiedRHS != SimplifiedAddresses.end()) {
	    SimplifiedAddress &LHSAddr = SimplifiedLHS->second;
	    SimplifiedAddress &RHSAddr = SimplifiedRHS->second;
	    if (LHSAddr.Base == RHSAddr.Base) {
	      LHS = LHSAddr.Offset;
	      RHS = RHSAddr.Offset;
	    }
	  }
	}
      }

      if (Constant *CLHS = dyn_cast<Constant>(LHS)) {
	if (Constant *CRHS = dyn_cast<Constant>(RHS)) {
	  if (Constant *C = ConstantExpr::getCompare(I.getPredicate(), CLHS, CRHS)) {
	    SimplifiedValues[&I] = C;
	    return true;
	  }
	}
      }

      return Base::visitCmpInst(I);
    }
  };
} // namespace


namespace {
  struct EstimatedUnrollCost {
    /// \brief The estimated cost after unrolling.
    int UnrolledCost;

    /// \brief The estimated dynamic cost of executing the instructions in the
    /// rolled form.
    int RolledDynamicCost;
  };
}


/// ApproximateLoopSize - Approximate the size of the loop.
static unsigned ApproximateLoopSize(const Loop *L, unsigned &NumCalls,
                                    bool &NotDuplicatable,
                                    const TargetTransformInfo &TTI,
                                    AssumptionCache *AC) {
  SmallPtrSet<const Value *, 32> EphValues;
  CodeMetrics::collectEphemeralValues(L, AC, EphValues);

  CodeMetrics Metrics;
  for (Loop::block_iterator I = L->block_begin(), E = L->block_end();
       I != E; ++I)
    Metrics.analyzeBasicBlock(*I, TTI, EphValues);
  NumCalls = Metrics.NumInlineCandidates;
  NotDuplicatable = Metrics.notDuplicatable;

  unsigned LoopSize = Metrics.NumInsts;

  // Don't allow an estimate of size zero.  This would allows unrolling of loops
  // with huge iteration counts, which is a compile time problem even if it's
  // not a problem for code quality. Also, the code using this size may assume
  // that each loop has at least three instructions (likely a conditional
  // branch, a comparison feeding that branch, and some kind of loop increment
  // feeding that comparison instruction).
  LoopSize = std::max(LoopSize, 3u);

  return LoopSize;
}

// Returns the loop hint metadata node with the given name (for example,
// "llvm.loop.unroll.count").  If no such metadata node exists, then nullptr is
// returned.
static MDNode *GetUnrollMetadataForLoop(const Loop *L, StringRef Name) {
  if (MDNode *LoopID = L->getLoopID())
    return GetUnrollMetadata(LoopID, Name);
  return nullptr;
}

// Returns true if the loop has an unroll(full) pragma.
static bool HasUnrollFullPragma(const Loop *L) {
  return GetUnrollMetadataForLoop(L, "llvm.loop.unroll.full");
}

// Returns true if the loop has an unroll(enable) pragma. This metadata is used
// for both "#pragma unroll" and "#pragma clang loop unroll(enable)" directives.
static bool HasUnrollEnablePragma(const Loop *L) {
  return GetUnrollMetadataForLoop(L, "llvm.loop.unroll.enable");
}

// Returns true if the loop has an unroll(disable) pragma.
static bool HasUnrollDisablePragma(const Loop *L) {
  return GetUnrollMetadataForLoop(L, "llvm.loop.unroll.disable");
}

// Returns true if the loop has an runtime unroll(disable) pragma.
static bool HasRuntimeUnrollDisablePragma(const Loop *L) {
  return GetUnrollMetadataForLoop(L, "llvm.loop.unroll.runtime.disable");
}

// If loop has an unroll_count pragma return the (necessarily
// positive) value from the pragma.  Otherwise return 0.
static unsigned UnrollCountPragmaValue(const Loop *L) {
  MDNode *MD = GetUnrollMetadataForLoop(L, "llvm.loop.unroll.count");
  if (MD) {
    assert(MD->getNumOperands() == 2 &&
           "Unroll count hint metadata should have two operands.");
    unsigned Count =
      mdconst::extract<ConstantInt>(MD->getOperand(1))->getZExtValue();
    assert(Count >= 1 && "Unroll count must be positive.");
    return Count;
  }
  return 0;
}

// Remove existing unroll metadata and add unroll disable metadata to
// indicate the loop has already been unrolled.  This prevents a loop
// from being unrolled more than is directed by a pragma if the loop
// unrolling pass is run more than once (which it generally is).
static void SetLoopAlreadyUnrolled(Loop *L) {
  MDNode *LoopID = L->getLoopID();
  if (!LoopID) return;

  // First remove any existing loop unrolling metadata.
  SmallVector<Metadata *, 4> MDs;
  // Reserve first location for self reference to the LoopID metadata node.
  MDs.push_back(nullptr);
  for (unsigned i = 1, ie = LoopID->getNumOperands(); i < ie; ++i) {
    bool IsUnrollMetadata = false;
    MDNode *MD = dyn_cast<MDNode>(LoopID->getOperand(i));
    if (MD) {
      const MDString *S = dyn_cast<MDString>(MD->getOperand(0));
      IsUnrollMetadata = S && S->getString().startswith("llvm.loop.unroll.");
    }
    if (!IsUnrollMetadata)
      MDs.push_back(LoopID->getOperand(i));
  }

  // Add unroll(disable) metadata to disable future unrolling.
  LLVMContext &Context = L->getHeader()->getContext();
  SmallVector<Metadata *, 1> DisableOperands;
  DisableOperands.push_back(MDString::get(Context, "llvm.loop.unroll.disable"));
  MDNode *DisableNode = MDNode::get(Context, DisableOperands);
  MDs.push_back(DisableNode);

  MDNode *NewLoopID = MDNode::get(Context, MDs);
  // Set operand 0 to refer to the loop id itself.
  NewLoopID->replaceOperandWith(0, NewLoopID);
  L->setLoopID(NewLoopID);
}

  

bool getConstantStringInfo(const Value *V, StringRef &Str) {

  // Look through bitcast instructions and geps.
  V = V->stripPointerCasts();
  // If the value is a GEP instruction or constant expression, treat it as an offset.
  if (const GEPOperator *GEP = dyn_cast<GEPOperator>(V)) {
    // Make sure the GEP has exactly three arguments.
    if (GEP->getNumOperands() != 3)
      return false;

    // Make sure the index-ee is a pointer to array of i8.
    PointerType *PT = cast<PointerType>(GEP->getOperand(0)->getType());
    ArrayType *AT = dyn_cast<ArrayType>(PT->getElementType());
    if (AT == 0 || !AT->getElementType()->isIntegerTy(8))
      return false;

    // Check to make sure that the first operand of the GEP is an integer and
    // has value 0 so that we are sure we're indexing into the initializer.
    const ConstantInt *FirstIdx = dyn_cast<ConstantInt>(GEP->getOperand(1));
    if (FirstIdx == 0 || !FirstIdx->isZero())
      return false;

    // If the second index isn't a ConstantInt, then this is a variable index
    // into the array.  If this occurs, we can't say anything meaningful about
    // the string.
    uint64_t StartIdx = 0;
    if (const ConstantInt *CI = dyn_cast<ConstantInt>(GEP->getOperand(2)))
      StartIdx = CI->getZExtValue();
    else
      return false;
  }

  // The GEP instruction, constant or instruction, must reference a global
  // variable that is a constant and is initialized. The referenced constant
  // initializer is the array that we'll use for optimization.
  const GlobalVariable *GV = dyn_cast<GlobalVariable>(V);
  if (!GV || !GV->isConstant() || !GV->hasDefinitiveInitializer())
    return false;

  // Handle the all-zeros case
  if (GV->getInitializer()->isNullValue()) {
    // This is a degenerate case. The initializer is constant zero so the
    // length of the string must be zero.
    Str = "";
    return true;
  }

  // Must be a Constant Array
  const ConstantDataArray *Array =
    dyn_cast<ConstantDataArray>(GV->getInitializer());

  if (Array == 0 || !Array->isString())
    return false;

  // Start out with the entire array in the StringRef.
  Str = Array->getAsString();
  return true;
}


std::string resolveOpenCalls(Value * fd){

  CallInst * callInst = dyn_cast<CallInst>(&*fd);
  if(callInst == NULL)
    return "";

  Function * f = callInst->getCalledFunction();
  std::string functionName = f->getName().str();
  if(functionName == "open" || functionName == "fopen"){
    Value * openMode = callInst->getOperand(1);
    if(functionName == "open"){
      if(ConstantInt * mode = dyn_cast<ConstantInt>(&*openMode)){
	if(mode->getZExtValue() != 0)
	  return "";
      }
    }
    else if (functionName == "fopen"){
      StringRef modeStr;
      getConstantStringInfo(openMode, modeStr);
      std::string mode = modeStr.str(); 
       
      if(strcmp(mode.c_str(), "r") != 0){
	if(debugPrint) errs()<<"!error: File mode not READ-ONLY \n";
	return "";
      }
      else{
	if(debugPrint) errs()<<"File is READ-ONLY \n";
      }
    }

    Value * fileNameOperand = callInst->getOperand(0);
    if(debugPrint) errs()<<"fileNameOperand = "<<*fileNameOperand<<"\n";
    if(Constant * constString = dyn_cast<Constant>(&*fileNameOperand)){
      if(debugPrint) errs()<<"File name : "<<*constString<<"\n";
      StringRef fileNameStr;
      getConstantStringInfo(fileNameOperand, fileNameStr);
      std::string fileName = fileNameStr.str();
      return fileName;
    }
    else{
      return ""; // fileName is not a constant
    }
  }

  return "";
}


static std::string getOpenFileName(CallInst * callInst){

  Function * f = callInst->getCalledFunction();
  std::string functionName = f->getName().str();
  Value * fd;

  if(functionName == "read"){
    fd = callInst->getOperand(0);
    return resolveOpenCalls(fd);     
  }
  else if(functionName == "fread" || functionName == "fread_unlocked"){
    // FIXIT: Assuming chunk size of 1 byte. 
    fd = callInst->getOperand(3);
    return resolveOpenCalls(fd);
  } 
  else if(functionName == "fgetc" || functionName == "getc"){
    fd = callInst->getOperand(0);
    return resolveOpenCalls(fd);
  }
  else if(functionName == "fgets"){
    fd = callInst->getOperand(2);
    if(debugPrint) errs()<<"resolving fgets "<<*fd<<"\n";
    return resolveOpenCalls(fd);
  }
   
  return "";
}


static int extractByteCount(CallInst * callInst){
  
  Function * f = callInst->getCalledFunction();
  std::string functionName = f->getName().str();

  if(functionName == "read" || functionName == "fread" || functionName == "fgets" || functionName == "fread_unlocked"){
    Value * byteCount;  
    if(functionName == "read"){
      byteCount = callInst->getOperand(2);  
    }
    if(functionName == "fread" || functionName == "fread_unlocked"){
      // FIXIT: Assuming chunk size of 1 byte. 
      byteCount = callInst->getOperand(2); 
    }
    if(functionName == "fgets"){
      byteCount = callInst->getOperand(1);  
    }

    if(ConstantInt * constInst = dyn_cast<ConstantInt>(&*byteCount)){
      int intByteCount = constInst->getZExtValue();
      return intByteCount;
    }
    else{
      return -1;
    }

  }
  else if(functionName == "fgetc" || functionName == "getc"){
    return 1; // These two functions only read one character at a time
  }

  return -1; // this should be unreachable given the outer condition is only true for FileIO functions
}


int countNewLine(FILE * fp){

  int newLineCount = 0;
  char line[100000];
  while(fgets(line, 100000, fp)) {
    newLineCount += 1;
  } 
  return newLineCount;
}

static bool tryToUnrollExplicit(Loop *L, DominatorTree &DT, LoopInfo *LI,
				ScalarEvolution *SE, const TargetTransformInfo &TTI,
				AssumptionCache &AC, bool PreserveLCSSA,
				Optional<unsigned> ProvidedCount,
				Optional<unsigned> ProvidedThreshold,
				Optional<bool> ProvidedAllowPartial,
				Optional<bool> ProvidedRuntime) {
  std::vector<BasicBlock*> basicBlocks = L->getBlocks();
  unsigned Count;
  bool unroll = false;
  for(unsigned long i = 0; i < basicBlocks.size(); i++) {    
    BasicBlock * BB = basicBlocks.at(i);
    if(LI->getLoopFor(BB) != L)
      continue;
    for(BasicBlock::iterator it = BB->begin(), it2 = BB->end(); it != it2; it++) {
      if(CallInst * callInst = dyn_cast<CallInst>(&*it)) {
        if(callInst != NULL && callInst->getCalledFunction() != NULL 
           && !callInst->getCalledFunction()->isIntrinsic()) {
          Function * callee = callInst->getCalledFunction();      
          std::string functionName = callee->getName().str();
          if(functionName == "unroll_loop" || functionName == "_Z11unroll_loopi") {
            if(ConstantInt * CI = dyn_cast<ConstantInt>(callInst->getArgOperand(0)))
              Count = CI->getZExtValue();
            else 
              continue;
            unroll = true;
          }
        }
      }
    }
  }
  if(!unroll)
    return false;

  if(debugPrint) errs() << "unrolling with count " << Count << "\n";
  if (!UnrollLoop(L, Count, Count, false, true, 0, LI, SE, &DT,
		  &AC, PreserveLCSSA))
    return false;
  return true;
}

static bool tryToUnrollGetoptLoop(Loop *L, DominatorTree &DT, LoopInfo *LI,
				  ScalarEvolution *SE, const TargetTransformInfo &TTI,
				  AssumptionCache &AC, bool PreserveLCSSA,
				  Optional<unsigned> ProvidedCount,
				  Optional<unsigned> ProvidedThreshold,
				  Optional<bool> ProvidedAllowPartial,
				  Optional<bool> ProvidedRuntime) {
  
  BasicBlock *Header = L->getHeader();
  bool unrollLoop = 0;
  CallInst * getoptCall;
  std::vector<BasicBlock*> basicBlocks = L->getBlocks();
  for(unsigned long i = 0; i < basicBlocks.size(); i++){    
    BasicBlock * BB = basicBlocks.at(i);
    for(BasicBlock::iterator it = BB->begin(), it2 = BB->end(); it != it2; it++){
      if(CallInst * callInst = dyn_cast<CallInst>(&*it)){
        if(callInst != NULL && callInst->getCalledFunction() != NULL 
           && !callInst->getCalledFunction()->isIntrinsic()){
          Function * callee = callInst->getCalledFunction();      
          std::string functionName = callee->getName().str();
	  if(functionName == "getopt_long" || functionName == "getopt") {
            getoptCall = callInst;        
            unrollLoop = 1;
            break;           
	  }
                    
	}
      }
    } 
  }

  bool PragmaFullUnroll = HasUnrollFullPragma(L);
  bool PragmaEnableUnroll = HasUnrollEnablePragma(L);
  unsigned PragmaCount = UnrollCountPragmaValue(L);
  bool HasPragma = PragmaFullUnroll;

  // FIXIT: Check if the loop is a nested loop with an fopen
  if(unrollLoop == 0 && !HasPragma){
    return false; // Did not unroll loop as the loop did not have any calls to libc file IO routines
  }
  char** argv = new char*[MaxArgs];
  int argc = parse_args(args, argv);
  unsigned int getopt_count = 0;
  int opt;
  std::string optstring;
  
  // FIXIT: value at index 2 might be an incorrect assumption
  Value * optstringOperand = getoptCall->getOperand(2);
  if(Constant * constString = dyn_cast<Constant>(&*optstringOperand)){        
    StringRef optstringRef;
    getConstantStringInfo(optstringOperand, optstringRef);
    optstring = optstringRef.str();
  }  

  if(debugPrint) errs() << optstring << " is optstring\n";
  while ((opt = getopt(argc, argv, optstring.c_str())) != -1) {
    getopt_count++;
  }

  if(debugPrint) errs() << "unrolling loop with count " << getopt_count << "\n";
  unsigned Count;  
  Count = getopt_count;
  if(debugPrint) errs()<<" Unroll Count = "<<Count<<"\n --- Unrolling --- \n";
  
  unsigned NumInlineCandidates;
  bool notDuplicatable;
  unsigned LoopSize =
    ApproximateLoopSize(L, NumInlineCandidates, notDuplicatable, TTI, &AC);
  DEBUG(dbgs() << "  Loop Size = " << LoopSize << "\n");

  if (notDuplicatable) {
    DEBUG(dbgs() << "  Not unrolling loop which contains non-duplicatable"
	  << " instructions.\n");
    return false;
  }
    
  // Skip unrolling loops that are explicitly disabled for unrolling via programmer-specified pragmas
  if(HasUnrollDisablePragma(L) || HasRuntimeUnrollDisablePragma(L)){
    return false;  
  }
   
  unsigned TripMultiple = 0;
  if (!UnrollLoop(L, Count, Count, false, true,
                  TripMultiple, LI, SE, &DT, &AC, PreserveLCSSA))
    return false;

  return true;
}


static bool tryToUnrollFileLoop(Loop *L, DominatorTree &DT, LoopInfo *LI,
				ScalarEvolution *SE, const TargetTransformInfo &TTI,
				AssumptionCache &AC, bool PreserveLCSSA,
				Optional<unsigned> ProvidedCount,
				Optional<unsigned> ProvidedThreshold,
				Optional<bool> ProvidedAllowPartial,
				Optional<bool> ProvidedRuntime) {
  
  BasicBlock *Header = L->getHeader();
  std::string lastFileName;
  int numFileCalls = 0; 
  int bytesRead = 0; // number of constant bytes read in one loop iteration
  bool fgetsCall = false; 
 
  std::vector<BasicBlock*> basicBlocks = L->getBlocks();

  for(unsigned long i = 0; i < basicBlocks.size(); i++){    
    BasicBlock * BB = basicBlocks.at(i);
    for(BasicBlock::iterator it = BB->begin(), it2 = BB->end(); it != it2; it++){
      if(CallInst * callInst = dyn_cast<CallInst>(&*it)){
        if(callInst != NULL && callInst->getCalledFunction() != NULL && !callInst->getCalledFunction()->isIntrinsic()){
     
          Function * callee = callInst->getCalledFunction();      
          
	  if(callee->getName().str() == "fread" || callee->getName().str() == "fread_unlocked" || callee->getName().str() == "read" || callee->getName().str() == "fgetc" || callee->getName().str() == "getc" || callee->getName().str() == "fgets"){     
            // FIXIT: Huge assumption, all read calls read from the same file (common case).
            // FIXIT: Add check for single file
            // FIXIT: Add check for read only files
	    std::string fileName = getOpenFileName(callInst);
            if(debugPrint) errs()<<"FileName : "<<fileName <<"\n";
            if(fileName == "" || (numFileCalls > 1 && fileName != lastFileName)) {
              errs()<<"!error: FileName could not be resolved or two files are being read in the loop body \n";
              return false;
	    }    
   
            lastFileName = fileName;
            int bytes = extractByteCount(callInst);
            if(bytes != -1)
              bytesRead += bytes;
            else{
	      if(debugPrint) errs()<<"!error: non-constant indexes \n";            
              return false; // the file is indexed using non constant indexes so unrolling doesnt reap anything
	    }
            
            if(callee->getName().str() == "fgets"){
              fgetsCall = true;
	    }           
            numFileCalls += 1;      
	  }         
	}
      }
    } 
  }

  bool PragmaFullUnroll = HasUnrollFullPragma(L);
  bool PragmaEnableUnroll = HasUnrollEnablePragma(L);
  unsigned PragmaCount = UnrollCountPragmaValue(L);
  bool HasPragma = PragmaFullUnroll;

  // FIXIT: Check if the loop is a nested loop with an fopen
  if(numFileCalls == 0 && !HasPragma){
    return false; // Did not unroll loop as the loop did not have any calls to libc file IO routines
  }


  int fileSize;
  int newLineCount;
  if (numFileCalls > 0){

    if(debugPrint) errs()<<"\n ----- Starting LoopUnroll ----  \n";
    FILE * fp = fopen(lastFileName.c_str(), "r");
    struct stat st;
    stat(lastFileName.c_str(), &st);
    fileSize = st.st_size;
    // If fgets called in the loop, extract the number of New Line characters
    if (fgetsCall){
      newLineCount = countNewLine(fp);  
    }

    if(debugPrint) errs()<<"-------newLineCount = "<<newLineCount<<"\n";
    if(debugPrint) errs()<<"FileSize : "<<fileSize <<" \n";  
  }


  unsigned Count;  
  if (fgetsCall){
    // ASSUMPTION: Buffer sizes to fgets are larger than line size (till New Line) 
    Count = newLineCount;
  }
  else if(numFileCalls > 0){
    Count = (fileSize / bytesRead) + 1;
  }
  else if(HasPragma){
    Count = PragmaCount;
  }

  if(debugPrint) errs()<<" Unroll Count = "<<Count<<"\n --- Unrolling --- \n";
  
  unsigned NumInlineCandidates;
  bool notDuplicatable;
  unsigned LoopSize =
    ApproximateLoopSize(L, NumInlineCandidates, notDuplicatable, TTI, &AC);
  DEBUG(dbgs() << "  Loop Size = " << LoopSize << "\n");

  if (notDuplicatable) {
    DEBUG(dbgs() << "  Not unrolling loop which contains non-duplicatable"
	  << " instructions.\n");
    return false;
  }
    
  // Skip unrolling loops that are explicitly disabled for unrolling via programmer-specified pragmas
  if(HasUnrollDisablePragma(L) || HasRuntimeUnrollDisablePragma(L)){
    return false;  
  }
   
  unsigned TripMultiple = 0;
  if (!UnrollLoop(L, Count, Count, false, true,
                  TripMultiple, LI, SE, &DT, &AC, PreserveLCSSA))
    return false;

  return true;
}

namespace {
  class LoopUnroll2 : public LoopPass {
  public:
    static char ID; // Pass ID, replacement for typeid
    LoopUnroll2(Optional<unsigned> Threshold = None,
		Optional<unsigned> Count = None,
		Optional<bool> AllowPartial = None, Optional<bool> Runtime = None)
      : LoopPass(ID), ProvidedCount(Count), ProvidedThreshold(Threshold),
        ProvidedAllowPartial(AllowPartial), ProvidedRuntime(Runtime) {
  
      //  initializeLoopUnrollPass(*PassRegistry::getPassRegistry());
    }

    Optional<unsigned> ProvidedCount;
    Optional<unsigned> ProvidedThreshold;
    Optional<bool> ProvidedAllowPartial;
    Optional<bool> ProvidedRuntime;

  
  
    bool runOnLoop(Loop *L, LPPassManager &) override {   

      if (skipOptnoneFunction(L))
	return false;
 
      Function &F = *L->getHeader()->getParent();
      auto &DT = getAnalysis<DominatorTreeWrapperPass>().getDomTree();
      LoopInfo *LI = &getAnalysis<LoopInfoWrapperPass>().getLoopInfo();
      ScalarEvolution *SE = &getAnalysis<ScalarEvolutionWrapperPass>().getSE();
      const TargetTransformInfo &TTI =
        getAnalysis<TargetTransformInfoWrapperPass>().getTTI(F);
      auto &AC = getAnalysis<AssumptionCacheTracker>().getAssumptionCache(F);
      bool PreserveLCSSA = mustPreserveAnalysisID(LCSSAID);
      bool getoptUnroll = tryToUnrollGetoptLoop(L, DT, LI, SE, TTI, AC, PreserveLCSSA, ProvidedCount,
						ProvidedThreshold, ProvidedAllowPartial,
						ProvidedRuntime);
      bool explicitUnroll = tryToUnrollExplicit(L, DT, LI, SE, TTI, AC, PreserveLCSSA,
						ProvidedCount, ProvidedThreshold, ProvidedAllowPartial,
						ProvidedRuntime);    
      // bool fileUnroll = tryToUnrollFileLoop(L, DT, LI, SE, TTI, AC, PreserveLCSSA, ProvidedCount,
      //                        ProvidedThreshold, ProvidedAllowPartial,
      //                        ProvidedRuntime);

      return getoptUnroll | explicitUnroll;
    }

    /// This transformation requires natural loop information & requires that
    /// loop preheaders be inserted into the CFG...
    ///
    void getAnalysisUsage(AnalysisUsage &AU) const override {
      AU.addRequired<AssumptionCacheTracker>();
      AU.addRequired<DominatorTreeWrapperPass>();
      AU.addRequired<LoopInfoWrapperPass>();
      AU.addPreserved<LoopInfoWrapperPass>();
      AU.addRequiredID(LoopSimplifyID);
      AU.addPreservedID(LoopSimplifyID);
      AU.addRequiredID(LCSSAID);
      AU.addPreservedID(LCSSAID);
      AU.addRequired<ScalarEvolutionWrapperPass>();
      AU.addPreserved<ScalarEvolutionWrapperPass>();
      AU.addRequired<TargetTransformInfoWrapperPass>();
      // FIXME: Loop unroll requires LCSSA. And LCSSA requires dom info.
      // If loop unroll does not preserve dom info then LCSSA pass on next
      // loop will receive invalid dom info.
      // For now, recreate dom info, if loop is unrolled.
      AU.addPreserved<DominatorTreeWrapperPass>();
      AU.addPreserved<GlobalsAAWrapperPass>();
    }
  };
}

char LoopUnroll2::ID = 0;
//INITIALIZE_PASS_BEGIN(LoopUnroll2, "loop-unroll2", "Unroll loops", false, false)
//INITIALIZE_PASS_DEPENDENCY(TargetTransformInfoWrapperPass)
//INITIALIZE_PASS_DEPENDENCY(AssumptionCacheTracker)
//INITIALIZE_PASS_DEPENDENCY(DominatorTreeWrapperPass)
//INITIALIZE_PASS_DEPENDENCY(LoopInfoWrapperPass)
//INITIALIZE_PASS_DEPENDENCY(LoopSimplify)
//INITIALIZE_PASS_DEPENDENCY(LCSSA)
//INITIALIZE_PASS_DEPENDENCY(ScalarEvolutionWrapperPass)
//INITIALIZE_PASS_END(LoopUnroll2, "loop-unroll2", "Unroll loops", false, false)

Pass *llvm::createLoopUnrollPass(int Threshold, int Count, int AllowPartial,
                                 int Runtime) {
  // TODO: It would make more sense for this function to take the optionals
  // directly, but that's dangerous since it would silently break out of tree
  // callers.
  return new LoopUnroll2(Threshold == -1 ? None : Optional<unsigned>(Threshold),
			 Count == -1 ? None : Optional<unsigned>(Count),
			 AllowPartial == -1 ? None
			 : Optional<bool>(AllowPartial),
			 Runtime == -1 ? None : Optional<bool>(Runtime));
}

Pass *llvm::createSimpleLoopUnrollPass() {
  return llvm::createLoopUnrollPass(-1, -1, 0, 0);
}


static RegisterPass<LoopUnroll2> X("loop-unroll2", "Custom loop unroll Pass", false, false);

