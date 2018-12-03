#include "llvm/IR/BasicBlock.h"
#include "Mem.h"

#ifndef CONTEXTINFO_H_
#define CONTEXTINFO_H_

using namespace std;
using namespace llvm;

/*
 * Each basic block is allocated a ContextInfo structure 
 * which keeps track of its current Instruction iterator
 * and contains its copy of shadow memory.  
 * Except for the entry basic block of the program, the basic blocks
 * may be allocated by two main operations
 * 1. imaging from parent - Both blocks share the same memory
 * 2. duplicating from parent - Both blocks share different memories and at the start of
 * the execution of the child, its memory is a copy of parent's memory
 * We prefer imaging if, as a result of constant propagation, there is no ambiguity about
 * the parent's successor and no ambiguity about the child's successor
 * e.g.
 * 
 * BB0 int a = 5;
 * switch(a) { 
 *      case '1':
 *      case '2':
 *      case '3':
 *      case '4':
 * BB5   case '5':
 * }
 * BB6
 *
 * before inter-const-prop
 * BB0 -> 5 successors
 * BB5 -> 1 predecessor, 1 successor
 * BB6 -> has 5 predecessors
 *
 * During inter-const-prop
 * BB0 -> BB5 : image because BB0 successors folded
 * BB5 -> BB6 : image because BB6 predecessors folded
 *
 * if there was ambiguity in the switch statement we would have duplicated on both these occasions
 */

struct ContextInfo {
  Memory * memory;
  BasicBlock::iterator inst;
  ContextInfo * imageOf;  
  bool deleted;

  ContextInfo();
  ContextInfo(Module * M);
  ContextInfo * image();
  ContextInfo * duplicate();
};
#endif
