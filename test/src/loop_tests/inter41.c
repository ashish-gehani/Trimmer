/* This test aims at testing whether the Pass skips the specialization of 'func' and 'func2', 
since they are not called once. 'func' is called twice from the 'main' function, while func2 is called in a loop */

#include<stdio.h>
#include<string.h>
#include<stdlib.h>

struct Node {
  int val;
  struct Node * next;
};

void branchPruned(struct Node * head) {
  // struct Node * node = head;
  // char c1 = node->val == 1;
  // node = node->next;
  // char c2 = node->val == 2;
  // node = node->next;  
  // char c3 = node->val == 3;
  // node = node->next;
  // char c4 = node->val == 4;
  // node = node->next;  
  // char c5 = node->val == 5;
  // node = node->next;
  // if(c1 && c2 && c3 && c4 && c5)
  //   printf("condition true");
  int i = 1;
  char cond = 1;
  for(struct Node * node = head; node != NULL; node = node->next, i++) {
    if(node->val != i) {
      cond = 0;
    }
  }
  if(cond)
    printf("condition true");
}


void initialize(struct Node * node, int val) {
  node->val = val;
} 

int main() {
  struct Node * head = malloc(sizeof(struct Node));
  head->next = malloc(sizeof(struct Node));
  head->next->next = malloc(sizeof(struct Node));
  head->next->next->next = malloc(sizeof(struct Node));
  head->next->next->next->next = malloc(sizeof(struct Node));
  head->next->next->next->next->next = NULL;

  int i = 1, total = 0;
  for(struct Node * node = head; node != NULL; node = node->next, i++) {
    initialize(node, i);
  }
  if(head->val == 1)
      printf("asdasda %d", total);
  branchPruned(head);
  return 0;
}
