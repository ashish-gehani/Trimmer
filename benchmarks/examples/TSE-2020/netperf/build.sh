#!/usr/bin/env bash

args="$*"
make netperf option="$args"
cp trimmer/work_dir/netperf_opt3.bc .

echo "Statistics for program before specialization" >&2
opt -load ../libProfilerPass.so -Pprofiler < netperf.bc > /dev/null

make base
bin_size_before=$(ls -l netperf_base_stripped | awk '{print $5}')

echo "Binary Size ${bin_size_before}" >&2

echo "Statistics for program after specialization" >&2
opt -load ../libProfilerPass.so -Pprofiler < netperf_opt3.bc > /dev/null

bin_size_after=$(ls -l trimmer/work_dir/netperf_fin_stripped | awk '{print $5}')

echo "Binary Size ${bin_size_after}" >&2

test_status=$(make test_netperf | grep "Passed")

echo "Test: ${test_status}" >&2

