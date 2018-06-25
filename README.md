# TRIMMER

## Build

    ```
    mkdir build
    export TRIMMER_HOME=/path/to/root/directory
    export LLVM_COMPILER=clang
    make
    ```
   
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

## Synopsis
       
    python tool/trimmer.py [manifest-file] [working-directory]

## Description of manifest file 
    
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

## Examples
     
    mkdir examples/tool_name/work_dir
    python tool/trimmer.py   examples/tool_name/tool.manifest  examples/tool_name/work_dir      

    To run a comparison for trimmer, occam, orig use the scripts in experimentation directory
    to run en masse, run run_examples.sh in the root.
    the results are written to results/exe_sizes.csv and results/funcs.csv
    the pre-generated bitcodes and manifests for some examples can be found in examples/name/trimmer/name

## Running test cases
    
    Test cases directory: /test/InterConstProp
      
    * Includes a suite of multiple test cases used to measure the effectiveness of TRIMMER in debloating unused code 
             
    Running test examples:
    
    ```
    cd test/InterConstProp
    python test.py 1 1 
    ```
    
    will run the test case for inter1.c
    
    ```
    python test.py 1 10
    ```
    
    will run 10 test cases including inter1.c to inter10.c (inclusive)

    In all test cases, we include functions with names 'branchPruned' and 'branchNotPruned'
    * **branchPruned** contains code branches that we expect should be eliminated by debloating
    * **branchNotPruned** contains code branches that should NOT be eliminated by debloating 
      - this serves as a sanity check 
      
    Guidelines for Writing Additional Test Cases:
    
           * branchPruned should contain only one branch. As a result of specialization we expect 
           this branch to evaluate to true. The underlying block should contain a 
           printf call. Multiple branches can be joined by using '&&'.

           * branchNotPruned should also contain only one branch. Multiple branches 
           can be joined by using '||'. The underlying block should contain a printf call.

     **Measuring Code Elimination**: If specialization is successful, the branchPruned function should 
                                     only contain the printf call that was conditional on the 
                                     branch. The branchNotPruned function should remain 
                                     unmodified (no code removed)    
    
    
