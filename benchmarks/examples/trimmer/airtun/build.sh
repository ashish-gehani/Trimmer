#!/usr/bin/env bash
args="$*"
make airtun option="$args"
cp trimmer/airtun/airtun-ng_opt3.bc .

echo "Statistics for program before specialization" >&2
opt -load ./libProfilerPass.so -Pprofiler < airtun-ng.bc > /dev/null


echo "Statistics for program after specialization" >&2
opt -load ./libProfilerPass.so -Pprofiler < airtun-ng_opt3.bc > /dev/null
