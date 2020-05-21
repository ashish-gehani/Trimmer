

Build
======

We provide a bash script `build.sh` to build the dependencies to run TRIMMER, namely LLVM and Clang (Version 7.0.0) and [SVG](https://github.com/SVF-tools/SVF).


```
bash build.sh
mkdir build
export TRIMMER_HOME=/path/to/root/directory
export LLVM_COMPILER=clang
cd build
cmake ../
make
```
   
If you have non conventional names for LLVM or CLANG you will have to set certain enviornment variables.

e.g. if you have version build according to the instructions above: 
    
```
export LLVM_CC_NAME=clang
export LLVM_CXX_NAME=clang++
export LLVM_LINK_NAME=llvm-link
export LLVM_DIS_NAME=llvm-dis
export LLVM_AR_NAME=llvm-ar
export LLVM_AS_NAME=llvm-as
export LLVM_LD_NAME=llvm-ld
export LLVM_LLC_NAME=llc
export LLVM_OPT_NAME=opt
export LLVM_NM_NAME=llvm-nm
```

TRIMMER also requires either wllvm

```
pip install wllvm
```


Synopsis
========

```
python ${TRIMMER_HOME}/tool/trimmer.py [manifest-file] [working-directory]
```

Description of manifest file 
============================
    
The manifest file for curl (one of the example programs) is shown below:

``` 
{
    "binary": "curl_fin", 
    "native_libs": [], 
    "name": "curl", 
    "args": ["--compress", "--http1.1", "--ipv4", "--ssl", "ftp://speedtest.tele2.net"],
    "modules": [], 
    "ldflags": ["-lz", "-lcurl"], 
    "main": "curl.bc"
    "config_files": []
 }
 ```

Examples
========
```
mkdir examples/tool_name/work_dir
python ${TRIMMER_HOME}/tool/trimmer.py   ${TRIMMER_HOME}/examples/tool_name/tool.manifest  ${TRIMMER_HOME}/examples/tool_name/work_dir      
```

Running test cases
==================
    
Test cases directory: /test/src
      
* Includes a suite of multiple test cases used to measure the effectiveness of TRIMMER in debloating unused code 
 
 **Test script synopsis**:

For tests placed in test/src, where ${prefix} is the prefix of the folder in test/src
 
```
cd test/scripts
python test.py ${path_to_workdir} ${prefix} ${test_start} ${test_end} 
 
 
 **Running test examples**:

```
cd test/scripts
python test.py ./work_dir pointer 1 1 
```
    
 will run the test case for inter1.c placed in test/src/pointer_tests
    
```
python test.py ./work_dir constprop 1 10
```
    
will run 10 test cases including inter1.c to inter10.c in test/src/constprop (inclusive)



In all test cases, we include functions with names 'branchPruned' and 'branchNotPruned'
  * **branchPruned** contains code branches that we expect should be eliminated by debloating
  * **branchNotPruned** contains code branches that should NOT be eliminated by debloating 
                        - this checks cases where the variable under consideration is not a 'provably' constant value, and hence the branch should not be folded.
      
**Guidelines for Writing Additional Test Cases**:
  * branchPruned should contain only one branch. As a result of specialization we expect 
           this branch to evaluate to true. The underlying block should contain a 
           printf call. Multiple branches can be joined by using '&&'.
  * branchNotPruned should also contain only one branch. Multiple branches 
           can be joined by using '||'. The underlying block should contain a printf call.

**Measuring Code Elimination**: If specialization is successful, the branchPruned function should 
                                     only contain the printf call that was conditional on the 
                                     branch. The branchNotPruned function should remain 
                                     unmodified (no code removed)    
    
    
