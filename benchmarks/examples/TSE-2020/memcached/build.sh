#!/usr/bin/env bash

args="$*"
export opition="$args"
make -f Makefile_memcached compress option="$args"

cp trimmer/mem/memcached_opt3.bc .

echo "Statistics for program before specialization" >&2
opt -load ../libProfilerPass.so -Pprofiler < memcached.bc > /dev/null

make base
bin_size_before=$(ls -l memcached_base_stripped | awk '{print $5}')

echo "Binary Size ${bin_size_before}" >&2

echo "Statistics for program after specialization" >&2
opt -load ../libProfilerPass.so -Pprofiler < memcached_opt3.bc > /dev/null

bin_size_after=$(ls -l trimmer/mem/memcached_fin_stripped | awk '{print $5}')

echo "Binary Size ${bin_size_after}" >&2

test_status=$(make test | grep "Passed")

echo "Test: ${test_status}" >&2

