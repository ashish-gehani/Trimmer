

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char sendfile64();

int main() {
#if defined (__stub_sendfile64) || defined (__stub___sendfile64)
  fail fail fail
#else
  sendfile64();
#endif

  return 0;
}
