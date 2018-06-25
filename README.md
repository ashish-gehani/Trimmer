# TRIMMER

#### Build:
    mkdir build
    export TRIMMER_HOME=/path/to/root/directory
    export LLVM_COMPILER=clang
    make
    
    if you have non conventional names for LLVM or CLANG you will have to set certain enviornment variables.

    e.g. if you have version 4.0
    
    export LLVM_CC_NAME=clang-4.0
    export LLVM_CXX_NAME=clang++-4.0
    export LLVM_LINK_NAME=llvm-link-4.0
    export LLVM_DIS_NAME=llvm-dis-4.0
    export LLVM_AR_NAME=llvm-ar-4.0
    export LLVM_AS_NAME=llvm-as-4.0
    export LLVM_LD_NAME=llvm-ld-4.0
    export LLVM_LLC_NAME=llc-4.0
    export LLVM_OPT_NAME=opt-4.0
    export LLVM_NM_NAME=llvm-nm-4.0

#### Synopsis
       
    python tool/trimmer.py [manifest-file] [working-directory]

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
     
    mkdir examples/tool_name/work_dir
    python tool/trimmer.py   examples/tool_name/tool.manifest  examples/tool_name/work_dir      

    To run a comparison for trimmer, occam, orig use the scripts in experimentation directory
    to run en masse, run run_examples.sh in the root.
    the results are written to results/exe_sizes.csv and results/funcs.csv
    the pre-generated bitcodes and manifests for some examples can be found in examples/name/trimmer/name
