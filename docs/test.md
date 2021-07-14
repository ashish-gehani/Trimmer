Trimmer
=======



Running test cases
------------------

Test cases directory: /test/src
      
* Includes a suite of multiple test cases used to measure the effectiveness of TRIMMER in debloating unused code 
 
 **Test script synopsis**:

For tests placed in test/src, where ${prefix} is the prefix of the folder in test/src
 
```
cd test/scripts
python test.py ${path_to_workdir} ${prefix} ${test_start} ${test_end} 
``` 
 
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

 ```
python test.py ./work_dir all 1 1
```
 
 will run all the test cases in all the directories.


In all test cases (excluding annotation tests), we include functions with names 'branchPruned' and 'branchNotPruned'
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

---
