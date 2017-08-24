

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char chroot();

int main() {
#if defined (__stub_chroot) || defined (__stub___chroot)
  fail fail fail
#else
  chroot();
#endif

  return 0;
}
