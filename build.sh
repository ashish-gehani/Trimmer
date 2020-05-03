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

git clone https://github.com/RafaeNoor/SVF_LLVM7_Fork.git SVF
cd SVF


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
