#include "annotate.h"
#include <string.h>

/*
 * Annotation test. Check if pointer to non pointer casts
 * are tracked
 */
char * argv[] = {"test", "-a", "-b", "-s", "hello"};

int main() {

char temp[] = "asdf";
    memcpy(temp, argv[0], 2);
    return 0;
}
