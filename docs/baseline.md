How we have created our Baseline for Trimmer?
=============================================

We have created a Baseline binaries for each benchmark to compare the code size reduction and performance of Trimmer's generated binaries with it. The baseline is generated as follows:

1. Benchmarks are provided in Trimmer repository examples/ folder. Go to the respective benchmark's folder (e.g., mini_httpd) in examples folder and use make to generate the required bitcode 
   file (requires wllvm).
 
2. Apply -O3 optimzation to the bitcode file e.g., for mini_httpd use
```
opt -O3 mini_httpd.bc -o mini.bc
```

3. Use llc command to generate the object file from the optimized bitcode file.
```
llc -filetype=obj mini.bc -o mini.o
```

4. Use clang++ with -O3 flag to link with the dynamic libraries (if needed) and generate the binary file from the object file.
```
clang++ -O3 mini.o -lcrypt -o mini_httpd (where lcrypt is the dynamic library to be linked with)
```

5. Strip the binary file to generate the final binary.
```
strip mini_httpd
```
