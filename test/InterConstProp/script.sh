cd ~/FileIO/test/InterConstProp
clang-3.8 -emit-llvm -o workdir/${1}t1.bc -c ${1}.c
opt-3.8 -load ~/FileIO/lib/InterConstProp.so -mem2reg -inter-constprop workdir/${1}t1.bc -o workdir/${1}t2.bc
opt-3.8 -load ~/FileIO/lib/InterConstProp.so -mem2reg -instcombine -inter-constprop workdir/${1}t2.bc -o workdir/${1}t3.bc
opt-3.8 -O3 workdir/${1}t3.bc -o workdir/${2}
opt-3.8 -load ~/FileIO/lib/testing_pass.so -testing workdir/${2} -o workdir/${2}
