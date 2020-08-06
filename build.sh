#  Note that these instructions have been tested on Ubuntu 16.04.6 
#  You may need to adjust according to your system requirements


#  Install required programs
sudo apt-get install git wget cmake build-essential

#  Download LLVM source files

echo "=== Downloading LLVM & Clang Source Files ==="
mkdir llvm7 
cd llvm7

wget https://releases.llvm.org/7.0.0/llvm-7.0.0.src.tar.xz 
wget https://releases.llvm.org/7.0.0/cfe-7.0.0.src.tar.xz 
tar xf llvm-7.0.0.src.tar.xz
tar xf cfe-7.0.0.src.tar.xz

mv cfe-7.0.0.src/ llvm-7.0.0.src/tools/clang




#  Build LLVM-7 from source

echo "=== Starting the build process ==="

mkdir llvm-7.0.0.obj && cd llvm-7.0.0.obj
cmake -DCMAKE_BUILD_TYPE=MinSizeRel ../llvm-7.0.0.src
make -j2

sudo make install
cd ../




#  export environment variables

echo "=== Exporting required environment variables ==="

export LLVM_SRC=$(pwd)/llvm-7.0.0.src
export LLVM_OBJ=$(pwd)/llvm-7.0.0.obj
export LLVM_DIR=$(pwd)/llvm-7.0.0.obj
export PATH=$LLVM_DIR/bin:$PATH


#  Clone SVF dependency and adjust for LLVM-7

echo "=== Downloading SVF Pointer Analysis ==="

git clone https://github.com/SVF-tools/SVF.git SVF

#  Specific commit used for TRIMMER development
cd SVF
git checkout 0b75f3e0c10db04d65b6eafd91da5da9be71ecaa

# Add -fPIC to CMakeLists.txt in SVF
sed -i '/set(CMAKE_CXX_FLAGS "-std=gnu++11 -O3 -fno-rtti")/c\\t\tset(CMAKE_CXX_FLAGS "-std=gnu++11 -O3 -fno-rtti -fPIC")' CMakeLists.txt 
sed -i '/set(CMAKE_CXX_FLAGS "-std=gnu++11 -O0 -fno-rtti")/c\\t\tset(CMAKE_CXX_FLAGS "-std=gnu++11 -O0 -fno-rtti -fPIC")' CMakeLists.txt 

sed -i '/set_target_properties(Cudd PROPERTIES COMPILE_FLAGS "-Wno-format -Wno-int-to-pointer-cast -Wno-pointer-to-int-cast -O3 -w -DHAVE_IEEE_754 -DSIZEOF_VOID_P=8 -DSIZEOF_LONG=8")/c\set_target_properties(Cudd PROPERTIES COMPILE_FLAGS "-Wno-format -Wno-int-to-pointer-cast -Wno-pointer-to-int-cast -O3 -w -DHAVE_IEEE_754 -DSIZEOF_VOID_P=8 -DSIZEOF_LONG=8 -fPIC")' lib/CUDD/CMakeLists.txt 

sed -i '/set_target_properties(LLVMCudd PROPERTIES COMPILE_FLAGS "-Wno-format -Wno-int-to-pointer-cast -Wno-pointer-to-int-cast -O3 -w -DHAVE_IEEE_754 -DSIZEOF_VOID_P=8 -DSIZEOF_LONG=8")/c\set_target_properties(LLVMCudd PROPERTIES COMPILE_FLAGS "-Wno-format -Wno-int-to-pointer-cast -Wno-pointer-to-int-cast -O3 -w -DHAVE_IEEE_754 -DSIZEOF_VOID_P=8 -DSIZEOF_LONG=8 -fPIC")' lib/CUDD/CMakeLists.txt 


#  Build SVF

echo "=== Begin building SVF ==="
mkdir Release-build
cd Release-build
cmake ../
make -j2
sudo make install
cd ../

#  Copy Library Headers
echo "=== Copy SVF headers ==="
cd include/
sudo cp -r * /usr/local/include/


echo "******** TRIMMER Dependencies Built! ********"
