#!/usr/bin/env bash

args="$*"

make udp option="$args"
cp trimmer/udp/sans_opt3.bc .

echo "Statistics for program before specialization" >&2
opt -load ./libProfilerPass.so -Pprofiler < sans.bc > /dev/null


echo "Statistics for program after specialization" >&2
opt -load ./libProfilerPass.so -Pprofiler < sans_opt3.bc > /dev/null
