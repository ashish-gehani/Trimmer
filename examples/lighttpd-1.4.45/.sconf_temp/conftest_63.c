

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char getuid();

int main() {
#if defined (__stub_getuid) || defined (__stub___getuid)
  fail fail fail
#else
  getuid();
#endif

  return 0;
}
