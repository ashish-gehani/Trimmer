Trimmer
=======

Build
-----

We provide a script `build.sh` to install the dependencies needed to build and run **Trimmer**, namely [LLVM](https://llvm.org)'s `clang` (version 7) sources and [SVF](https://github.com/SVF-tools/SVF).

```
bash build.sh
mkdir build
export TRIMMER_HOME=/path/to/root/directory
export LLVM_COMPILER=clang
cd build
cmake ../
make
```
   
If your system has unconventional names / locations for LLVM utilities, adjust the below environment variables as needed:

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

**Trimmer** also requires either [wllvm](https://github.com/SRI-CSL/whole-program-llvm) or [gllvm](https://github.com/SRI-CSL/gllvm). The examples in the **Trimmer** benchmarks currently use `wllvm` but can be modified to use `gllvm`.

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
    

**Trimmer** provides a simple but powerful mechanism for specifying the deployment context to be used for program specialization, similar to the approach used by [OCCAM](https://github.com/ashish-gehani/OCCAM/). This consists of a _manifest_ file of key-valeue pairs in JSON format to describe the context for a target application:

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

-   **main** : a path to the bitcode module containing the main entry point
-   **modules** : a list of paths to the other bitcode modules needed
-   **binary** : the name of the desired executable
-   **native libs** : a list of flags (-lm, -lc, -lpthread) or paths to native objects (.o, .a, .so)
-   **ldflags** : a list of linker flags such as --static, --nostdlib
-   **args** : the list of arguments you wish to specialize in the main() function
-   **config_files** : the list of application-specific configuration files

The manifest file for `curl` (which is one of the examples provided) is shown below:

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
By default, debug messages are not printed. To activate this ouput, use:
```
export TRIMMER_DEBUG=Yes
```
The messages will be printed in a `log.txt` file.

<HR>

This material is based upon work supported by the National Science Foundation under Grant [ACI-1440800](http://www.nsf.gov/awardsearch/showAward?AWD_ID=1440800). Any opinions, findings, and conclusions or recommendations expressed in this material are those of the author(s) and do not necessarily reflect the views of the National Science Foundation.
