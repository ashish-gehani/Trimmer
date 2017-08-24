

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char crypt_r();

int main() {
#if defined (__stub_crypt_r) || defined (__stub___crypt_r)
  fail fail fail
#else
  crypt_r();
#endif

  return 0;
}
