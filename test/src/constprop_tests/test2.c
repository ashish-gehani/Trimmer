/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

//tests constant propagation across function, strcmp and memcpy. The modify function modifies buffer[1] in a nonfolded branch so buffer[1] will become non-constant whereas buffer[0] remains constant so branch in branchPruned function will be pruned whereas branch in branchNotPruned function will remain same.

#include<stdio.h>
#include<string.h>
#include<stdlib.h>

void branchPruned(char * buffer) {
	if(buffer[0] == 'i')
		printf("branchPruned\n");
}

void branchNotPruned(char * buffer) {
	if(buffer[1] == 'a' ||
	buffer[1] == 'e'|| 
	strcmp(buffer, "ielloWorld") ||
	strcmp(buffer, "ialloWorld"))
		printf("branchNotPruned\n");
}
 
void modify(char * buffer, int val, int argc) {
	if(val == 3)
		buffer[0] = 'i';
	if(argc == 5)
		buffer[1] = 'a';
}

char buffer[100];
int main(int argc, char ** argv){
  memcpy(buffer, "helloWorld", 100);
  modify(buffer, 3, argc);
  branchPruned(buffer);
  branchNotPruned(buffer);
  return 0;
}
