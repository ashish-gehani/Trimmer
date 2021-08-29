#!/bin/bash 
cd profiler_pass
mkdir build
cd build
cmake ../
make
ls
cp ./src/libProfilerPass.so ../../examples/TSE-2020/
cp ./src/libProfilerPass.so ../../examples/Others/ImageMagick/
