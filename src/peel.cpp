//===-- UnrollLoopPeel.cpp - Loop peeling utilities -----------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file implements some loop unrolling utilities for peeling loops
// with dynamically inferred (from PGO) trip counts. See LoopUnroll.cpp for
// unrolling loops with compile-time constant trip counts.
//
//===----------------------------------------------------------------------===//

#include "llvm/ADT/Statistic.h"
#include "llvm/Analysis/LoopIterator.h"
#include "llvm/Analysis/LoopPass.h"
#include "llvm/Analysis/ScalarEvolution.h"
#include "llvm/Analysis/TargetTransformInfo.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/MDBuilder.h"
#include "llvm/IR/Metadata.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/Scalar.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Transforms/Utils/Cloning.h"
#include "llvm/Transforms/Utils/LoopUtils.h"
#include "llvm/Transforms/Utils/UnrollLoop.h"
#include <algorithm>

using namespace llvm;

#define DEBUG_TYPE "loop-unroll"
STATISTIC(NumPeeled, "Number of loops peeled");

static cl::opt<unsigned> UnrollPeelMaxCount(
    "unroll-peel-max-count", cl::init(7), cl::Hidden,
    cl::desc("Max average trip count which will cause loop peeling."));

static cl::opt<unsigned> UnrollForcePeelCount(
    "unroll-force-peel-count", cl::init(0), cl::Hidden,
    cl::desc("Force a peel count regardless of profiling information."));


