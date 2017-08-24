

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char localtime_r();

int main() {
#if defined (__stub_localtime_r) || defined (__stub___localtime_r)
  fail fail fail
#else
  localtime_r();
#endif

  return 0;
}
