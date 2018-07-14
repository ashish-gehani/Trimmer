#ifndef STD_UTILS__
#define STD_UTILS__

#include <vector>
#include <map>
#include <set>
#include "llvm/ADT/SmallVector.h"

using namespace std;
using namespace llvm;

template <typename Ty>
bool findInVect(vector<Ty> & vect, Ty val); 

template <typename Ty>
bool findInVect(SmallVector<Ty, 16> vect, Ty val); 

template <typename Ty>
int findIndex(vector<Ty> & vect, Ty val); 

template <typename Ty>
void InsertUnique(vector<Ty> & vect, Ty val); 

template <typename Ty>
void InsertUnique(vector<Ty> & vect1, vector<Ty> vect2); 
template <typename Ty>
void push_back(vector<Ty> & vect); 
template <typename Ty>
Ty pop_back(vector<Ty> & vect);
template <typename Ty>
bool findInSet(set<Ty> valSet, Ty key); 
template <typename Ty1, typename Ty2>
bool findInMap(map<Ty1, Ty2> valMap, Ty1 key); 
template <typename Ty1, typename Ty2>
map<Ty1, Ty2 *> duplicateMap(map<Ty1, Ty2 *> oldMap); 
unsigned binarySearchIndices(vector<unsigned> indices, unsigned lo, unsigned hi, unsigned val); 
#endif
