#include "annotate.h"
#include <string.h>

/*
 * Annotation test. Check if memcpy, strcpy, strncpy work
 */
char * argv[] = {"test", "-a", "-b", "-s", "hello"};
int argc = 5;

int main(int argc) {
    char temp[4] TRACK;     
    char temp1[4] TRACK;
    char temp2[4] TRACK;
    char temp3[4] TRACK;

    memcpy(temp, argv[0],4);
    strncpy(temp1, argv[0], 4);
    strcpy(temp2, temp1);
    memcpy(temp3, temp2, 4);
 
    return 0;
}
