#include<stdio.h>
#include<string.h>
#include<stdlib.h>

struct PAIR {
	int x, y;
};

struct COORDS {
	struct PAIR pair;
};

void func(struct COORDS* coords) {
	coords->pair.x = 5;
	coords->pair.y = 7;
} 

int main(){

  struct COORDS coords;
  func(&coords);
  return coords.pair.x + coords.pair.y;
}