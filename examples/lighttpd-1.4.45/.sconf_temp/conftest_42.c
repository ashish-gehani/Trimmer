

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char strftime();

int main() {
#if defined (__stub_strftime) || defined (__stub___strftime)
  fail fail fail
#else
  strftime();
#endif

  return 0;
}
