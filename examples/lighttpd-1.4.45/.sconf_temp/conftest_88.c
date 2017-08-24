

#include <assert.h>
linux/random.h

int main() {
#if defined (__stub_getrandom) || defined (__stub___getrandom)
  fail fail fail
#else
  getrandom();
#endif

  return 0;
}
