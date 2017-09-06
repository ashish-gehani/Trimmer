cd ~/fileIO/test/InterConstProp
clang-3.8 -O0 -emit-llvm -o workdir/${1}t1.bc -c ${1}.c
opt-3.8 -load ~/fileIO/lib/InterConstProp.so -isAnnotated=false -mem2reg -simplifycfg -inter-constprop workdir/${1}t1.bc -o workdir/${1}t2.bc
opt-3.8 -load ~/fileIO/lib/InterConstProp.so -isAnnotated=false -mem2reg -constprop -inter-constprop workdir/${1}t2.bc -o workdir/${1}t3.bc
opt-3.8 -O3 workdir/${1}t3.bc -o workdir/${2}
llvm-dis-3.8  workdir/${1}t1.bc
llvm-dis-3.8  workdir/${1}t2.bc
llvm-dis-3.8  workdir/${1}t3.bc
llvm-dis-3.8  workdir/${2}
opt-3.8 -load ~/fileIO/lib/testing_pass.so -testing workdir/${2} -o workdir/${2}
