

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char inet_pton();

int main() {
#if defined (__stub_inet_pton) || defined (__stub___inet_pton)
  fail fail fail
#else
  inet_pton();
#endif

  return 0;
}
