

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
#include <unistd.h> 
#include "parse_args.h"

using namespace llvm;
using namespace std;


#define debugPrint 0

static cl::opt<string> args("args",
			    cl::desc("' ' space seperated argument list"));

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
    bool runOnModule(Module& M) override {
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
        auto &AC = getAnalysis<AssumptionCacheTracker>().getAssumptionCache(*F);
        for(Function::iterator b = F->begin(), e = F->end(); b != e; ++b) {
          BasicBlock * BB = &*b;
          if(Loop * L = LI.getLoopFor(BB)) {
            errs() << "found loop\n";
            if(!UnrollLoop(L, 10, 10, false, true, 0, &LI, SE, DT,
              &AC, PreserveLCSSA)) {
              errs() << "failed to unroll\n";
              return false;
            } else { 
              errs() << "succeeded in unrolling\n";
              return true;
            }
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
