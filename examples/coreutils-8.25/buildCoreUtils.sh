#!/bin/bash
export PATH=~/Phd_Sem4/SRI/whole-program-llvm/:$PATH
export LLVM_COMPILER=clang
make
extract-bc src/cksum
