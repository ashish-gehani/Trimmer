

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char pathconf();

int main() {
#if defined (__stub_pathconf) || defined (__stub___pathconf)
  fail fail fail
#else
  pathconf();
#endif

  return 0;
}
