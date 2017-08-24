

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char dup2();

int main() {
#if defined (__stub_dup2) || defined (__stub___dup2)
  fail fail fail
#else
  dup2();
#endif

  return 0;
}
