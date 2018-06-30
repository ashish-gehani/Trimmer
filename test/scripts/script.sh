cd ${TRIMMER_HOME}/test/src
${LLVM_CC_NAME} -O0 -emit-llvm -o $3/${1}t1.bc -c ${1}.c
${LLVM_OPT_NAME} -mem2reg -loops -lcssa -loop-rotate -loop-simplify -mem2reg -simplifycfg $3/${1}t1.bc -o $3/${1}t2.bc
${LLVM_OPT_NAME} -load ${TRIMMER_HOME}/build/InterConstProp.so -isAnnotated=false -inter-constprop $3/${1}t2.bc -o $3/${1}t3.bc
${LLVM_OPT_NAME} -O3 $3/${1}t3.bc -o $3/${2}.bc
${LLVM_DIS_NAME}  $3/${1}t1.bc
${LLVM_DIS_NAME}  $3/${1}t2.bc
${LLVM_DIS_NAME}  $3/${1}t3.bc
${LLVM_DIS_NAME}  $3/${2}.bc
${LLVM_OPT_NAME} -load ${TRIMMER_HOME}/build/TestPass.so -testing $3/${2}.bc -o $3/${2}.bc
