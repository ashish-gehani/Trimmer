

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char posix_fadvise();

int main() {
#if defined (__stub_posix_fadvise) || defined (__stub___posix_fadvise)
  fail fail fail
#else
  posix_fadvise();
#endif

  return 0;
}
