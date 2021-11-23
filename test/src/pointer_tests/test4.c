/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

//test whether the array becomes non-constant when its address is taken in a nonfolded branch and value is changed through that pointer

#include <string.h>
#include <stdio.h>

char a[] = "asd";
char b[] = "afg";

void external(char *);
void external2(char *);
void branchNotPruned(char a) {
  if(a == 'a')
    printf("branchNotPruned");
}
int main(int argc, char ** argv) {
  char *temp;
  int i = 0;
  for(i = 0; i < argc; i++) {
    if(argc && strcmp(a, "asd")) {
      temp = a+1;
    } else {
      temp = b+2;
    }
  }
  
  *temp = 'd';
  branchNotPruned(a[0]);
  return 0;
}
