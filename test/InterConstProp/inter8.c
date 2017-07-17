
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
 
struct LowTypeInt {
	int x[1000];
	int y[1000];
};
struct LowTypeString {
	char x[1000];
	char y[1000];
};
struct HighType {
	struct LowTypeString lts;
	struct LowTypeInt lti;
};
void initialize(struct HighType* obj) {
    obj->lti.x[569] = 127;
    obj->lti.y[335] = 78;
    obj->lti.x[534] = 48;
    obj->lts.x[645] = 56;
    obj->lts.x[902] = 117;
    obj->lti.x[966] = 3;
    obj->lti.y[316] = 51;
    obj->lti.x[987] = 119;
    obj->lts.x[253] = 126;
    obj->lts.x[879] = 48;
}
void branchPruned(struct HighType obj){
    if(obj.lti.x[569] == 127 &&
    obj.lti.y[335] == 78 &&
    obj.lti.x[534] == 48 &&
    obj.lts.x[645] == 56 &&
    obj.lts.x[902] == 117 &&
    obj.lti.x[966] == 3 &&
    obj.lti.y[316] == 51 &&
    obj.lti.x[987] == 119 &&
    obj.lts.x[253] == 126 &&
    obj.lts.x[879] == 48)
        printf("*** branchTaken");
}

int main() {
	struct HighType ht;
	initialize(&ht);
	branchPruned(ht);
}
