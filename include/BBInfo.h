#include "llvm/IR/BasicBlock.h"

#ifndef BBINFO_H_
#define BBINFO_H_

using namespace std;
using namespace llvm;

/*
 * structure keeping track of basic BB info   
 */

struct BBInfo {
  bool writesToMemory, partOfLoop, isHeader;
  unsigned numPreds, URfrom, Rfrom;
  vector<BasicBlock *> loopLatchesWithEdge, ancestors;
  BasicBlock * singleSucc;
  BBInfo(BasicBlock * BB) {
    writesToMemory = partOfLoop = isHeader = false;
    URfrom = numPreds = Rfrom = 0;
    singleSucc = NULL;
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
