#include "VecUtils.h"
#include "Debug.h"

using namespace llvm;
using namespace std;

uint64_t binarySearchIndices(vector<uint64_t> indices, uint64_t lo, uint64_t hi, uint64_t val) {
  debug(Usama) << "lo =" << lo << " high=" << hi << "\n";
  assert(hi < indices.size() && lo < indices.size());
  if(indices.size() == 1) return indices[0];
  uint64_t mid = lo + (hi - lo)/2;
  if(indices[mid] <= val && (indices.size() - 1 == mid || indices[mid + 1] > val)) return indices[mid];
  else if(indices[mid] > val) return binarySearchIndices(indices, lo, mid > 0 ? mid - 1: 0, val);
  else return binarySearchIndices(indices, mid + 1, hi, val);
}

/*int64_t binarySearchIndices(vector<unsigned> indices, int64_t lo, int64_t hi, unsigned val) {
  debug(Usama) << "lo =" << lo << " high=" << hi << "\n";
  assert(hi < indices.size() && lo < indices.size());
  //if(indices.size() == 1) return indices[0];
  if(hi <= lo) {
    return indices[lo] == val ? indices[val] : -1;
  }
  unsigned mid = lo + (hi - lo)/2;
  if(indices[mid] <= val && (indices.size() - 1 == mid || indices[mid + 1] > val)) return indices[mid];
  else if(indices[mid] > val) return binarySearchIndices(indices, lo, mid - 1, val);
  else return binarySearchIndices(indices, mid + 1, hi, val);
}*/
