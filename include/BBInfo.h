/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

// This file consists of a structure BBInfo, which stores information about a particular Basic Block.

#include "llvm/IR/BasicBlock.h"

#ifndef BBINFO_H_
#define BBINFO_H_

using namespace std;
using namespace llvm;


struct BBInfo {
  bool writesToMemory, partOfLoop, isHeader;
  unsigned numPreds, URfrom, Rfrom;
  vector<BasicBlock *> loopLatchesWithEdge, ancestors;
  BasicBlock * singleSucc;
  BasicBlock *BB;

  BBInfo(BasicBlock * basicBlock) {
    writesToMemory = partOfLoop = isHeader = false;
    URfrom = numPreds = Rfrom = 0;
    BB = basicBlock;
    singleSucc = NULL;    
    calculateNumPreds();
  }

  void calculateNumPreds() {
    set<BasicBlock *> preds;
    for(auto it = pred_begin(BB), et = pred_end(BB); it != et; it++) {
      BasicBlock * predecessor = *it;
      if(preds.find(predecessor) == preds.end()) {
        numPreds++;
        preds.insert(predecessor);
      }
    }
  }
};
#endif
