#define TRACK __attribute__((annotate("")))

void *malloc(unsigned size) TRACK;
