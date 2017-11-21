#!/bin/bash

# Builds bitcode for mini_httpd
# Assumes, LLVM-3.8, WLLVM installation
export LLVM_COMPILER=clang
make
extract-bc mini_httpd
