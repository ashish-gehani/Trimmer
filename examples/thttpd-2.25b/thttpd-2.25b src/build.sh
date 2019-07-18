#!/bin/bash

# Builds bitcode for mini_httpd
# Assumes, LLVM-4.0, WLLVM installation

export LLVM_COMPILER=clang
make
extract-bc thttpd
