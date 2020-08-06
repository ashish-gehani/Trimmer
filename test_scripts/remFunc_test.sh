#!/bin/sh

opt -load ./build/ListFunctions.so -list-functions -out_file func_out  test/remFunc/remFunc1.bc -o ran.bc
opt -load ./build/RemFuncBody.so -rem-func-body -func_name random  test/remFunc/remFunc1.bc -o ran.bc
opt -load ./build/Internalize.so -intern ran.bc -o ran.bc
opt -dce -globaldce ran.bc -o ran.bc
llvm-dis ran.bc


