#!/bin/sh
# Copyright (c) 2020 SRI International All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.


opt -load ./build/ListFunctions.so -list-functions -out_file func_out  test/remFunc/remFunc1.bc -o ran.bc
opt -load ./build/RemFuncBody.so -rem-func-body -func_name random  test/remFunc/remFunc1.bc -o ran.bc
opt -load ./build/Internalize.so -intern ran.bc -o ran.bc
opt -dce -globaldce ran.bc -o ran.bc
llvm-dis ran.bc


