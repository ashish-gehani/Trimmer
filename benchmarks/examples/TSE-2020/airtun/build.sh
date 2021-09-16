#!/usr/bin/env bash
args="$*"
make airtun option="$args"
cp trimmer/airtun/airtun-ng_opt3.bc .

echo "Statistics for program before specialization" >&2
opt -load ../libProfilerPass.so -Pprofiler < airtun-ng.bc > /dev/null

make base
bin_size_before=$(ls -l airtun-ng_base_stripped | awk '{print $5}')

echo "Binary Size ${bin_size_before}" >&2

echo "Statistics for program after specialization" >&2
opt -load ../libProfilerPass.so -Pprofiler < airtun-ng_opt3.bc > /dev/null

bin_size_after=$(ls -l trimmer/airtun/airtun-ng_fin_stripped | awk '{print $5}')

echo "Binary Size ${bin_size_after}" >&2

echo "Test: Not Available" >&2
