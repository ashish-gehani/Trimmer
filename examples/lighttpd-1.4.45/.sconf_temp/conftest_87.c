

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char getloadavg();

int main() {
#if defined (__stub_getloadavg) || defined (__stub___getloadavg)
  fail fail fail
#else
  getloadavg();
#endif

  return 0;
}
