# Patches
1. Function getline in htpasswd.c contradicts with stdio.h getline function so the name of the function is changed from getline to getline1; otherwise we encountered a compilation error.
2. Due to a known limitation in the LLVM-v7 loop unrolling transformation, we required a minor change to a loop in function read_config of mini_httpd.c. The loop is not unrolled by llvm, so the loop is converted into an equivalent loop, which can be unrolled by llvm. 

The patches can be seen in mini_httpd.patch.
