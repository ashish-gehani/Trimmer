

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char fork();

int main() {
#if defined (__stub_fork) || defined (__stub___fork)
  fail fail fail
#else
  fork();
#endif

  return 0;
}
