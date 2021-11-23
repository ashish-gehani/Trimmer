/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

//st is the struct of stType, which contains a character array obj and an int array arr. It is set in a nonfolded branch, where st.arr is set to same value in both basic blocks of the branch, whereas st.obj is set to different values. Therefore,the branch in branchPruned function is pruned but not in branchNotPruned function.  

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
