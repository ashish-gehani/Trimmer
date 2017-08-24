

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char arc4random_buf();

int main() {
#if defined (__stub_arc4random_buf) || defined (__stub___arc4random_buf)
  fail fail fail
#else
  arc4random_buf();
#endif

  return 0;
}
