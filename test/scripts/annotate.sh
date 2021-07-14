#!/bin/sh
# Copyright (c) 2020 SRI International All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

cd ${TRIMMER_HOME}/test/src/annotation_tests
${LLVM_CC_NAME} -O0 -Xclang -disable-O0-optnone -emit-llvm -o $3/${1}t1.bc -c ${1}.c
${LLVM_OPT_NAME} -load ${TRIMMER_HOME}/build/AnnotateNew.so -mem2reg -loops -lcssa -loop-simplify -loop-rotate -indvars  -svfg --argvName=argv -isTest=1 $3/${1}t1.bc -o $3/${1}t2.bc
${LLVM_OPT_NAME} -load ${TRIMMER_HOME}/build/AnnotateTest.so -annot-test $3/${1}t2.bc -o $3/${1}t3.bc
${LLVM_OPT_NAME} -O3 $3/${1}t3.bc -o $3/${2}.bc
${LLVM_DIS_NAME}  $3/${1}t1.bc
${LLVM_DIS_NAME}  $3/${1}t2.bc
${LLVM_DIS_NAME}  $3/${1}t3.bc
${LLVM_DIS_NAME}  $3/${2}.bc
