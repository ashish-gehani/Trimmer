//tests fread in a loop

#include <stdio.h>
#include <stdlib.h>

void branchPruned(char * buffer) {
  if(buffer[0]=='1' && buffer[1]=='2' && buffer[2]=='3' && buffer[3]=='4' && buffer[4]=='5')
    printf("branchPruned\n");

}

int main(int argc, char ** argv) {
  char buffer[10];
  FILE *fptr;
  fptr = fopen("../data/configFile64.txt", "rb");
  if(fptr==NULL) {
    printf("File not found");
    exit(1);
  }
  int i=0;
  int j=0;
  int flag = 1;
  while(j<2){
  i=0;
  while(i<5)
  {
     if(j==1 && flag==1){
       i = i+5;
       flag = 0;
     }
     fread(&buffer[i], 1, 1, fptr);
     i++;
  }
  j++;
 }
  printf("%i\n",i);
  fclose(fptr);
  branchPruned(buffer); 
  return 0;
}
