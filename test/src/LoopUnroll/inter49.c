/* This test aims at testing whether the Pass skips the specialization of 'func' and 'func2', 
since they are not called once. 'func' is called twice from the 'main' function, while func2 is called in a loop */

#include<stdio.h>
#include<string.h>
#include<stdlib.h>

struct Node {
  struct Node * next;
  char * buffer;
  int len;
};

struct Node * getNode(char * str) {
  struct Node  * node = malloc(sizeof(struct Node));
  node->len = strlen(str) + 1;
  node->buffer = malloc(node->len);
  memcpy(node->buffer, str, node->len);
  node->next = NULL;
  return node;
}

void addNode(struct Node * node, char * str) {
  if(!node->next) node->next = getNode(str);  
  else { 
    while(node->next) node = node->next;    
    addNode(node, str);
  }
}

void increment(int * a) {
  *a = *a + 1;
}

void branchPruned(struct Node * node) {
  char * cmp[10] = {"A1", "B2", "C3", "D4", "E5", "F6", "G7", "H8", "I9", "J10"};
  int cond = 1;
  for(int i = 0; i < 10; i++, node = node->next) {
    if(strcmp(cmp[i], node->buffer))
      cond = 0;
  }
  if(cond) printf("branchPruned\n");
}

int main() {
  char * argv[10] = {"A1", "B2", "C3", "D4", "E5", "F6", "G7", "H8", "I9", "J10"};
  struct Node * head = getNode(argv[0]);
  int i = 1;
  while(i < 10) {
    addNode(head, argv[i]);
    increment(&i);
    struct Node * node = head;
  }
  branchPruned(head);
  return 0;
}