cd $TRIMMER_HOME 
make build_unroller
cd test/src
${LLVM_CC_NAME} -O0 -emit-llvm -o workdir/inter${1}t1.bc -c inter${1}.c
${LLVM_OPT_NAME} -mem2reg -loops -lcssa -loop-simplify -loop-rotate workdir/inter${1}t1.bc -o workdir/inter${1}t2.bc
${LLVM_OPT_NAME} -load ~/TRIMMER/build/unroller.so -unroll workdir/inter${1}t2.bc -o workdir/inter${1}t3.bc
${LLVM_DIS_NAME} workdir/inter${1}t1.bc
${LLVM_DIS_NAME} workdir/inter${1}t2.bc
${LLVM_DIS_NAME} workdir/inter${1}t3.bc
