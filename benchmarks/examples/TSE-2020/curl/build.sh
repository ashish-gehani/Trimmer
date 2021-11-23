#!/usr/bin/env bash
args="$*"
make compress option="$args"
cp trimmer/work_dir/curl_opt3.bc .

echo "Statistics for program before specialization" >&2
opt -load ../libProfilerPass.so -Pprofiler < curl.bc > /dev/null

make base
bin_size_before=$(ls -l curl_base_stripped | awk '{print $5}')

echo "Binary Size ${bin_size_before}" >&2

echo "Statistics for program after specialization" >&2
opt -load ../libProfilerPass.so -Pprofiler < curl_opt3.bc > /dev/null

bin_size_after=$(ls -l trimmer/work_dir/curl_fin_stripped | awk '{print $5}')

echo "Binary Size ${bin_size_after}" >&2

test_status=$(make test_curl | grep "Passed")

echo "Test: ${test_status}" >&2

