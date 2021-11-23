# Patch
Function futimens in lib/utimens.c contradicts with sys/stat.h futimens function so the name of the function is changed from futimens to cu_futimens; otherwise we encountered a compilation error. The patch can be seen in gzip.patch.
