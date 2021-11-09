Trimmer Test Cases
==================

**Test Cases Directory Structure**:

The test cases directory, test/src contains following subdirectories:

  * **annotation_tests** contains test cases for annotation pass.
  * **loop_tests** contains test cases for loop unrolling pass.
  * **fileio_tests** contains test cases for file I/O specialization pass.
  * **constprop_tests** contains test cases for constant propagation pass.
  * **pointer_tests** contains test cases that deal with pointers.
  * **stress_tests** contains stress tests (e.g., dealing with large loop unroll count).
  * **bugfix_tests** contains test cases that fixes some bugs.  
  * **tofix_tests** contains test cases that needs fixing in a better way (for developers only).
  * **misc_tests** contains various other test cases that do not fit in other categories.
  * **data** contains text files used by test cases in fileio_tests.



Running Test Cases
------------------

Test cases directory: /test/src
      
* Includes a suite of multiple test cases used to measure the effectiveness of TRIMMER in debloating unused code. 
  
 
 **Running Test Examples**:

```
cd test/scripts
python test.py ./work_dir all 1 1
```
    
will run all the test cases placed in test/src.

```
python test.py ./work_dir pointer 1 1
```
    
will run test case inter1.c in test/src/pointer_tests.

    
```
python test.py ./work_dir constprop 1 10
```
    
will run test cases including inter1.c to inter10.c in test/src/constprop_tests (inclusive).

      
**Guidelines for Writing Additional Test Cases**:

In all test cases (except annotation_tests), we include functions with names 'branchPruned' and 'branchNotPruned'
  * **branchPruned** contains code branches that we expect should be eliminated by debloating. branchPruned should contain only one branch. As a result of specialization we expect this branch to evaluate to true. The underlying block should contain a printf call. Multiple branches can be joined by using '&&'.

  * **branchNotPruned** contains code branches that should NOT be eliminated by debloating. This checks cases where the variable under consideration is not a 'provably' constant value, and hence the branch should not be folded. branchNotPruned should also contain only one branch. Multiple branches  can be joined by using '||'. The underlying block should contain a printf call.

If specialization is successful, the branchPruned function should only contain the printf call that was conditional on the branch. 
The branchNotPruned function should remain unmodified (no code removed).

For annotation test cases, write **TRACK** in front of variable declaration, you want annotation pass to taint e.g,

```
int main(int argc, char ** argv) {
    char *temp[1] TRACK;
    temp[0] = argv[argc]; 
    return 0;
}
```

In this test case, we are checking whether "temp" is annotated by Trimmer annotation pass or not. If yes, then the test case passes else it fails.

To include additional test cases as part of all the test cases, modify tests.txt in test/scripts. In tests.txt, we mention start number and end number of test cases in each subdirectory in test/src. 
