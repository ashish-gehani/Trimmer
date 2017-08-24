

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char strerror();

int main() {
#if defined (__stub_strerror) || defined (__stub___strerror)
  fail fail fail
#else
  strerror();
#endif

  return 0;
}
