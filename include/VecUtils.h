#ifndef STD_UTILS__
#define STD_UTILS__

#include <map>
#include <set>
#include <vector>
#include "llvm/ADT/SmallVector.h"


using namespace std;
using namespace llvm;

template <typename Ty>
bool findInVect(vector<Ty> & vect, Ty val) {
  return find(vect.begin(), vect.end(), val) != vect.end();
}

template <typename Ty>
bool findInVect(SmallVector<Ty, 16> &vect, Ty val) {
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
bool findInSet(set<Ty> &valSet, Ty key) {
  return valSet.find(key) != valSet.end();
}
template <typename Ty1, typename Ty2>
bool findInMap(map<Ty1, Ty2> &valMap, Ty1 key) {
  return valMap.find(key) != valMap.end();
}
template <typename Ty1, typename Ty2>
map<Ty1, Ty2 *> duplicateMap(map<Ty1, Ty2 *> &oldMap) {
  map<Ty1, Ty2 *> newMap;
  for(auto const &ent : oldMap) {
    newMap[ent.first] = new Ty2(*ent.second);
  }
  return oldMap;
}
uint64_t binarySearchIndices(vector<uint64_t> indices, uint64_t lo, uint64_t hi, uint64_t val);
#endif
