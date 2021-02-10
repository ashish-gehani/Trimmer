#!/usr/bin/env bash

echo "Statistics for program before specialization" >&2
opt -load ./libProfilerPass.so -Pprofiler < wget.bc > /dev/null


echo "Statistics for program after specialization" >&2
opt -load ./libProfilerPass.so -Pprofiler < wget_linked_intern.bc > /dev/null
