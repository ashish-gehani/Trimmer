

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char pipe2();

int main() {
#if defined (__stub_pipe2) || defined (__stub___pipe2)
  fail fail fail
#else
  pipe2();
#endif

  return 0;
}
