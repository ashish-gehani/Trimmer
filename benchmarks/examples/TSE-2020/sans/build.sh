#!/usr/bin/env bash

args="$*"

make udp option="$args"
cp trimmer/udp/sans_opt3.bc .

echo "Statistics for program before specialization" >&2
opt -load ../libProfilerPass.so -Pprofiler < sans.bc > /dev/null

make base
bin_size_before=$(ls -l sans_base_stripped | awk '{print $5}')

echo "Binary Size ${bin_size_before}" >&2

echo "Statistics for program after specialization" >&2
opt -load ../libProfilerPass.so -Pprofiler < sans_opt3.bc > /dev/null

bin_size_after=$(ls -l trimmer/udp/sans_fin_stripped | awk '{print $5}')

echo "Binary Size ${bin_size_after}" >&2