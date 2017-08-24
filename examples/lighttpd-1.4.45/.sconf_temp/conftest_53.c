

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char strstr();

int main() {
#if defined (__stub_strstr) || defined (__stub___strstr)
  fail fail fail
#else
  strstr();
#endif

  return 0;
}
