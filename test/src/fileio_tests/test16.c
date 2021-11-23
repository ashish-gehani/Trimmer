/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

//test fgets call in a null-terminated loop 

# include <stdio.h>
# include <stdlib.h>


char * str1;
void branchPruned(int i,char* str1)
{
  if(i==6 && str1==NULL)
   printf("%s\n","branchPruned");

}

int main()
{

 FILE* fp;
 char str[14];
 int i=0;
 fp = fopen("../data/configFile16.txt","r");
 if(fp==NULL){ printf("%s\n","error opening file");exit(1);}
   str1 = fgets (str,13, fp);
 while(str1 != NULL ) {
   i++;
   str1 = fgets (str,13, fp);}
str1 = fgets(str,13,fp);
   
printf("%i\n",i);
branchPruned(i,str1);
fclose(fp);
return 0;

}
 

