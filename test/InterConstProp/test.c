#include<stdio.h>
#include<string.h>
#include<stdlib.h>

struct COORD {
  int x, y;
};
struct stType {
  struct COORD coord;
  struct COORD* coord2;
  struct COORD coord3;
  char * str;
  int arr[8];
};

void branchPruned(struct stType* st, struct stType* st2) {
	if(st->coord.x == 15 && st2->coord2->y == 18)
		printf("branchPruned\n");
}

int main() {
	struct COORD c1;
	c1.x = 20;
	c1.y = 25;

	struct stType* st = malloc(sizeof(struct stType)); // malloc, bitcast, store
	st->coord.x = 15; // load .. gep 0, 0 .. gep 0, 0 .. store
	st->coord.y = 16;
	st->coord2 = malloc(sizeof(struct COORD)); // malloc, bitcast, gep 0, 0 .. store
	st->coord2->x = 17;
	st->coord2->y = 18;
	st->coord3 = c1; // bitcast, bitcast, memcpy

	struct stType st2;
	st2.coord.x = 15;
	st2.coord.y = 16;
	st2.coord2 = st->coord2;
	st2.coord3 = *st->coord2;
	branchPruned(st, &st2);
}