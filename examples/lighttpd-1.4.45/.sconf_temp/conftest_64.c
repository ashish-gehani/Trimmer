

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char select();

int main() {
#if defined (__stub_select) || defined (__stub___select)
  fail fail fail
#else
  select();
#endif

  return 0;
}
