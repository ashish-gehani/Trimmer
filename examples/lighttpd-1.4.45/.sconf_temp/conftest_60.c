

#include <assert.h>

#ifdef __cplusplus
extern "C"
#endif
char epoll_ctl();

int main() {
#if defined (__stub_epoll_ctl) || defined (__stub___epoll_ctl)
  fail fail fail
#else
  epoll_ctl();
#endif

  return 0;
}
