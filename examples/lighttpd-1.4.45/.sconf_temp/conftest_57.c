

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char socket();

int main() {
#if defined (__stub_socket) || defined (__stub___socket)
  fail fail fail
#else
  socket();
#endif

  return 0;
}
