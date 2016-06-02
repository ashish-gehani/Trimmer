# FileIO Specialization

#### Installation:
      
     1) Install llvm-3.8.
     2) Install clang-3.8
     3) Update llvm include directory in Makefile
     4) make
 

#### Runing the FileIO Pass
   
     The ./bin/run.sh script is a wrapper over the the File IO pass. 
     It runs an llvm pass of loop unrolling prior to executing the FileIO specialisation pass. 
     It takes the following two arguments: 

     a) Input_bitcode (.bc)
     b) Output_bitcode (.bc)


#### Examples
     
     Two example test programs with sources and bitcode are added under ./test.
     The descrition of each example is included at the top of the corresponding source files. 

     An example run is as follows:
        ./bin/run.sh  test/File_test1.bc  test/File_test2.bc

      
#### Limitations:
     
     1) The pass currently works for small loops. Specifically an unrolling factor of "100"
     is applied to each loop. This value can however be configured in ./bin/run.sh
     
     2) The module specializes unix calls of "read", "seek" etc. It does not specialise libc calls. 