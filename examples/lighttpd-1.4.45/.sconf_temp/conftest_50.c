

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char strchr();

int main() {
#if defined (__stub_strchr) || defined (__stub___strchr)
  fail fail fail
#else
  strchr();
#endif

  return 0;
}
