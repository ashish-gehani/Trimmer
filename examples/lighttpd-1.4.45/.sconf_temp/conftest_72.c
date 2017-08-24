

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char send_file();

int main() {
#if defined (__stub_send_file) || defined (__stub___send_file)
  fail fail fail
#else
  send_file();
#endif

  return 0;
}
