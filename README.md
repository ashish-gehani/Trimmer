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

TRIMMER also requires either wllvm or gclang. The examples in the trimmer benchmarks currently use wllvm but can be modified to use gclang.

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
    

Trimmer provides a simplistic but powerful representation for specifying the details for program specialization. The manifest file format is a specific instance of the JSON representation where Trimmer users fill-in key,value pairs. The structure of a manifest file is shown below:

```
{ "main" : "prog.bc"
, "binary" : "progfin"
, "modules" : []
, "nativelibs"  : [ "−lm" , ... ]
, "ldflags" : [ "−static" , ... ]
, "name" : "prog"
, "args" : [ "arg1" , ... ]
, "config_files": []
}
```

-   **main** : a path to the bitcode module containing the main entry point.
-   **modules** : a list of paths to the other bitcode modules needed.
-   **binary** : the name of the desired executable.
-   **native libs** : a list of flags (-lm, -lc, -lpthread) or paths to native objects (.o, .a, .so)
-   **ldflags** : a list of linker flags such as --static, --nostdlib
-   **args** : the list of arguments you wish to specialize in the main() of main.
-   **config_files** : the list of application-specific configuration files

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

Debug
-----
By default, debug messages are off. If you want to see debug messages,
```
export TRIMMER_DEBUG=Yes
```
The debug messages will be printed in log.txt file.







This material is based upon work supported by the National Science Foundation under Grant [ACI-1440800](http://www.nsf.gov/awardsearch/showAward?AWD_ID=1440800). Any opinions, findings, and conclusions or recommendations expressed in this material are those of the author(s) and do not necessarily reflect the views of the National Science Foundation.
