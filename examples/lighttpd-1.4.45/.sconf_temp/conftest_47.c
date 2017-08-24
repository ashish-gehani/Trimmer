

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char memset();

int main() {
#if defined (__stub_memset) || defined (__stub___memset)
  fail fail fail
#else
  memset();
#endif

  return 0;
}
