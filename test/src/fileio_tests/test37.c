/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

//tests fopen, fread and fseek

#include <stdio.h>
#include <stdlib.h>

void branchPruned(char * buffer, char * buffer1) {
  if(buffer[0]=='1' && buffer1[0]=='5')
    printf("branchPruned\n");

}

int main(int argc, char ** argv) {
  char buffer[100];
  char buffer1[100];
  FILE *fptr;
  fptr = fopen("../data/configFile37.txt", "rb");
  if(fptr==NULL) {
    printf("File not found");
    exit(1);
  }
  int size = fread(buffer, 1, 3, fptr); 
  int a = fseek(fptr,4,SEEK_SET);
  if(!a) { 
    size = fread(buffer1, 1, 7, fptr);
  } 
  fclose(fptr);
  branchPruned(buffer,buffer1); 
  return 0;
}
