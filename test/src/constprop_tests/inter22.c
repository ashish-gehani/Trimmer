/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

/* This Test is expected to specialized the func function such that the branch is pruned out */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

struct stType {
  int x;
  int y;
  char * buffer;
  void (*init) (struct stType * st);
};

void branchPruned(struct stType * st) {
  if(st[0].x == 0 && st[0].y == 0 && !strcmp(st[0].buffer, "helloworld0") &&
  st[1].x == 1 && st[1].y == 1 && !strcmp(st[1].buffer, "helloworld1") &&
  st[2].x == 2 && st[2].y == 2 && !strcmp(st[2].buffer, "helloworld2") &&
  st[3].x == 3 && st[3].y == 3 && !strcmp(st[3].buffer, "helloworld3"))
    printf("branchPruned\n");
}

void init0(struct stType * st) {
	st->x = 0;
	st->y = 0;
	st->buffer = malloc(sizeof(char) * 100);
	memset(st->buffer, '\0', 100);
	memcpy(st->buffer, "helloworld0", 100);
}	


void init1(struct stType * st) {
	st->x = 1;
	st->y = 1;
	st->buffer = malloc(sizeof(char) * 100);
	memset(st->buffer, '\0', 100);
	memcpy(st->buffer, "helloworld1", 100);
}	


void init2(struct stType * st) {
	st->x = 2;
	st->y = 2;
	st->buffer = malloc(sizeof(char) * 100);
	memset(st->buffer, '\0', 100);
	memcpy(st->buffer, "helloworld2", 100);
}	


void init3(struct stType * st) {
	st->x = 3;
	st->y = 3;
	st->buffer = malloc(sizeof(char) * 100);
	memset(st->buffer, '\0', 100);
	memcpy(st->buffer, "helloworld3", 100);
}	

struct stType st[] = {{0, 0, NULL, &init0}, {0, 0, NULL, &init1}, {0, 0, NULL, &init2}, {0, 0, NULL, &init3}};

int main(){
  (*st[0].init)(&st[0]);
  (*st[1].init)(&st[1]);
  (*st[2].init)(&st[2]);
  (*st[3].init)(&st[3]);

  branchPruned(st);
  return 0;
}
