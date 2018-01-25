#include "llvm/Transforms/Scalar.h"
#include "llvm/ADT/SetVector.h"
#include "llvm/Analysis/GlobalsModRef.h"
#include "llvm/Analysis/CodeMetrics.h"
#include "llvm/Analysis/InstructionSimplify.h"
#include "llvm/Analysis/LoopPass.h"
#include "llvm/Analysis/AssumptionCache.h"
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
#include "llvm/Analysis/OptimizationDiagnosticInfo.h"
#include "llvm/Transforms/Utils/UnrollLoop.h"
#include "llvm/Transforms/Utils/Cloning.h"
#include <climits>
#include <sys/stat.h>
#include <unistd.h> 
#include <unistd.h> 
#include "parse_args.h"

using namespace llvm;
using namespace std;

#define debugPrint 0

static cl::opt<string> args("args",
			    cl::desc("' ' space seperated argument list"));

struct UnrollInfo {
  TerminatorInst * from;
  TerminatorInst * end; // if evaluates to false we have failed to break the loop
  vector<BasicBlock *> clonedBlocks;
};

namespace {
  struct Unroll : public ModulePass {
    static char ID;
    Unroll() : ModulePass(ID) {}
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

    vector<BasicBlock *> cloneLoop(Loop * L) {
      ValueToValueMapTy VMap;
      vector<BasicBlock *> clonedBlocks;
      for(auto block : L->blocks()) {
        BasicBlock * BB = &*block;
        BasicBlock * clone = CloneBasicBlock(BB, VMap, "");        
        VMap[BB] = clone;
        clonedBlocks.push_back(clone);
      }
      for(unsigned i = 0; i < clonedBlocks.size(); i++) {
        BasicBlock * clone = clonedBlocks[i];
        for(auto inst = clone->begin(); inst != clone->end(); inst++) {
          Instruction * I = &*(inst);
          errs() << *I << "\n";
          for(unsigned j = 0; j < I->getNumOperands(); j++) {
            if(PHINode * phi = dyn_cast<PHINode>(I)) {
              BasicBlock * BB = phi->getIncomingBlock(j);
              BB->printAsOperand(errs(), false);
              errs() << "\n";
              if(VMap.find(BB) != VMap.end()) 
                phi->setIncomingBlock(j, dyn_cast<BasicBlock>(VMap[BB]));
              continue;
            }
            Value * val = I->getOperand(j);
            if(BasicBlock * BB = dyn_cast<BasicBlock>(val)) {
              BB->printAsOperand(errs(), false);
              errs() << "\n";
              if(VMap.find(BB) != VMap.end()) 
                I->setOperand(j, VMap[BB]);
            }
          }
        }
      }
      errs() << "--------------- cloned blocks ---------------\n";
      for(unsigned i = 0; i < clonedBlocks.size(); i++)
        errs() << *clonedBlocks[i] << "\n";
      errs() << "                *************                 \n";
      return clonedBlocks;
    }
    bool runOnModule(Module& M) override {
      errs() << "running unroller\n";
      bool PreserveLCSSA = mustPreserveAnalysisID(LCSSAID);
      for (Module::iterator mit = M.getFunctionList().begin(); 
        mit != M.getFunctionList().end(); ++mit) {
        Function * F = &*mit;
        if(F->isDeclaration())
          continue;
        errs() << "running on " << F->getName() << "\n";
        LoopInfo &LI = getAnalysis<LoopInfoWrapperPass>(*F).getLoopInfo();
        ScalarEvolution * SE = &getAnalysis<ScalarEvolutionWrapperPass>(*F).getSE();
        DominatorTree * DT = new DominatorTree(*F);
        OptimizationRemarkEmitter ORE(F); 
        AssumptionCache &AC = getAnalysis<AssumptionCacheTracker>(*F).getAssumptionCache(*F);
        for(Function::iterator b = F->begin(), e = F->end(); b != e; ++b) {
          BasicBlock * BB = &*b;
          if(Loop * L = LI.getLoopFor(BB)) {
            // BasicBlock * ph = L->getLoopPreheader();
            int UnrollResult = UnrollLoop(L, 4, 4, true, true, true, 
            true, false, 1, 0, &LI, SE, DT, &AC, &ORE, PreserveLCSSA);
            errs() << UnrollResult << "\n";
            return false;
            // bool peeled = peelLoop(L, 10, &LI, SE, DT, PreserveLCSSA);
            // if(!peeled) {
            //   errs() << "failed to unroll\n";
            //   return false;
            // } else {
            //   errs() << ph << " is old preheader\n"; 
            //   for (Function::iterator f_it = F->begin(), f_ite = F->end(); 
            //     f_it != f_ite; ++f_it) {
            //     BasicBlock * b = &*f_it;
            //     errs() << b << "\n";
            //     errs() << *b << "\n";
            //   }
            //   errs() << "succeeded in unrolling\n";
            //   return true;
            // }
          }
        }     
      }
      return false;
    }
  };
}
char Unroll::ID = 0;
static RegisterPass<Unroll>
W("unroll", "Argument Specialization");
