/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

//Annotation test check if pointers are tracked

#include <stdio.h>
#include "annotate.h"




int main(int argc, char **argv) {
  int *a = malloc(sizeof(int));
  int *b = malloc(sizeof(int)); 
  int *d = malloc(sizeof(int));
  int **c TRACK;
  *a = argv[0][0];
  *b = argv[0][1];
  *d = argv[0][2];

  if(argc == 10) {
    c = &a;
    printf("asd");
  } else {
    c = &b;
    printf("zxc");
  }

  *c = d;

}
