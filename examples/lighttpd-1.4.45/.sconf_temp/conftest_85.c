

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char jrand48();

int main() {
#if defined (__stub_jrand48) || defined (__stub___jrand48)
  fail fail fail
#else
  jrand48();
#endif

  return 0;
}
