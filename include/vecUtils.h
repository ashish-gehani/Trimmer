using namespace std;
using namespace llvm;

#ifndef VEC_UTILS_H_
#define VEC_UTILS_H_

template <typename F>
bool findInVect(vector<F> & vect, F val) {
  return find(vect.begin(), vect.end(), val) != vect.end();
}

template <typename F>
bool findInVect(SmallVector<F, 16> vect, F val) {
  for(unsigned i = 0; i < vect.size(); i++) {
    if(vect[i] == val)
      return true;
  }
  return false;
}

template <typename F>
int findIndex(vector<F> & vect, F val) {
  for(unsigned i = 0; i < vect.size(); i++) {
    if(vect[i] == val)
      return i;
  }
  return -1;
}

template <typename F>
void InsertUnique(vector<F> & vect, F val) {
  if(!findInVect(vect, val))
    vect.push_back(val);
}

template <typename F>
void InsertUnique(vector<F> & vect1, vector<F> vect2) {
  for(unsigned i = 0; i < vect2.size(); i++)
    InsertUnique(vect1, vect2[i]);
}

unsigned binarySearchIndices(vector<unsigned> indices, unsigned lo, unsigned hi, unsigned val) {
  
  assert(hi < indices.size() && lo < indices.size());
  if(indices.size() == 1) return indices[0];
  unsigned mid = lo + (hi - lo)/2;
  if(indices[mid] <= val && (indices.size() - 1 == mid || indices[mid + 1] > val)) return indices[mid];
  else if(indices[mid] > val) return binarySearchIndices(indices, lo, mid - 1, val);
  else return binarySearchIndices(indices, mid + 1, hi, val);
}
template <typename ty1, typename ty2>
map<ty1, ty2 *> duplicateMap(map<ty1, ty2 *> oldMap) {
  map<ty1, ty2 *> newMap;
  for(auto const &ent : oldMap) {
    newMap[ent.first] = new ty2(*ent.second);
  }
  return oldMap;
}
#endif