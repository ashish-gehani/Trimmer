/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

#include <stdio.h>
#include <string.h>

/*
 * This loop will not be unrolled as condition depends upon an external function.
 * 
 */

char * argv[] = {"test", "-a", "-b", "-s", "hello"};
int argc = 5;
struct temp {
    int a;
};

void branchNotPruned(struct temp *t ) {
    if(t->a == 116)
        printf("branchPruned");
}

int externa();
int main() {
    struct temp t;
    int i; 
    t.a = argv[0][0];
    printf("%d\n",t.a);
    for(i = 0; i < external(); i++) {
        if(t.a == 116) {
           printf("a = 116");
        } else {
            t.a++;
        }
    }

    branchNotPruned(&t);
    return 0;
}
