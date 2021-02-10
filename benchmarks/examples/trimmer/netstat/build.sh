#!/usr/bin/env bash

rm -rf netstat.bc
args="$*"
export option="$args"
./script.exp

make netstat
cp trimmer/work_dir/netstat_opt3.bc .

echo "Statistics for program before specialization" >&2
opt -load ./libProfilerPass.so -Pprofiler < netstat.bc > /dev/null


echo "Statistics for program after specialization" >&2
opt -load ./libProfilerPass.so -Pprofiler < netstat_opt3.bc > /dev/null
