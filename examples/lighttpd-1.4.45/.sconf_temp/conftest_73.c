

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char kqueue();

int main() {
#if defined (__stub_kqueue) || defined (__stub___kqueue)
  fail fail fail
#else
  kqueue();
#endif

  return 0;
}
