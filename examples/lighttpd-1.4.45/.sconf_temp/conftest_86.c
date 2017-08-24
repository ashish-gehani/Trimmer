

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char srandom();

int main() {
#if defined (__stub_srandom) || defined (__stub___srandom)
  fail fail fail
#else
  srandom();
#endif

  return 0;
}
