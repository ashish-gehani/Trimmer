//tests fread in a loop

#include <stdio.h>
#include <stdlib.h>

void branchPruned(char * buffer) {
  if(buffer[0]=='1' && buffer[1]=='2' && buffer[2]=='3' && buffer[3]=='4' && buffer[4]=='5')
    printf("branchPruned\n");

}

int main(int argc, char ** argv) {
  char buffer[5];
  FILE *fptr;
  fptr = fopen("../data/configFile51.txt", "rb");
  if(fptr==NULL) {
    printf("File not found");
    exit(1);
  }
  int n = 5;


  for(int i=0;i<5;i++)
  {
   fread(&buffer[i], 1, 1, fptr); 
  }
  
  fclose(fptr);
  branchPruned(buffer); 
  return 0;
}
