

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char strtol();

int main() {
#if defined (__stub_strtol) || defined (__stub___strtol)
  fail fail fail
#else
  strtol();
#endif

  return 0;
}
