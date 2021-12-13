Trimmer
=======

Introduction
------------
**Trimmer** is a software debloating system that automatically specializes programs given only high-level user specifications. **Trimmer** provides (i) a simple mechanism for providing specialization specifications using a manifest file and (ii) effective specialization in reasonable analysis times, achieved by limiting context-sensitive transformations using the specified configuration parameters in the manifest file.

Further details can be found in our journal publication: https://ieeexplore.ieee.org/document/9478582

Build
-----

We provide a script [bootstrap.sh](vagrants/16.04/bootstrap.sh) to install the dependencies needed, including [LLVM](https://llvm.org)'s `clang` (version 7) sources and [SVF](https://github.com/SVF-tools/SVF), to build **Trimmer** and run it on the included examples. (**Note**: It replaces `~/.bash_profile`. Adjust as needed.) The build has been tested on Linux 16.04 with Python 3.5.2

At its core, the **Trimmer** build is effected with:
```
mkdir build
export TRIMMER_HOME=<path to top-level of Trimmer>
export LLVM_COMPILER=clang
cd build
cmake ../
make
```
   
If your system has unconventional names / locations for LLVM utilities, adjust the below environment variables as needed :

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

**Trimmer** operates on bitcode files, which can be generated using either [wllvm](https://github.com/SRI-CSL/whole-program-llvm) or [gllvm](https://github.com/SRI-CSL/gllvm). wllvm can be directly installed using pip:

```
pip install wllvm
```

Synopsis
--------

```
python ${TRIMMER_HOME}/tool/trimmer.py [manifest-file] [working-directory] [options]
```
Providing the _manifest file_ and _working-directory_ (i.e. where intermediate and final specialized files will be stored) is required. If options are not explicitly provided, **Trimmer** uses the default values. A list of options (along with the default values) can be found in [options.md](/docs/options.md). Moreover, a description of executing the specialized binaries after specialization can be found in [usage.md](/docs/usage.md).


Description of manifest file 
----------------------------

**Trimmer** provides a simple but powerful mechanism for specifying the deployment context to be used for program specialization, similar to the approach used by [OCCAM](https://github.com/ashish-gehani/OCCAM/). This consists of a _manifest_ file of key-value pairs in JSON format to describe the context for a target application:

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
-   **modules** : a list of paths to the other bitcode modules needed. Note that these modules will not be used for specialization since **Trimmer** does not support inter-module specialization (i.e. it operates only on a single bitcode file)
-   **binary** : the name of the desired executable
-   **native libs** : a list of flags (-lm, -lc, -lpthread) or paths to native objects (.o, .a, .so)
-   **ldflags** : a list of linker flags such as --static, --nostdlib
-   **args** : the list of arguments you wish to specialize in the main() function. Dynamic arguments are denoted by "_"
-   **config_files** : the list of application-specific configuration files

The manifest file for `aircrack-ng` (which is one of the examples provided in the [TSE-2020 benchmarks](/benchmarks/examples/TSE-2020)) is shown below:
 
``` 
{
   "binary": "aircrack-ng_fin", 
   "native_libs": [], 
   "name": "aircrack-ng", 
   "args": ["-b", "_","-a","wpa","-s","-w","password.lst","_"], 
   "modules": [], 
   "ldflags": ["-lssl","-lcrypto","-lpthread","sha1-sse2.S"], 
   "main": "aircrack-ng.bc", 
   "config_files": []
 }
 ```

Examples
--------

We provide multiple examples of application specialization with **Trimmer** in the [examples folder](/benchmarks/examples). The [TSE-2020 directory](/benchmarks/examples/TSE-2020) has 20 applications that were specialized with **Trimmer**. The results for these 20 applications can be found in [results.md](/docs/results.md). We also provide scripts to automatically run **Trimmer** on specified applications and return statistics. Instructions to run these scripts can be found [here](https://github.com/ashish-gehani/Trimmer/blob/master/benchmarks/README.md). 

Note: These applications were tested on Linux 16.04 with Python 3.5.2

#### Generating Bitcode Files
To run **Trimmer** on a new application, the whole-program bitcode must first be generated using `wllvm`/`gllvm`. The [wllvm repository](https://github.com/SRI-CSL/whole-program-llvm) provides examples and tutorials on generating bitcode files. The process of generating bitcode files can also be seen in the Makefiles of all of our examples. The examples in the **Trimmer** benchmarks currently use `wllvm` but can be modified to use `gllvm`. 

#### Linking Bitcode Modules
**Trimmer** does not provide inter-module specialization (i.e. it operates only on a single bitcode file). Therefore, if an application has multiple modules, they must be linked together into one module for specialization with **Trimmer**. Bitcode files can be linked into one using the [llvm linker](https://llvm.org/docs/CommandGuide/llvm-link.html). An example of this can be found in one of our examples, [imagemagick](/benchmarks/examples/Others/ImageMagick/Makefile) in the target _link_.

Debug
-----
By default, debug messages are not printed. To activate debugging logs, use:
```
export TRIMMER_DEBUG=Yes
```
The messages will be printed in a `log.txt` file.

<HR>

This material is based upon work supported by the National Science Foundation under Grant [ACI-1440800](http://www.nsf.gov/awardsearch/showAward?AWD_ID=1440800). Any opinions, findings, and conclusions or recommendations expressed in this material are those of the author(s) and do not necessarily reflect the views of the National Science Foundation.
