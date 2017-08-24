

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char gethostbyname();

int main() {
#if defined (__stub_gethostbyname) || defined (__stub___gethostbyname)
  fail fail fail
#else
  gethostbyname();
#endif

  return 0;
}
