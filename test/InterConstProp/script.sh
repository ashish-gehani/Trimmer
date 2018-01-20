cd ${TRIMMER_HOME}/test/InterConstProp

${LLVM_CC_NAME} -O0 -emit-llvm -o workdir/${1}t1.bc -c ${1}.c
${LLVM_OPT_NAME} -mem2reg -loops -lcssa -loop-rotate -loop-simplify -mem2reg -simplifycfg workdir/${1}t1.bc -o workdir/${1}t2.bc
${LLVM_OPT_NAME} -load ${TRIMMER_HOME}/build/InterConstProp.so -isAnnotated=false -inter-constprop workdir/${1}t2.bc -o workdir/${1}t3.bc
${LLVM_OPT_NAME} -O3 workdir/${1}t3.bc -o workdir/${2}
${LLVM_OPT_NAME} -load ${TRIMMER_HOME}/build/testPass.so -testing workdir/${2} -o workdir/${2}
${LLVM_DIS_NAME}  workdir/${1}t1.bc
${LLVM_DIS_NAME}  workdir/${1}t2.bc
${LLVM_DIS_NAME}  workdir/${1}t3.bc
${LLVM_DIS_NAME}  workdir/${2}
