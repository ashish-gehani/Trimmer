#include "annotate.h"

/*
 * Basic annotation test. Check if temp is added to track set
 */
char * argv[] = {"test", "-a", "-b", "-s", "hello"};
int argc = 5;

char *expected[2] = {"temp", "argv", "tempa"};

int main(int argc) {
    char *temp[1] TRACK;
    char **temp2[1] TRACK;
    temp[0] = argv[argc]; 
    temp2[0] = &argv;
    return 0;
}
