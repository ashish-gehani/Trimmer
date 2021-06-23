#!/usr/bin/env bash

args="$*"
make readelf option="$args"
cp trimmer/work_dir/readelf_opt3.bc .

echo "Statistics for program before specialization" >&2
opt -load ../libProfilerPass.so -Pprofiler < readelf.bc > /dev/null

make base
bin_size_before=$(ls -l readelf_base_stripped | awk '{print $5}')

echo "Binary Size ${bin_size_before}" >&2

echo "Statistics for program after specialization" >&2
opt -load ../libProfilerPass.so -Pprofiler < readelf_opt3.bc > /dev/null

bin_size_after=$(ls -l trimmer/work_dir/readelf_fin_stripped | awk '{print $5}')

echo "Binary Size ${bin_size_after}" >&2