#include "annotate.h"
#include <string.h>

/*
 * Annotation test. Check if memory in loops with known induction variables
 * dependent on argc/argv are tracked
 */
char * argv[] = {"test", "-a", "-b", "-s", "hello"};
int argc = 5;

char *expected[] = {"temp", "argv", "temp2", "temp3"};

int main(argc) {
    int temp = argc;
    int temp3 TRACK;
    char a = argv[0][0];
    while(strcmp(argv[0], "as")) {
        temp3 = 5; 
    }
    return 0;
}
