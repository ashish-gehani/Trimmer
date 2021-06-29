#!/usr/bin/env bash

args="$*"
make ipv4 option="$args"
cp trimmer/workdir/totd_opt3.bc .

echo "Statistics for program before specialization" >&2
opt -load ../libProfilerPass.so -Pprofiler < totd.bc > /dev/null

make base
bin_size_before=$(ls -l totd_base_stripped | awk '{print $5}')

echo "Binary Size ${bin_size_before}" >&2

echo "Statistics for program after specialization" >&2
opt -load ../libProfilerPass.so -Pprofiler < totd_opt3.bc > /dev/null

bin_size_after=$(ls -l trimmer/workdir/totd_fin_stripped | awk '{print $5}')

echo "Binary Size ${bin_size_after}" >&2