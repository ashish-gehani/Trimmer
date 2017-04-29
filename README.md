# File I/O Specialization

#### Build:
      
     1) Install llvm-3.8.
     2) Install clang-3.8
     3) Update llvm include directory in Makefile
     4) make
 

#### Run
   
     The ./bin/run.sh script is a wrapper over the the File IO pass. 
     It runs an llvm pass of loop unrolling prior to executing the FileIO specialisation pass. 
     It takes the following two arguments: 

     a) Input_bitcode (.bc)
     b) Output_bitcode (.bc)

     Note: flag '-o' to specify the output file is NOT required

#### Examples
     
     Two example test programs with sources and bitcode are added under ./test.
     The descrition of each example is included at the top of the corresponding source files. 

     An example run is as follows:
        ./bin/run.sh  test/File_test1.bc  test/File_test2.bc

      
#### Debugging:
     
     The debugPrint macro should be set to 0 to disable debug print messages on the console.