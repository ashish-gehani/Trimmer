#include "annotate.h"
#include <string.h>

/*
 * Annotation test. Check whether argc values are being tracked
 */
char * argv[] = {"test", "-a", "-b", "-s", "hello"};

int main(argc) {
    int *temp TRACK;
    if(argc) {
        temp+= 1;
    }
    return 0;
}
