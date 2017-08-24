

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char signal();

int main() {
#if defined (__stub_signal) || defined (__stub___signal)
  fail fail fail
#else
  signal();
#endif

  return 0;
}
