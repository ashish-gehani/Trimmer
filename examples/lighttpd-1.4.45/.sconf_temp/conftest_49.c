

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char munmap();

int main() {
#if defined (__stub_munmap) || defined (__stub___munmap)
  fail fail fail
#else
  munmap();
#endif

  return 0;
}
