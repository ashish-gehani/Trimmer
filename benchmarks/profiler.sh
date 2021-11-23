# Copyright (c) 2020 SRI International All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

#!/bin/bash 
cd profiler_pass
mkdir build
cd build
cmake ../
make
ls
cp ./src/libProfilerPass.so ../../examples/TSE-2020/
cp ./src/libProfilerPass.so ../../examples/Others/ImageMagick/
