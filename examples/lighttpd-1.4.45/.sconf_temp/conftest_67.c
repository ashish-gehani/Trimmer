

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char madvise();

int main() {
#if defined (__stub_madvise) || defined (__stub___madvise)
  fail fail fail
#else
  madvise();
#endif

  return 0;
}
