

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char clock_gettime();

int main() {
#if defined (__stub_clock_gettime) || defined (__stub___clock_gettime)
  fail fail fail
#else
  clock_gettime();
#endif

  return 0;
}
