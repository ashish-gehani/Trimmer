/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

//tests fgets

# include <stdio.h>
# include <string.h>

void branchPruned(char * str, char * str1) {
  if(!strcmp(str, "helloWorld\n") && !strcmp(str1, "abcgdhjriklvnglvf\n")) {
    printf("Branch Pruned");
  }
}

int main() {
  FILE* pFile;
  char mystring[30];
  char mystring1[30];

  pFile = fopen("../data/configFile39.txt","r");
  if (pFile==NULL)
    printf("File not found");
  char * str = fgets(mystring,30,pFile);
  if(str==NULL)
    printf("Read error");
  str = fgets(mystring1,30,pFile);
  if(str==NULL)
    printf("Read error");
  branchPruned(mystring,mystring1);
  fclose(pFile);
  return 0;
}
