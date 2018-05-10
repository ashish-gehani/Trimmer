
#include <stdio.h>

void func3(){
  printf("function: func3");
}

void func4(){
  printf("function: func4");
}

void func5(){
  printf("function: func5");
}

void func6(){
  printf("function: func6");
}

void func1(){
  printf("function: func1");
  func3();
}

void func2(){
  printf("function: func2");
}


int *random(){
  printf("function: random");
  func2();
  func4();
  func5();
  func6();
  return NULL;
}

int main(){

  func1();
  random();
  return 0;
}


