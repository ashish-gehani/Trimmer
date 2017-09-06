/* This Test is expected to specialized the func function such that the branch is pruned out */

#include<stdio.h>
#include<string.h>
#include<stdlib.h>

struct stType {
  char obj[100];
  int arr[8];
};

struct stType __attribute__((annotate("specializeArg"))) st;

void __attribute__((annotate("specializeArg"))) branchPruned() {  
  if(st.arr[0] == 27 &&
    st.arr[7] == 55)
      printf("*** Branch Taken\n");      
}
void branchNotPruned(){  

  if(!strcmp(st.obj, "helloWorld") &&
    st.obj[4] == 'o' &&
    st.obj[9] == 'd')
      printf("*** Branch Not Taken\n");      
}
int main(int argc, char ** argv) {
  if(argc == 1) {
    memcpy(st.obj, "hellogorld\0", 11); 
    st.arr[0] = 27;
    st.arr[7] = 55;
  }
  else {
    memcpy(st.obj, "helloWorld\0", 11); 
    st.arr[0] = 27;
    st.arr[7] = 55;
  }
  branchPruned(); 
  branchNotPruned();
  return 0;
}