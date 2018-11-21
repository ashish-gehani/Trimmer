#include "annotate.h"
#include <string.h>

/*
 * Annotation test. Check if conditionals dependent on argv work
 */
char * argv[] = {"test", "-a", "-b", "-s", "hello"};
int argc = 5;

char *expected[] = {"temp", "argv", "temp2"};

int main(int argc) {
    char *temp TRACK;
    int temp2 TRACK;
    (unsigned)&temp & (unsigned) &temp2;

    temp = argv[1];
    if(temp)
        temp2 = 1;
    return 0;
}
