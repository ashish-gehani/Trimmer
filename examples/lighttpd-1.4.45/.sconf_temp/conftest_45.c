

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char inet_ntoa();

int main() {
#if defined (__stub_inet_ntoa) || defined (__stub___inet_ntoa)
  fail fail fail
#else
  inet_ntoa();
#endif

  return 0;
}
