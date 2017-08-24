

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char inet_ntop();

int main() {
#if defined (__stub_inet_ntop) || defined (__stub___inet_ntop)
  fail fail fail
#else
  inet_ntop();
#endif

  return 0;
}
