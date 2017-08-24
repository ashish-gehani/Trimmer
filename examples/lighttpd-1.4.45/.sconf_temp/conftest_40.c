

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char stat();

int main() {
#if defined (__stub_stat) || defined (__stub___stat)
  fail fail fail
#else
  stat();
#endif

  return 0;
}
