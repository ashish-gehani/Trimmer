Trimmer
=======

Introduction
------------
**Trimmer** is a software debloating system that automatically specializes programs given only high-level user specifications. **Trimmer** provides (i) a simple mechanism for providing specialization specifications using a manifest file and (ii) effective specialization in reasonable analysis times, achieved by limiting context-sensitive transformations using the specified configuration parameters in the manifest file.

Further details can be found in:

* **Trimmer: An Automated System For Configuration-Based Software Debloating**, _IEEE Transactions on Software Engineering (TSE)_, 2022. [[PDF]](http://www.csl.sri.com/users/gehani/papers/TSE-2022.Trimmer.pdf)
* **Trimmer: Context-Specific Code Reduction**, _37th IEEE/ACM Conference on Automated Software Engineering (ASE)_, 2022. [[PDF]](http://www.csl.sri.com/users/gehani/papers/ASE-2022.Trimmer.pdf)

Build
-----

We provide a script [bootstrap.sh](vagrants/16.04/bootstrap.sh) to install the dependencies needed, including [LLVM](https://llvm.org)'s `clang` (version 7) sources and [SVF](https://github.com/SVF-tools/SVF), to build **Trimmer** and run it on the included examples. (**Note**: It replaces `~/.bash_profile`. Adjust as needed.) The build has been tested on Ubuntu 16.04 with Python 3.5.2

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
-   **binary** : the name of the desired executable. This is used as the first argument of argv.
-   **native libs** : a list of flags (-lm, -lc, -lpthread) or paths to native objects (.o, .a, .so)
-   **ldflags** : a list of linker flags such as --static, --nostdlib
-   **args** : the list of arguments you wish to specialize in the main() function. Dynamic arguments are denoted by "_"
-   **config_files** : the list of application-specific configuration files

The manifest file for `wget` (which is one of the examples provided in the [TSE-2020 benchmarks](/benchmarks/examples/TSE-2020)) is shown below:
 
``` 
{
    "main": "wget.bc", 
    "binary": "wget_fin", 
    "modules": [], 
    "native_libs":[],
    "ldflags": ["-luuid","-lgnutls","-lpcre", "-lnettle", "-lidn", "-lz", "-lpthread"], 
    "name": "wget", 
    "args": ["--config=wgetrc","_" ], 
    "config_files": ["wgetrc"]
}
 ```

Examples
--------

We provide multiple examples of application specialization with **Trimmer** in the [examples folder](/benchmarks/examples). The [TSE-2020 directory](/benchmarks/examples/TSE-2020) has 20 applications that were specialized with **Trimmer**. The results for these 20 applications can be found in [results.md](/docs/results.md). We also provide scripts to automatically run **Trimmer** on specified applications and return statistics. Instructions to run these scripts can be found [here](https://github.com/ashish-gehani/Trimmer/blob/master/benchmarks/README.md). 

Note: These applications were tested on Ubuntu 16.04 with Python 3.5.2

### Generating Bitcode Files
To run **Trimmer** on a new application, the whole-program bitcode must be generated using `wllvm`/`gllvm`. The [wllvm repository](https://github.com/SRI-CSL/whole-program-llvm) provides examples and tutorials on generating bitcode files. The process of generating bitcode files can also be seen in the Makefiles of all of our examples. The examples in the **Trimmer** benchmarks currently use `wllvm` but can be modified to use `gllvm`. 

### Compilation Requirements:
For Trimmer to work, the following requirements must be met for compiling the application:
1. Optnone attribute should be disabled in clang. This can be done by compiling the application with the `-Xclang -disable-O0-optnone` flags. This is necessary because clang-7 disables optimizations by default, which prevents Trimmer from performing specialization on the generated bitcode.

2. The application should not be compiled with debug flags or any optimizations (e.g. `-O2`, `-O3` etc). This can be ensured by removing these flags, if they exist, from the Makefile of the application 

### Linking Bitcode Modules
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
