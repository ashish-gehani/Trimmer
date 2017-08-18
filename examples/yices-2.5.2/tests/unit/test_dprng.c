/*
 * TEST OF PSEUDO-RANDOM NUMBER GENERATORS.
 */

#include <stdio.h>

#include "utils/dprng.h"

int main(void) {
  double seed, s, d;
  int i;

  seed = DPRNG_DEFAULT_SEED;
  for (i=0; i<10000000; i++) {
    s = seed;
    d = drand(&seed);
    printf("round %d: seed = %10.0f, dprng = %0.40f\n", i, s, d);
  }

  return 0;
}
