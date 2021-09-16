#!/usr/bin/env bash
args="$*"
make mini option="$args"
cp trimmer/work_dir/mini_httpd_opt3.bc .

echo "Statistics for program before specialization" >&2
opt -load ../libProfilerPass.so -Pprofiler < mini_httpd.bc > /dev/null

make base
bin_size_before=$(ls -l mini_httpd_base_stripped | awk '{print $5}')

echo "Binary Size ${bin_size_before}" >&2

echo "Statistics for program after specialization" >&2
opt -load ../libProfilerPass.so -Pprofiler < mini_httpd_opt3.bc > /dev/null

bin_size_after=$(ls -l trimmer/work_dir/mini_httpd_fin_stripped | awk '{print $5}')

echo "Binary Size ${bin_size_after}" >&2

test_status=$(make test_mini | grep "Passed")

echo "Test: ${test_status}" >&2

