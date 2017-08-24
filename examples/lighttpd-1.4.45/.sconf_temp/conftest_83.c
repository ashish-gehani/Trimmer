

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char getentropy();

int main() {
#if defined (__stub_getentropy) || defined (__stub___getentropy)
  fail fail fail
#else
  getentropy();
#endif

  return 0;
}
