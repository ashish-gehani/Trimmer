#!/usr/bin/env bash
args="$*"
make dns option="$args"
cp trimmer/workdir/dnsproxy_opt3.bc .

echo "Statistics for program before specialization" >&2
opt -load ../libProfilerPass.so -Pprofiler < dnsproxy.bc > /dev/null

make base
bin_size_before=$(ls -l dnsproxy_base_stripped | awk '{print $5}')

echo "Binary Size ${bin_size_before}" >&2

echo "Statistics for program after specialization" >&2
opt -load ../libProfilerPass.so -Pprofiler < dnsproxy_opt3.bc > /dev/null

bin_size_after=$(ls -l trimmer/workdir/dnsproxy_fin_stripped | awk '{print $5}')

echo "Binary Size ${bin_size_after}" >&2

test_status=$(make test_dns | grep "Passed")

echo "Test: ${test_status}" >&2

