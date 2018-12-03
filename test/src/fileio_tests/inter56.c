//tests fread in a loop

#include <stdio.h>
#include <stdlib.h>

void branchPruned(char * buffer) {
  if(buffer[0]=='1' && buffer[1]=='2' && buffer[2]=='3' && buffer[3]=='4' && buffer[4]=='5' && buffer[5]=='6'&& buffer[6]=='7'&& buffer[7]=='8'&& buffer[8]=='9'&& buffer[9]=='0')
    printf("branchPruned\n");

}

int main(int argc, char ** argv) {
  char buffer[10];
  FILE *fptr;
  fptr = fopen("../data/configFile56.txt", "rb");
  if(fptr==NULL) {
    printf("File not found");
    exit(1);
  }
  int i=0;
  while(fread(&buffer[i], 1, 1, fptr))
  {
     i++;
  }
  printf("%i\n",i);
  fclose(fptr);
  branchPruned(buffer); 
  return 0;
}
