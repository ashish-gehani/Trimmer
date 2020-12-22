Trimmer Options
===============


Trimmer can be run by following command

```
python ${TRIMMER_HOME}/tool/trimmer.py [manifest-file] [working-directory]
```

Optimization Level 
------------------

By default, the optimization level is 3. If you want to change the optimization level(0,1,2,3,s), run

```
python ${TRIMMER_HOME}/tool/trimmer.py [manifest-file] [working-directory] optLevel level (where level can be one of the options 0,1,2,3,s)
```

Constant Propagation
--------------------

Constant Propagation consists of loop unrolling, file I/O specialization and string specialization. By default, constant propagation is ON. To OFF it, run

```
python ${TRIMMER_HOME}/tool/trimmer.py [manifest-file] [working-directory] no-inter-constprop
```

Loop Unrolling, File I/O Specialization and String Specialization
-----------------------------------------------------------------

By default, loop unrolling, file I/O specialization and string specialization is ON. 

To only ON loop unrolling, run

```
python ${TRIMMER_HOME}/tool/trimmer.py [manifest-file] [working-directory] loop-unroll
```
To only ON file I/O specialization, run

```
python ${TRIMMER_HOME}/tool/trimmer.py [manifest-file] [working-directory] file-specialize
```

To only ON string specialization, run

```
python ${TRIMMER_HOME}/tool/trimmer.py [manifest-file] [working-directory] string-specialize
```

Clone Limit
-----------

By default a function clone limit is unlimited. If you want to limit the number of clones of a function, run

```
python ${TRIMMER_HOME}/tool/trimmer.py [manifest-file] [working-directory] exceedLimit limit (where limit is the number of clones that a function can not exceed)
```

