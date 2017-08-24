

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char memset_s();

int main() {
#if defined (__stub_memset_s) || defined (__stub___memset_s)
  fail fail fail
#else
  memset_s();
#endif

  return 0;
}
