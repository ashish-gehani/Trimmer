

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char crypt();

int main() {
#if defined (__stub_crypt) || defined (__stub___crypt)
  fail fail fail
#else
  crypt();
#endif

  return 0;
}
