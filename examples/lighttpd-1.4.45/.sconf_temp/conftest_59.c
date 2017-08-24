

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char poll();

int main() {
#if defined (__stub_poll) || defined (__stub___poll)
  fail fail fail
#else
  poll();
#endif

  return 0;
}
