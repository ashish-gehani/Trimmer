# Patch
Due to a known limitation in the LLVM-v7 loop unrolling transformation, we required a minor change to a loop in function read_config of thttpd.c. The loop is not unrolled by llvm, so the loop is converted into an equivalent loop, which can be unrolled by llvm. This patch can be seen in thttpd.patch.
