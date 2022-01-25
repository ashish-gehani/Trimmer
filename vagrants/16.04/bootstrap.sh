# Copyright (c) 2020 SRI International All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

#!/usr/bin/env bash

# Install package dependencies
sudo apt-get update
sudo apt-get install -y build-essential cmake git gettext gnutls-dev groff-base libbz2-dev libevent-dev libidn11-dev libmemcached-tools libpcap-dev libpcre3-dev libssl-dev pkg-config python-minimal uuid-dev wget wireless-tools

# Download Trimmer
export TRIMMER_HOME=$HOME/Trimmer
export USER=
export TOKEN=
cd `dirname $TRIMMER_HOME`
git clone https://${USER}:${TOKEN}@github.com/ashish-gehani/Trimmer

# Setup environment
cp $TRIMMER_HOME/vagrants/16.04/bash_profile $HOME/.bash_profile
. .bash_profile

# Install WLLVM
  # 'pip' location must be in PATH
curl "https://bootstrap.pypa.io/pip/2.7/get-pip.py" -o "get-pip.py"
python get-pip.py
pip install wllvm

# Download LLVM7 and clang sources
mkdir $LLVM_HOME
cd $LLVM_HOME
wget https://releases.llvm.org/7.0.0/llvm-7.0.0.src.tar.xz
wget https://releases.llvm.org/7.0.0/cfe-7.0.0.src.tar.xz
tar xvf llvm-7.0.0.src.tar.xz
tar xvf cfe-7.0.0.src.tar.xz
mv cfe-7.0.0.src/ llvm-7.0.0.src/tools/clang

# Build, install LLVM7 / clang
mkdir llvm-7.0.0.obj
cd llvm-7.0.0.obj
cmake -DCMAKE_BUILD_TYPE=MinSizeRel ../llvm-7.0.0.src
make -j16
sudo make install

# Download SVF
git clone https://github.com/SVF-tools/SVF
cd SVF
# Trimmer developed with below version
git checkout 0b75f3e0c10db04d65b6eafd91da5da9be71ecaa

# Add -fPIC to CMakeLists.txt in SVF
sed -i '/set(CMAKE_CXX_FLAGS "-std=gnu++11 -O3 -fno-rtti")/c\\t\tset(CMAKE_CXX_FLAGS "-std=gnu++11 -O3 -fno-rtti -fPIC")' CMakeLists.txt 
sed -i '/set(CMAKE_CXX_FLAGS "-std=gnu++11 -O0 -fno-rtti")/c\\t\tset(CMAKE_CXX_FLAGS "-std=gnu++11 -O0 -fno-rtti -fPIC")' CMakeLists.txt 
sed -i '/set_target_properties(Cudd PROPERTIES COMPILE_FLAGS "-Wno-format -Wno-int-to-pointer-cast -Wno-pointer-to-int-cast -O3 -w -DHAVE_IEEE_754 -DSIZEOF_VOID_P=8 -DSIZEOF_LONG=8")/c\set_target_properties(Cudd PROPERTIES COMPILE_FLAGS "-Wno-format -Wno-int-to-pointer-cast -Wno-pointer-to-int-cast -O3 -w -DHAVE_IEEE_754 -DSIZEOF_VOID_P=8 -DSIZEOF_LONG=8 -fPIC")' lib/CUDD/CMakeLists.txt 
sed -i '/set_target_properties(LLVMCudd PROPERTIES COMPILE_FLAGS "-Wno-format -Wno-int-to-pointer-cast -Wno-pointer-to-int-cast -O3 -w -DHAVE_IEEE_754 -DSIZEOF_VOID_P=8 -DSIZEOF_LONG=8")/c\set_target_properties(LLVMCudd PROPERTIES COMPILE_FLAGS "-Wno-format -Wno-int-to-pointer-cast -Wno-pointer-to-int-cast -O3 -w -DHAVE_IEEE_754 -DSIZEOF_VOID_P=8 -DSIZEOF_LONG=8 -fPIC")' lib/CUDD/CMakeLists.txt 

# Build and install SVF
mkdir Release-build
cd Release-build
cmake ..
make -j16
sudo make install
cd ../include/
sudo cp -r * /usr/local/include/

# Build Trimmer
cd $TRIMMER_HOME
mkdir build
cd build
cmake ..
make

# Test Trimmer
cd $TRIMMER_HOME/test/scripts/
python test.py ./work_dir all 1 1

