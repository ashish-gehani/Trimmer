

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char strdup();

int main() {
#if defined (__stub_strdup) || defined (__stub___strdup)
  fail fail fail
#else
  strdup();
#endif

  return 0;
}
