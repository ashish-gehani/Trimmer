#include "annotate.h"
#include <string.h>

struct list {
    struct list *next;
    int data;
};
/*
 * Annotation test. Check if struct memory is tracked inside loop with
 * known induction variable involving structs
 */
char * argv[] = {"test", "-a", "-b", "-s", "hello"};
int argc = 5;


int external();
int main(argc) {
    int temp TRACK;
    int temp2 TRACK;
    int temp3;
    (unsigned) &temp &  (unsigned) &temp3;
    temp = argc;
    struct list *head = (struct list *) malloc(sizeof(struct list));
    head->data = 1;

    while(temp2 < 10 ) {
        head->data = 1;
        head->next = (struct list *) malloc(sizeof(struct list));
        if(temp2 == 3)
            head->data = argv[0][0];
        temp2 +=1;
    }
    
    temp3 = external();

    while(temp3 <= 12) {
        if(temp3 == 4) {
            external();
            temp3++;
        } else {
            temp3 += 2;
        }
    }
    
    return 0;
}
