#!/usr/bin/env bash

args="$*"

make gprof option="$args"
cp trimmer/gprof/gprof_opt3.bc .

echo "Statistics for program before specialization" >&2
opt -load ../libProfilerPass.so -Pprofiler < gprof.bc > /dev/null

make base
bin_size_before=$(ls -l gprof_base_stripped | awk '{print $5}')

echo "Binary Size ${bin_size_before}" >&2

echo "Statistics for program after specialization" >&2
opt -load ../libProfilerPass.so -Pprofiler < gprof_opt3.bc > /dev/null

bin_size_after=$(ls -l trimmer/gprof/gprof_fin_stripped | awk '{print $5}')

echo "Binary Size ${bin_size_after}" >&2

test_status=$(make test_gprof | grep "Passed")

echo "Test: ${test_status}" >&2

