

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char getrlimit();

int main() {
#if defined (__stub_getrlimit) || defined (__stub___getrlimit)
  fail fail fail
#else
  getrlimit();
#endif

  return 0;
}
