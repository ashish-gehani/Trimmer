# Copyright (c) 2020 SRI International All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

cd ${4}
${LLVM_CC_NAME} -O0 -Xclang -disable-O0-optnone -emit-llvm -o $3/${1}t1.bc -c ${1}.c
${LLVM_OPT_NAME} -mem2reg -loops -lcssa -loop-simplify -loop-rotate -indvars  $3/${1}t1.bc -o $3/${1}t2.bc
${LLVM_OPT_NAME} -load ${TRIMMER_HOME}/build/ConstantFolding.so -isAnnotated=false -fileNames $5 -inter-constprop $3/${1}t2.bc -o $3/${1}t3.bc 
${LLVM_OPT_NAME} -load ${TRIMMER_HOME}/build/Remove.so -remove $3/${1}t3.bc -o $3/${1}t4.bc
${LLVM_OPT_NAME} -load ${TRIMMER_HOME}/build/Internalize.so -intern $3/${1}t4.bc -o $3/${1}t5.bc
${LLVM_OPT_NAME} -O1 $3/${1}t5.bc -o $3/${2}.bc
${LLVM_DIS_NAME}  $3/${1}t1.bc
${LLVM_DIS_NAME}  $3/${1}t2.bc
${LLVM_DIS_NAME}  $3/${1}t3.bc
${LLVM_DIS_NAME}  $3/${1}t4.bc
${LLVM_DIS_NAME}  $3/${2}.bc
${LLVM_OPT_NAME} -load ${TRIMMER_HOME}/build/TestPass.so -testing $3/${2}.bc -o $3/${2}.bc
