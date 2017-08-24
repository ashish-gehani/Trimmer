

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char issetugid();

int main() {
#if defined (__stub_issetugid) || defined (__stub___issetugid)
  fail fail fail
#else
  issetugid();
#endif

  return 0;
}
