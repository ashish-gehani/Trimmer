#include<stdio.h>
#include<string.h>
#include<stdlib.h>

struct COORD {
  int x, y;
};
struct stType{
  char str[100];
};


void branchPruned(struct stType obj){  
	switch(obj.str[0]) {
		case 'a':
			printf("a\n");
			break;
		case 'b':
			printf("b\n");
			break;
		case 'c':
			printf("c\n");
			break;
		case 'd':
			printf("d\n");
			break;
		case 'e':
			printf("e\n");
			break;
		case 'f':
			printf("f\n");
			break;						
		case 'h':
			printf("h\n");
	}
}

void initialize(struct stType* obj) {
  memcpy(obj->str, "helloWorld\0", 11);
} 

int main(){

  struct stType obj;
  initialize(&obj); 
  branchPruned(obj);

  return 0;
}
