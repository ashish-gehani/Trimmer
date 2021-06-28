# Install Ubuntu 18.04 (Bionic) and necessary packages
FROM ubuntu:18.04
RUN apt-get update && \
    apt-get install -y build-essential cmake curl git nano python wget

# Number of cores to use for building
ENV CORES=24
ENV HOME=/home/user

# Download LLVM7 and Clang sources
ENV LLVM_HOME=$HOME/LLVM
WORKDIR $LLVM_HOME
RUN wget https://releases.llvm.org/7.0.0/llvm-7.0.0.src.tar.xz && \
    wget https://releases.llvm.org/7.0.0/cfe-7.0.0.src.tar.xz && \
    tar xvf llvm-7.0.0.src.tar.xz && \
    tar xvf cfe-7.0.0.src.tar.xz && \
    mv cfe-7.0.0.src llvm-7.0.0.src/tools/clang

# Build and install LLVM7 / Clang
WORKDIR llvm-7.0.0.obj
RUN cmake -DCMAKE_BUILD_TYPE=MinSizeRel ../llvm-7.0.0.src && \
    make -j $CORES && \
    make install

# Setup LLVM environment
ENV LLVM_SRC=$LLVM_HOME/llvm-7.0.0.src
ENV LLVM_OBJ=$LLVM_HOME/llvm-7.0.0.obj
ENV LLVM_DIR=$LLVM_HOME/llvm-7.0.0.obj
ENV PATH=$LLVM_DIR/bin:$PATH

# Download SVF
WORKDIR $HOME
RUN git clone https://github.com/SVF-tools/SVF
WORKDIR SVF

#  Trimmer developed with below version
RUN git checkout 0b75f3e0c10db04d65b6eafd91da5da9be71ecaa

# Add -fPIC to CMakeLists.txt in SVF
RUN sed -i '/set(CMAKE_CXX_FLAGS "-std=gnu++11 -O3 -fno-rtti")/c\\t\tset(CMAKE_CXX_FLAGS "-std=gnu++11 -O3 -fno-rtti -fPIC")' CMakeLists.txt && \
    sed -i '/set(CMAKE_CXX_FLAGS "-std=gnu++11 -O0 -fno-rtti")/c\\t\tset(CMAKE_CXX_FLAGS "-std=gnu++11 -O0 -fno-rtti -fPIC")' CMakeLists.txt && \
    sed -i '/set_target_properties(Cudd PROPERTIES COMPILE_FLAGS "-Wno-format -Wno-int-to-pointer-cast -Wno-pointer-to-int-cast -O3 -w -DHAVE_IEEE_754 -DSIZEOF_VOID_P=8 -DSIZEOF_LONG=8")/c\set_target_properties(Cudd PROPERTIES COMPILE_FLAGS "-Wno-format -Wno-int-to-pointer-cast -Wno-pointer-to-int-cast -O3 -w -DHAVE_IEEE_754 -DSIZEOF_VOID_P=8 -DSIZEOF_LONG=8 -fPIC")' lib/CUDD/CMakeLists.txt && \
    sed -i '/set_target_properties(LLVMCudd PROPERTIES COMPILE_FLAGS "-Wno-format -Wno-int-to-pointer-cast -Wno-pointer-to-int-cast -O3 -w -DHAVE_IEEE_754 -DSIZEOF_VOID_P=8 -DSIZEOF_LONG=8")/c\set_target_properties(LLVMCudd PROPERTIES COMPILE_FLAGS "-Wno-format -Wno-int-to-pointer-cast -Wno-pointer-to-int-cast -O3 -w -DHAVE_IEEE_754 -DSIZEOF_VOID_P=8 -DSIZEOF_LONG=8 -fPIC")' lib/CUDD/CMakeLists.txt

# Build and install SVF
WORKDIR Release-build
RUN cmake .. && \
    make -j $CORES && \
    make install
WORKDIR ../include
RUN cp -r * /usr/local/include/

# Setup for SSH agent
WORKDIR $HOME/.ssh
RUN chmod 700 . && \
    ssh-keyscan -H github.com >> ~/.ssh/known_hosts && \
    ssh -T git@github.com

# Download Trimmer
WORKDIR $HOME
RUN git clone git@github.com:ashish-gehani/Trimmer && \
ENV TRIMMER_HOME=$HOME/Trimmer

# Build Trimmer
ENV LLVM_COMPILER=clang
WORKDIR $TRIMMER_HOME/build
RUN cmake .. && \
    make

# Install Pip
RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py" && \
    python get-pip.py

# Install WLLVM
RUN pip install wllvm