bool peelLoop(Loop *L, unsigned PeelCount, LoopInfo *LI,
                    ScalarEvolution *SE, DominatorTree *DT,
                    AssumptionCache *AC, bool PreserveLCSSA) {
  if (!canPeel(L))
    return false;

  LoopBlocksDFS LoopBlocks(L);
  LoopBlocks.perform(LI);

  BasicBlock *Header = L->getHeader();
  BasicBlock *PreHeader = L->getLoopPreheader();
  BasicBlock *Latch = L->getLoopLatch();
  BasicBlock *Exit = L->getUniqueExitBlock();

  Function *F = Header->getParent();

  // Set up all the necessary basic blocks. It is convenient to split the
  // preheader into 3 parts - two blocks to anchor the peeled copy of the loop
  // body, and a new preheader for the "real" loop.

  // Peeling the first iteration transforms.
  //
  // PreHeader:
  // ...
  // Header:
  //   LoopBody
  //   If (cond) goto Header
  // Exit:
  //
  // into
  //
  // InsertTop:
  //   LoopBody
  //   If (!cond) goto Exit
  // InsertBot:
  // NewPreHeader:
  // ...
  // Header:
  //  LoopBody
  //  If (cond) goto Header
  // Exit:
  //
  // Each following iteration will split the current bottom anchor in two,
  // and put the new copy of the loop body between these two blocks. That is,
  // after peeling another iteration from the example above, we'll split 
  // InsertBot, and get:
  //
  // InsertTop:
  //   LoopBody
  //   If (!cond) goto Exit
  // InsertBot:
  //   LoopBody
  //   If (!cond) goto Exit
  // InsertBot.next:
  // NewPreHeader:
  // ...
  // Header:
  //  LoopBody
  //  If (cond) goto Header
  // Exit:

  BasicBlock *InsertTop = SplitEdge(PreHeader, Header, DT, LI);
  BasicBlock *InsertBot =
      SplitBlock(InsertTop, InsertTop->getTerminator(), DT, LI);
  BasicBlock *NewPreHeader =
      SplitBlock(InsertBot, InsertBot->getTerminator(), DT, LI);

  InsertTop->setName(Header->getName() + ".peel.begin");
  InsertBot->setName(Header->getName() + ".peel.next");
  NewPreHeader->setName(PreHeader->getName() + ".peel.newph");

  ValueToValueMapTy LVMap;

  // If we have branch weight information, we'll want to update it for the
  // newly created branches.
  BranchInst *LatchBR =
      cast<BranchInst>(cast<BasicBlock>(Latch)->getTerminator());
  unsigned HeaderIdx = (LatchBR->getSuccessor(0) == Header ? 0 : 1);

  uint64_t TrueWeight, FalseWeight;
  uint64_t ExitWeight = 0, CurHeaderWeight = 0;
  if (LatchBR->extractProfMetadata(TrueWeight, FalseWeight)) {
    ExitWeight = HeaderIdx ? TrueWeight : FalseWeight;
    // The # of times the loop body executes is the sum of the exit block
    // weight and the # of times the backedges are taken.
    CurHeaderWeight = TrueWeight + FalseWeight;
  }

  // For each peeled-off iteration, make a copy of the loop.
  for (unsigned Iter = 0; Iter < PeelCount; ++Iter) {
    SmallVector<BasicBlock *, 8> NewBlocks;
    ValueToValueMapTy VMap;

    // Subtract the exit weight from the current header weight -- the exit
    // weight is exactly the weight of the previous iteration's header.
    // FIXME: due to the way the distribution is constructed, we need a
    // guard here to make sure we don't end up with non-positive weights.
    if (ExitWeight < CurHeaderWeight)
      CurHeaderWeight -= ExitWeight;
    else
      CurHeaderWeight = 1;

    cloneLoopBlocks(L, Iter, InsertTop, InsertBot, Exit,
                    NewBlocks, LoopBlocks, VMap, LVMap, DT, LI);

    // Remap to use values from the current iteration instead of the
    // previous one.
    remapInstructionsInBlocks(NewBlocks, VMap);

    if (DT) {
      // Latches of the cloned loops dominate over the loop exit, so idom of the
      // latter is the first cloned loop body, as original PreHeader dominates
      // the original loop body.
      if (Iter == 0)
        DT->changeImmediateDominator(Exit, cast<BasicBlock>(LVMap[Latch]));
#ifndef NDEBUG
      if (VerifyDomInfo)
        DT->verifyDomTree();
#endif
    }

    updateBranchWeights(InsertBot, cast<BranchInst>(VMap[LatchBR]), Iter,
                        PeelCount, ExitWeight);

    InsertTop = InsertBot;
    InsertBot = SplitBlock(InsertBot, InsertBot->getTerminator(), DT, LI);
    InsertBot->setName(Header->getName() + ".peel.next");

    F->getBasicBlockList().splice(InsertTop->getIterator(),
                                  F->getBasicBlockList(),
                                  NewBlocks[0]->getIterator(), F->end());
  }

  // Now adjust the phi nodes in the loop header to get their initial values
  // from the last peeled-off iteration instead of the preheader.
  for (BasicBlock::iterator I = Header->begin(); isa<PHINode>(I); ++I) {
    PHINode *PHI = cast<PHINode>(I);
    Value *NewVal = PHI->getIncomingValueForBlock(Latch);
    Instruction *LatchInst = dyn_cast<Instruction>(NewVal);
    if (LatchInst && L->contains(LatchInst))
      NewVal = LVMap[LatchInst];

    PHI->setIncomingValue(PHI->getBasicBlockIndex(NewPreHeader), NewVal);
  }

  // Adjust the branch weights on the loop exit.
  if (ExitWeight) {
    // The backedge count is the difference of current header weight and
    // current loop exit weight. If the current header weight is smaller than
    // the current loop exit weight, we mark the loop backedge weight as 1.
    uint64_t BackEdgeWeight = 0;
    if (ExitWeight < CurHeaderWeight)
      BackEdgeWeight = CurHeaderWeight - ExitWeight;
    else
      BackEdgeWeight = 1;
    MDBuilder MDB(LatchBR->getContext());
    MDNode *WeightNode =
        HeaderIdx ? MDB.createBranchWeights(ExitWeight, BackEdgeWeight)
                  : MDB.createBranchWeights(BackEdgeWeight, ExitWeight);
    LatchBR->setMetadata(LLVMContext::MD_prof, WeightNode);
  }

  // If the loop is nested, we changed the parent loop, update SE.
  if (Loop *ParentLoop = L->getParentLoop()) {
    SE->forgetLoop(ParentLoop);

    // FIXME: Incrementally update loop-simplify
    simplifyLoop(ParentLoop, DT, LI, SE, AC, PreserveLCSSA);
  } else {
    // FIXME: Incrementally update loop-simplify
    simplifyLoop(L, DT, LI, SE, AC, PreserveLCSSA);
  }

  NumPeeled++;

  return true;
}
