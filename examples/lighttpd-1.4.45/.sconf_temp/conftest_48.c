

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char mmap();

int main() {
#if defined (__stub_mmap) || defined (__stub___mmap)
  fail fail fail
#else
  mmap();
#endif

  return 0;
}
