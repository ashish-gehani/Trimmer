/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

/* This Test is expected to specialized the func function such that the branch is pruned out */

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
    obj->lti.x[569] = 122;
    obj->lti.y[335] = 112;
    obj->lti.x[534] = 106;
    memcpy(&obj->lts.x[645], "ygx", 3);
    memcpy(&obj->lts.x[131], "afwik", 5);
    obj->lti.x[987] = 121;
    memcpy(&obj->lts.x[253], "xawjt", 5);
    obj->lti.x[649] = 116;
    memcpy(&obj->lts.x[276], "meaj", 4);
    memcpy(&obj->lts.y[225], "oqmop", 5);
}
void branchPruned(struct HighType obj){
    if(obj.lts.y[225] == 111 &&
    obj.lts.y[226] == 113 &&
    obj.lts.y[227] == 109 &&
    obj.lts.y[228] == 111 &&
    obj.lts.y[229] == 112 &&
    obj.lts.x[131] == 97 &&
    obj.lts.x[132] == 102 &&
    obj.lts.x[133] == 119 &&
    obj.lts.x[134] == 105 &&
    obj.lts.x[135] == 107 &&
    obj.lts.x[253] == 120 &&
    obj.lts.x[254] == 97 &&
    obj.lts.x[255] == 119 &&
    obj.lts.x[256] == 106 &&
    obj.lts.x[257] == 116 &&
    obj.lts.x[276] == 109 &&
    obj.lts.x[277] == 101 &&
    obj.lts.x[278] == 97 &&
    obj.lts.x[279] == 106 &&
    obj.lts.x[645] == 121 &&
    obj.lts.x[646] == 103 &&
    obj.lts.x[647] == 120 &&
    obj.lti.y[335] == 112 &&
    obj.lti.x[534] == 106 &&
    obj.lti.x[569] == 122 &&
    obj.lti.x[649] == 116 &&
    obj.lti.x[987] == 121 &&
    !strcmp(&obj.lts.y[225], "oqmop") &&
    !strcmp(&obj.lts.x[645], "ygx") &&
    !strcmp(&obj.lts.x[131], "afwik") &&
    !strcmp(&obj.lts.x[253], "xawjt") &&
    !strcmp(&obj.lts.x[276], "meaj"))
        printf("*** branchTaken");
}

int main() {
	struct HighType ht;
	initialize(&ht);
	branchPruned(ht);
}
