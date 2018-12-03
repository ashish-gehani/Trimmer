#include<stdio.h>
#include<string.h>
#include<stdlib.h>

int branchPruned(int x) {
    int count = 0;
    for(int i = 0; i <= 100000; i++)
        count += i;
    return count; 
}

int main(){
  int a = branchPruned(1);
  return a;
}
