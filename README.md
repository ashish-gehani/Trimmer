Trimmer
=======


Build
-----

We provide a bash script `build.sh` to build the dependencies to run TRIMMER, namely LLVM and Clang (Version 7.0.0) and [SVF](https://github.com/SVF-tools/SVF).


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

TRIMMER also requires either wllvm or gclang

```
pip install wllvm
```


Synopsis
--------

```
python ${TRIMMER_HOME}/tool/trimmer.py [manifest-file] [working-directory]
```

Description of manifest file 
----------------------------
    
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
--------
```
mkdir examples/tool_name/work_dir
python ${TRIMMER_HOME}/tool/trimmer.py   ${TRIMMER_HOME}/examples/tool_name/tool.manifest  ${TRIMMER_HOME}/examples/tool_name/work_dir      
```

This material is based upon work supported by the National Science Foundation under Grant [ACI-1440800](http://www.nsf.gov/awardsearch/showAward?AWD_ID=1440800). Any opinions, findings, and conclusions or recommendations expressed in this material are those of the author(s) and do not necessarily reflect the views of the National Science Foundation.
