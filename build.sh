# Copyright (c) 2020 SRI International All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

#  Note that these instructions have been tested on Ubuntu 16.04.6 
#  You may need to adjust according to your system requirements


#  Install required programs
sudo apt-get install git wget cmake build-essential

# Install missing libraries for examples to build
sudo apt-get install groff-base
sudo apt-get install gnutls-dev
sudo apt-get install -y pkg-config
sudo apt-get install libevent-dev
sudo apt-get install libpcre3-dev
sudo apt-get install libidn11-dev
sudo apt-get install uuid-dev

echo "Downloading openssl"
#Install SSL Library version 1.0.2g (compatible with aircrack-ng example) 
wget https://www.openssl.org/source/openssl-1.0.2g.tar.gz
tar xvfz openssl-1.0.2g.tar.gz
cd openssl-1.0.2g
./config shared
sudo make install

echo "openssl done"

sudo ln -s /usr/local/ssl/bin/c_rehash /usr/local/bin/
sudo ln -s /usr/local/ssl/bin/openssl /usr/local/bin/

sudo ln -s /usr/local/ssl/include/openssl /usr/local/include/

sudo ln -s /usr/local/ssl/lib/engines /usr/local/lib/
sudo ln -s /usr/local/ssl/lib/libcrypto.a /usr/local/lib/ 
sudo ln -s /usr/local/ssl/lib/libcrypto.so /usr/local/lib/
sudo ln -s /usr/local/ssl/lib/libcrypto.so.1.0.0 /usr/local/lib/
sudo ln -s /usr/local/ssl/lib/libssl.a /usr/local/lib/
sudo ln -s /usr/local/ssl/lib/libssl.so /usr/local/lib/
sudo ln -s /usr/local/ssl/lib/libssl.so.1.0.0 /usr/local/lib/

sudo mkdir /usr/local/lib/pkgconfig
sudo ln -s /usr/local/ssl/lib/pkgconfig/libcrypto.pc /usr/local/lib/pkgconfig/
sudo ln -s /usr/local/ssl/lib/pkgconfig/libssl.pc /usr/local/lib/pkgconfig/
sudo ln -s /usr/local/ssl/lib/pkgconfig/openssl.pc /usr/local/lib/pkgconfig/

#These environment variables should be set before building aircrack-ng. Better to put it in .bash_profile

export CPATH=/usr/local/include:$CPATH
export LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib/engines:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH


echo /usr/local/lib > /etc/ld.so.conf.d/usr_local_lib.conf
sudo ldconfig
sudo ldconfig -v

#  Download LLVM source files

echo "=== Downloading LLVM & Clang Source Files ==="
# mkdir llvm7 
# cd llvm7

# wget https://releases.llvm.org/7.0.0/llvm-7.0.0.src.tar.xz 
# wget https://releases.llvm.org/7.0.0/cfe-7.0.0.src.tar.xz 
# tar xf llvm-7.0.0.src.tar.xz
# tar xf cfe-7.0.0.src.tar.xz

# mv cfe-7.0.0.src/ llvm-7.0.0.src/tools/clang




#  Build LLVM-7 from source

# echo "=== Starting the build process ==="

# mkdir llvm-7.0.0.obj && cd llvm-7.0.0.obj
# cmake -DCMAKE_BUILD_TYPE=MinSizeRel ../llvm-7.0.0.src
# make -j2

# sudo make install
# cd ../




#  export environment variables

echo "=== Exporting required environment variables ==="

#export LLVM_SRC=$(pwd)/llvm-7.0.0.src
#export LLVM_OBJ=$(pwd)/llvm-7.0.0.obj
export LLVM_DIR=/usr/local/llvm-10.0
export PATH=$LLVM_DIR/bin:$PATH


#  Clone SVF dependency and adjust for LLVM-7

echo "=== Downloading SVF Pointer Analysis ==="

git clone https://github.com/SVF-tools/SVF.git SVF

#  Specific commit used for TRIMMER development
cd SVF
git checkout f36990a672abdc7cdfb9de613aa05be96ece20f0

# Add -fPIC to CMakeLists.txt in SVF
sed -i '/set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${COMMON_FLAGS} -O0 -fno-rtti")/c\\t\tset(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${COMMON_FLAGS} -O0 -fno-rtti -fPIC")' CMakeLists.txt 
sed -i '/set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${COMMON_FLAGS} -O0")/c\\t\tset(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${COMMON_FLAGS} -O0 -fPIC")' CMakeLists.txt 

sed -i '/set_target_properties(Cudd PROPERTIES COMPILE_FLAGS "-Wno-format -Wno-int-to-pointer-cast -Wno-pointer-to-int-cast -O3 -w -DHAVE_IEEE_754 -DSIZEOF_VOID_P=8 -DSIZEOF_LONG=8")/c\set_target_properties(Cudd PROPERTIES COMPILE_FLAGS "-Wno-format -Wno-int-to-pointer-cast -Wno-pointer-to-int-cast -O3 -w -DHAVE_IEEE_754 -DSIZEOF_VOID_P=8 -DSIZEOF_LONG=8 -fPIC")' lib/CUDD/CMakeLists.txt 

sed -i '/set_target_properties(LLVMCudd PROPERTIES COMPILE_FLAGS "-Wno-format -Wno-int-to-pointer-cast -Wno-pointer-to-int-cast -O3 -w -DHAVE_IEEE_754 -DSIZEOF_VOID_P=8 -DSIZEOF_LONG=8")/c\set_target_properties(LLVMCudd PROPERTIES COMPILE_FLAGS "-Wno-format -Wno-int-to-pointer-cast -Wno-pointer-to-int-cast -O3 -w -DHAVE_IEEE_754 -DSIZEOF_VOID_P=8 -DSIZEOF_LONG=8 -fPIC")' lib/CUDD/CMakeLists.txt 


#  Build SVF

echo "=== Begin building SVF ==="
# mkdir Release-build
# cd Release-build
# cmake ../
# make -j2
# sudo make install
# cd ../
sudo bash build.sh

#  Copy Library Headers
echo "=== Copy SVF headers ==="
cd include/
sudo cp -r * /usr/local/include/
sudo cp -r * /usr/local/lib/


echo "******** TRIMMER Dependencies Built! ********"
