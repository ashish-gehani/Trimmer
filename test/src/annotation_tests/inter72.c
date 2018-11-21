#include "annotate.h"
#include <string.h>

/*
 * Annotation test. Check whether argc values are being tracked
 */
char * argv[] = {"test", "-a", "-b", "-s", "hello"};

int main(argc) {
    char *temp = argv[1];
    char *temp2 = argv[0];
    if(temp == temp2)
        argc++;
    return 0;
}
