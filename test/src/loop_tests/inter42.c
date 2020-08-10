/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

/* This test aims at testing whether the Pass skips the specialization of 'func' and 'func2', 
since they are not called once. 'func' is called twice from the 'main' function, while func2 is called in a loop */

#include<stdio.h>
#include<string.h>
#include<stdlib.h>

struct Node {
  int val;
  char * buffer;
  struct Node * next;
};

void branchPruned(struct Node * head) {
  int i = 1;
  char cond = 1;
  char cmpStr[11];
  cmpStr[10] = '\0';
  for(struct Node * node = head; node != NULL; node = node->next, i++) {
    if(node->val != i)
      cond = 0;
    for(int j = 0; j < 10; j++)
      cmpStr[j] = 'a' + i + j;
    if(strcmp(node->buffer, cmpStr))
      cond = 0;
  }
  if(cond)
    printf("condition true");
}

int main() {
  struct Node * head = malloc(sizeof(struct Node));
  head->next = malloc(sizeof(struct Node));
  head->next->next = malloc(sizeof(struct Node));
  head->next->next->next = malloc(sizeof(struct Node));
  head->next->next->next->next = malloc(sizeof(struct Node));
  head->next->next->next->next->next = NULL;

  int i = 1;      
  for(struct Node * node = head; node != NULL; node = node->next, i++) {
    node->val = i;
    node->buffer = malloc(sizeof(char) * 11);
    for(int j = 0; j < 10; j++)
      node->buffer[j] = 'a' + i + j;
    node->buffer[10] = '\0';
  }
  branchPruned(head);
  return 0;
}
