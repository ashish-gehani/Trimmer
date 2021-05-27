// Copyright (c) 2020 SRI International All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/*This file contains binarySearchIndices function which is used to search for starting address of a particular byte location in the stack or heap 
as the memory is byte-wise arranged (See include/Mem.h). Vector indices contains indices of the starting addresses of the global variables or allocas.*/  

#include "VecUtils.h"
#include "Debug.h"

using namespace llvm;
using namespace std;

uint64_t binarySearchIndices(vector<uint64_t> indices, uint64_t lo, uint64_t hi, uint64_t val) {
  debug(Yes) << "lo =" << lo << " high=" << hi << "\n";
  assert(hi < indices.size() && lo < indices.size());
  if(indices.size() == 1) return indices[0];
  uint64_t mid = lo + (hi - lo)/2;
  if(indices[mid] <= val && (indices.size() - 1 == mid || indices[mid + 1] > val)) return indices[mid];
  else if(indices[mid] > val) return binarySearchIndices(indices, lo, mid > 0 ? mid - 1: 0, val);
  else return binarySearchIndices(indices, mid + 1, hi, val);
}


