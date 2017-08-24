

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char getcwd();

int main() {
#if defined (__stub_getcwd) || defined (__stub___getcwd)
  fail fail fail
#else
  getcwd();
#endif

  return 0;
}
