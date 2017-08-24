

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char lstat();

int main() {
#if defined (__stub_lstat) || defined (__stub___lstat)
  fail fail fail
#else
  lstat();
#endif

  return 0;
}
