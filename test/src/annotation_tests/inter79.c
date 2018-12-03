#include "annotate.h"
#include <string.h>

/*
 * Annotation test. Check if pointer to non pointer casts
 * are tracked
 */
char *argv[] = {"test", "-a", "-b", "-s", "hello"};
char temp[] = "asdf";

void test(char *argv[]) {
    char *test;
    if(strcmp(argv[2], "-a")&& &test)
        memcpy(test, argv[2], 100);
}
int main() {

    test(argv);
    return 0;
}
