# TRIMMER

#### Build:
      
    export TRIMMER_HOME=/path/to/root/directory
    export LLVM_COMPILER=clang
    make
    
    if you have non conventional names for LLVM or CLANG you will have to set certain enviornment variables.

    e.g. if you have version 3.8
    
    export LLVM_CC_NAME=clang-3.8
    export LLVM_CXX_NAME=clang++-3.8
    export LLVM_LINK_NAME=llvm-link-3.8
    export LLVM_DIS_NAME=llvm-dis-3.8
    export LLVM_AR_NAME=llvm-ar-3.8
    export LLVM_AS_NAME=llvm-as-3.8
    export LLVM_LD_NAME=llvm-ld-3.8
    export LLVM_LLC_NAME=llc-3.8
    export LLVM_OPT_NAME=opt-3.8
    export LLVM_NM_NAME=llvm-nm-3.8

#### Run
    
    the main run script is trimmer/tool/run.py
    e.g. python run.py name-of-manifest-file working-directory


#### Description of manifest file 
    
    the manifest file for curl is shown below

    {
        "binary": "curl_fin", 
        "native_libs": [], 
        "name": "curl", 
        "args": ["--compress", "--http1.1", "--ipv4", "--ssl", "ftp://speedtest.tele2.net"],
        "modules": [], 
        "ldflags": ["-lz", "-lcurl"], 
        "main": "curl.bc"
    }

#### Examples
     
    cd tool/example/
    mkdir work_dir
    python ../run.py curl.manifest work_dir      

    To run a comparison for trimmer, occam, orig ..
    cd experimentation/example
    uncomment whichever programs you want to run in run.sh
    ./run.sh
    results are automatically written to results/exe_sizes.csv and results/funcs.csv