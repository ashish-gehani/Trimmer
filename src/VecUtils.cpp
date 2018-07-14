#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Analysis/InstructionSimplify.h"
#include "llvm/Analysis/ConstantFolding.h"
#include "llvm/IR/Module.h"
#include "llvm/Analysis/CallGraph.h"
#include "llvm/IR/Instruction.h"	
#include "llvm/IR/Instructions.h"
#include "llvm/IR/GlobalValue.h"
#include "llvm/IR/GlobalVariable.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Operator.h"
#include "llvm/Analysis/MemoryDependenceAnalysis.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/Transforms/Utils/SimplifyLibCalls.h"
#include "llvm/Analysis/TargetLibraryInfo.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/ValueMap.h"
#include "llvm/Transforms/Utils/Cloning.h"

#include <unistd.h>
#include <sys/stat.h>
#include <map>
#include <set>
#include <iostream>
#include <vector>
#include <map>
#include <fstream>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <sstream>
#include <fcntl.h>


#include "VecUtils.h"

using namespace std;
using namespace llvm;

template <typename Ty>
bool findInVect(vector<Ty> & vect, Ty val) {
  return find(vect.begin(), vect.end(), val) != vect.end();
}

template <typename Ty>
bool findInVect(SmallVector<Ty, 16> vect, Ty val) {
  for(unsigned i = 0; i < vect.size(); i++) {
    if(vect[i] == val)
      return true;
  }
  return false;
}

template <typename Ty>
int findIndex(vector<Ty> & vect, Ty val) {
  for(unsigned i = 0; i < vect.size(); i++) {
    if(vect[i] == val)
      return i;
  }
  return -1;
}

template <typename Ty>
void InsertUnique(vector<Ty> & vect, Ty val) {
  if(!findInVect(vect, val))
    vect.push_back(val);
}

template <typename Ty>
void InsertUnique(vector<Ty> & vect1, vector<Ty> vect2) {
  for(unsigned i = 0; i < vect2.size(); i++)
    InsertUnique(vect1, vect2[i]);
}
template <typename Ty>
void push_back(vector<Ty> & vect) {
  Ty val;
  vect.push_back(val);
}
template <typename Ty>
Ty pop_back(vector<Ty> & vect) {
  Ty val = vect[vect.size() - 1];
  vect.pop_back();
  return val;
}
template <typename Ty>
bool findInSet(set<Ty> valSet, Ty key) {
  return valSet.find(key) != valSet.end();
}
template <typename Ty1, typename Ty2>
bool findInMap(map<Ty1, Ty2> valMap, Ty1 key) {
  return valMap.find(key) != valMap.end();
}
template <typename Ty1, typename Ty2>
map<Ty1, Ty2 *> duplicateMap(map<Ty1, Ty2 *> oldMap) {
  map<Ty1, Ty2 *> newMap;
  for(auto const &ent : oldMap) {
    newMap[ent.first] = new Ty2(*ent.second);
  }
  return oldMap;
}
unsigned binarySearchIndices(vector<unsigned> indices, unsigned lo, unsigned hi, unsigned val) {
  assert(hi < indices.size() && lo < indices.size());
  if(indices.size() == 1) return indices[0];
  unsigned mid = lo + (hi - lo)/2;
  if(indices[mid] <= val && (indices.size() - 1 == mid || indices[mid + 1] > val)) return indices[mid];
  else if(indices[mid] > val) return binarySearchIndices(indices, lo, mid - 1, val);
  else return binarySearchIndices(indices, mid + 1, hi, val);
}
