

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char sigaction();

int main() {
#if defined (__stub_sigaction) || defined (__stub___sigaction)
  fail fail fail
#else
  sigaction();
#endif

  return 0;
}
