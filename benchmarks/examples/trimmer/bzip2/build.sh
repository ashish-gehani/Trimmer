#!/usr/bin/env bash

args="$*"
make compress option="$args"
cp trimmer/work/bzip2_opt3.bc .

echo "Statistics for program before specialization" >&2
opt -load ./libProfilerPass.so -Pprofiler < bzip2.bc > /dev/null


echo "Statistics for program after specialization" >&2
opt -load ./libProfilerPass.so -Pprofiler < bzip2_opt3.bc > /dev/null
