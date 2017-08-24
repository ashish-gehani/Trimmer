

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char prctl();

int main() {
#if defined (__stub_prctl) || defined (__stub___prctl)
  fail fail fail
#else
  prctl();
#endif

  return 0;
}
