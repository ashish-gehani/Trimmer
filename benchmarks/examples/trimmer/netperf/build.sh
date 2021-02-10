#!/usr/bin/env bash

args="$*"
make netperf option="$args"
cp trimmer/work_dir/netperf_opt3.bc .

echo "Statistics for program before specialization" >&2
opt -load ./libProfilerPass.so -Pprofiler < netperf.bc > /dev/null


echo "Statistics for program after specialization" >&2
opt -load ./libProfilerPass.so -Pprofiler < netperf_opt3.bc > /dev/null
