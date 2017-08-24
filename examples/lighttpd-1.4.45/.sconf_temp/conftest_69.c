

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char writev();

int main() {
#if defined (__stub_writev) || defined (__stub___writev)
  fail fail fail
#else
  writev();
#endif

  return 0;
}
