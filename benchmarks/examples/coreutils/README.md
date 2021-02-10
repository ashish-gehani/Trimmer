1. Build the bitcode for all the coreutils programs. This step will take several minutes.

```
make
```

2. To occamize the program PROG then

```
      cd PROG
      make 
      ./build.sh --disable-inlining
```
