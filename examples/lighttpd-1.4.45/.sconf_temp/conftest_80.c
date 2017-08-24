

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char explicit_bzero();

int main() {
#if defined (__stub_explicit_bzero) || defined (__stub___explicit_bzero)
  fail fail fail
#else
  explicit_bzero();
#endif

  return 0;
}
