#include <stdio.h>
struct temp {
  int a;
};

int testing = 0;
int *temp;
void branchPruned(int);
void test1() {
  testing = 1;
  test1(10);
}
void branchPruned(int test) {
  if (test == 10)
    printf("branchPruned");
  else {
    branchPruned(test-1);
    test1();
  }

}

int external();
void checkptCall();

int main(int argc, char **argv) {
  int a = 20;
  int b = 20; 
  struct temp t;
  struct temp *z = malloc(sizeof(struct temp));
  z->a = 10;
  t.a = 10; 
    
  //struct temp t2;
  //checkptCall();

  test1(); 
  branchPruned(z->a);
}
