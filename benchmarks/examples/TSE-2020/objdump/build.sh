#!/usr/bin/env bash

args="$*"
make objdump option="$args"
cp trimmer/objdump/objdump_opt3.bc .

echo "Statistics for program before specialization" >&2
opt -load ../libProfilerPass.so -Pprofiler < objdump.bc > /dev/null

make base
bin_size_before=$(ls -l objdump_base_stripped | awk '{print $5}')

echo "Binary Size ${bin_size_before}" >&2

echo "Statistics for program after specialization" >&2
opt -load ../libProfilerPass.so -Pprofiler < objdump_opt3.bc > /dev/null

bin_size_after=$(ls -l trimmer/objdump/objdump_fin_stripped | awk '{print $5}')

echo "Binary Size ${bin_size_after}" >&2

test_status=$(make test_objdump | grep "Passed")

echo "Test: ${test_status}" >&2

