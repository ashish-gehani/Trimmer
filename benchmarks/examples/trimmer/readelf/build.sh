#!/usr/bin/env bash

args="$*"
make readelf option="$args"
cp trimmer/work_dir/readelf_opt3.bc .

echo "Statistics for program before specialization" >&2
opt -load ./libProfilerPass.so -Pprofiler < readelf.bc > /dev/null


echo "Statistics for program after specialization" >&2
opt -load ./libProfilerPass.so -Pprofiler < readelf_opt3.bc > /dev/null
