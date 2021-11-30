Trimmer Options
===============

Trimmer can be run by the following command

```
python ${TRIMMER_HOME}/tool/trimmer.py [manifest-file] [working-directory] [options]
```
Here, the environmental variable ${TRIMMER_HOME} points to the home directory where Trimmer is cloned. This variable is set automatically if Trimmer is built using the provided vagrant file ([bootstrap.sh](/vagrants/16.04/bootstrap.sh)). An example of running Trimmer can be found [here](/benchmarks/examples/TSE-2020/curl/Makefile) in the target _compress_. 

Optimization Level 
------------------

The optimization level specifies the level of optimization done by clang at the end of the Trimmer pipeline. By default, the optimization level is 3 (i.e. -O3 optimization). If you want to change the optimization level (0,1,2,3,s), run

```
python ${TRIMMER_HOME}/tool/trimmer.py [manifest-file] [working-directory] optLevel level (where level can be one of the options 0,1,2,3,s)
```


Constant Propagation
--------------------

Constant Propagation consists of loop unrolling, file I/O specialization and string specialization. By default, constant propagation is ON. To turn it OFF, run

```
python ${TRIMMER_HOME}/tool/trimmer.py [manifest-file] [working-directory] no-inter-constprop
```

Loop Unrolling, File I/O Specialization and String Specialization
-----------------------------------------------------------------

By default, loop unrolling, file I/O specialization and string specialization is ON. 

To only turn ON loop unrolling, run

```
python ${TRIMMER_HOME}/tool/trimmer.py [manifest-file] [working-directory] loop-unroll
```
To only turn ON file I/O specialization, run

```
python ${TRIMMER_HOME}/tool/trimmer.py [manifest-file] [working-directory] file-specialize
```

To only turn ON string specialization, run

```
python ${TRIMMER_HOME}/tool/trimmer.py [manifest-file] [working-directory] string-specialize
```

Similarly, different combinations of these specialization transforms can be turned on at the same time. For example, to turn on string and file specialization but not loop-unrolling, run 

```
python ${TRIMMER_HOME}/tool/trimmer.py [manifest-file] [working-directory] string-specialize file-specialize
```

Clone Limit
-----------

By default a function clone limit is unlimited (i.e. functions will be cloned for specialization as many times as required/possible). The number of function clones can be limited by using the **_exceedLimit_** option as such:

```
python ${TRIMMER_HOME}/tool/trimmer.py [manifest-file] [working-directory] exceedLimit limit (where limit is the number of clones that a function can not exceed)
```

This option can often be useful for applications in which unlimited function cloning results in larger binaries or when specialization takes too long to complete because of function clones. In our TSE-2020 benchmarks, we limited function clones for three applications: _wget_, _gprof_ and _objdump_. The optimum values for clone limit can be empirically determined. An example of running Trimmer with clone limiting can be found [here](/benchmarks/examples/TSE-2020/gprof/Makefile) in the target _gprof_.

Limiting Tracked Values:
------------------------
To control memory usage during constant propagation, we provide an option, **_trackedPercent_**, to limit the percentage of tracked values. This is done by prioritizing the tainted values by the number of times they are used as a source in load instructions and then selecting the specified percentage of values with the most dependent loads for tracking. This option is useful for programs that require maintenance of large amounts of shadow memory. Reducing the tracked values limits the number of contexts that need to be maintained simultaneously, thus reducing the memory consumed during constant propagation. By default, the value of _trackedPercent_ is set to 100 (i.e. all tainted variables are tracked).

For example, to track 50% of the tainted values, use:

```
python ${TRIMMER_HOME}/tool/trimmer.py [manifest-file] [working-directory] trackedPercent 50
```
An example of running Trimmer with limited value tracking can be found [here](/benchmarks/examples/Others/ImageMagick/Makefile) in the target _magick_.

ContextType
-----------

Trimmer supports context-insensitive(CI), sparse context-sensitive(sparse-CS) and full context-sensitive(full-CS) constant propagation. By default, the context is sparse-CS. The context type can be changed using **_contextType_** option. To run other context types, use

```
python ${TRIMMER_HOME}/tool/trimmer.py [manifest-file] [working-directory] contextType 0,1 or 2 (where 0 stands for CI, 1 stands for sparse-CS and 2 stands for full-CS.)
```

Track Global Variables
-----------

By default, sparse-CS only clones functions that have at least one tainted argument. If you want to clone functions that contain tainted global variables, you can use the **_useGlob_** option like below:

```
python ${TRIMMER_HOME}/tool/trimmer.py [manifest-file] [working-directory] useGlob
```




