#include "VecUtils.h"

using namespace llvm;
using namespace std;

unsigned binarySearchIndices(vector<unsigned> indices, unsigned lo, unsigned hi, unsigned val) {
  assert(hi < indices.size() && lo < indices.size());
  if(indices.size() == 1) return indices[0];
  unsigned mid = lo + (hi - lo)/2;
  if(indices[mid] <= val && (indices.size() - 1 == mid || indices[mid + 1] > val)) return indices[mid];
  else if(indices[mid] > val) return binarySearchIndices(indices, lo, mid - 1, val);
  else return binarySearchIndices(indices, mid + 1, hi, val);
}
