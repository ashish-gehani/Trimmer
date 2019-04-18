cd ${4}
${LLVM_CC_NAME} -O0 -emit-llvm -o $3/${1}t1.bc -c ${1}.c
${LLVM_OPT_NAME} -mem2reg -mergereturn -simplifycfg -loops -lcssa -loop-simplify -loop-rotate $3/${1}t1.bc -o $3/${1}t2.bc
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
