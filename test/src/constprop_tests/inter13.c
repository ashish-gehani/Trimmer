/* This Test is expected to specialized the func function such that the branch is pruned out */

#include<stdio.h>
#include<string.h>
#include<stdlib.h>

struct stType {
  char obj[100];
  int arr[8];
};

void branchPruned(struct stType st) {  
  if(st.arr[0] == 27 &&
    st.arr[7] == 55)
      printf("*** Branch Taken\n");      
}
void branchNotPruned(struct stType st){  

  if(!strcmp(st.obj, "helloWorld") &&
    st.obj[4] == 'o' &&
    st.obj[9] == 'd')
      printf("*** Branch Not Taken\n");      
}
int main(int argc, char ** argv) {
  struct stType st;
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
  branchPruned(st); 
  branchNotPruned(st);
  return 0;
}