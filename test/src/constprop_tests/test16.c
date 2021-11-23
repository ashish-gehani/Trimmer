/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

/* This Test is expected to specialized the func function such that a branch is pruned out in one case and not pruned in other case due to the calling of external function*/

#include<stdio.h>
#include<string.h>
#include<stdlib.h>
 
struct LowTypeInt {
	int * x;
	int * y;
};
struct LowTypeString {
	char * x;
	char * y;
};
struct HighType {
	struct LowTypeString * lts;
	struct LowTypeInt * lti;
};

extern void externalFunc(struct HighType * ht);

void doMallocs(struct HighType** obj) {
    obj[1] = malloc(sizeof(struct HighType));
    obj[1]->lts = malloc(sizeof(struct LowTypeString));
    obj[1]->lti = malloc(sizeof(struct LowTypeInt));
    obj[1]->lts->x = malloc(1000 * sizeof(char));
    obj[1]->lts->y = malloc(1000 * sizeof(char));
    obj[1]->lti->x = malloc(1000 * sizeof(int));
    obj[1]->lti->y = malloc(1000 * sizeof(int));
    obj[2] = malloc(sizeof(struct HighType));
    obj[2]->lts = malloc(sizeof(struct LowTypeString));
    obj[2]->lti = malloc(sizeof(struct LowTypeInt));
    obj[2]->lts->x = malloc(1000 * sizeof(char));
    obj[2]->lts->y = malloc(1000 * sizeof(char));
    obj[2]->lti->x = malloc(1000 * sizeof(int));
    obj[2]->lti->y = malloc(1000 * sizeof(int));
    obj[3] = malloc(sizeof(struct HighType));
    obj[3]->lts = malloc(sizeof(struct LowTypeString));
    obj[3]->lti = malloc(sizeof(struct LowTypeInt));
    obj[3]->lts->x = malloc(1000 * sizeof(char));
    obj[3]->lts->y = malloc(1000 * sizeof(char));
    obj[3]->lti->x = malloc(1000 * sizeof(int));
    obj[3]->lti->y = malloc(1000 * sizeof(int));
    obj[4] = malloc(sizeof(struct HighType));
    obj[4]->lts = malloc(sizeof(struct LowTypeString));
    obj[4]->lti = malloc(sizeof(struct LowTypeInt));
    obj[4]->lts->x = malloc(1000 * sizeof(char));
    obj[4]->lts->y = malloc(1000 * sizeof(char));
    obj[4]->lti->x = malloc(1000 * sizeof(int));
    obj[4]->lti->y = malloc(1000 * sizeof(int));
    obj[5] = malloc(sizeof(struct HighType));
    obj[5]->lts = malloc(sizeof(struct LowTypeString));
    obj[5]->lti = malloc(sizeof(struct LowTypeInt));
    obj[5]->lts->x = malloc(1000 * sizeof(char));
    obj[5]->lts->y = malloc(1000 * sizeof(char));
    obj[5]->lti->x = malloc(1000 * sizeof(int));
    obj[5]->lti->y = malloc(1000 * sizeof(int));
    obj[6] = malloc(sizeof(struct HighType));
    obj[6]->lts = malloc(sizeof(struct LowTypeString));
    obj[6]->lti = malloc(sizeof(struct LowTypeInt));
    obj[6]->lts->x = malloc(1000 * sizeof(char));
    obj[6]->lts->y = malloc(1000 * sizeof(char));
    obj[6]->lti->x = malloc(1000 * sizeof(int));
    obj[6]->lti->y = malloc(1000 * sizeof(int));
    obj[7] = malloc(sizeof(struct HighType));
    obj[7]->lts = malloc(sizeof(struct LowTypeString));
    obj[7]->lti = malloc(sizeof(struct LowTypeInt));
    obj[7]->lts->x = malloc(1000 * sizeof(char));
    obj[7]->lts->y = malloc(1000 * sizeof(char));
    obj[7]->lti->x = malloc(1000 * sizeof(int));
    obj[7]->lti->y = malloc(1000 * sizeof(int));
    obj[8] = malloc(sizeof(struct HighType));
    obj[8]->lts = malloc(sizeof(struct LowTypeString));
    obj[8]->lti = malloc(sizeof(struct LowTypeInt));
    obj[8]->lts->x = malloc(1000 * sizeof(char));
    obj[8]->lts->y = malloc(1000 * sizeof(char));
    obj[8]->lti->x = malloc(1000 * sizeof(int));
    obj[8]->lti->y = malloc(1000 * sizeof(int));
    obj[10] = malloc(sizeof(struct HighType));
    obj[10]->lts = malloc(sizeof(struct LowTypeString));
    obj[10]->lti = malloc(sizeof(struct LowTypeInt));
    obj[10]->lts->x = malloc(1000 * sizeof(char));
    obj[10]->lts->y = malloc(1000 * sizeof(char));
    obj[10]->lti->x = malloc(1000 * sizeof(int));
    obj[10]->lti->y = malloc(1000 * sizeof(int));
    obj[11] = malloc(sizeof(struct HighType));
    obj[11]->lts = malloc(sizeof(struct LowTypeString));
    obj[11]->lti = malloc(sizeof(struct LowTypeInt));
    obj[11]->lts->x = malloc(1000 * sizeof(char));
    obj[11]->lts->y = malloc(1000 * sizeof(char));
    obj[11]->lti->x = malloc(1000 * sizeof(int));
    obj[11]->lti->y = malloc(1000 * sizeof(int));
    obj[12] = malloc(sizeof(struct HighType));
    obj[12]->lts = malloc(sizeof(struct LowTypeString));
    obj[12]->lti = malloc(sizeof(struct LowTypeInt));
    obj[12]->lts->x = malloc(1000 * sizeof(char));
    obj[12]->lts->y = malloc(1000 * sizeof(char));
    obj[12]->lti->x = malloc(1000 * sizeof(int));
    obj[12]->lti->y = malloc(1000 * sizeof(int));
    obj[13] = malloc(sizeof(struct HighType));
    obj[13]->lts = malloc(sizeof(struct LowTypeString));
    obj[13]->lti = malloc(sizeof(struct LowTypeInt));
    obj[13]->lts->x = malloc(1000 * sizeof(char));
    obj[13]->lts->y = malloc(1000 * sizeof(char));
    obj[13]->lti->x = malloc(1000 * sizeof(int));
    obj[13]->lti->y = malloc(1000 * sizeof(int));
    obj[14] = malloc(sizeof(struct HighType));
    obj[14]->lts = malloc(sizeof(struct LowTypeString));
    obj[14]->lti = malloc(sizeof(struct LowTypeInt));
    obj[14]->lts->x = malloc(1000 * sizeof(char));
    obj[14]->lts->y = malloc(1000 * sizeof(char));
    obj[14]->lti->x = malloc(1000 * sizeof(int));
    obj[14]->lti->y = malloc(1000 * sizeof(int));
    obj[15] = malloc(sizeof(struct HighType));
    obj[15]->lts = malloc(sizeof(struct LowTypeString));
    obj[15]->lti = malloc(sizeof(struct LowTypeInt));
    obj[15]->lts->x = malloc(1000 * sizeof(char));
    obj[15]->lts->y = malloc(1000 * sizeof(char));
    obj[15]->lti->x = malloc(1000 * sizeof(int));
    obj[15]->lti->y = malloc(1000 * sizeof(int));
    obj[16] = malloc(sizeof(struct HighType));
    obj[16]->lts = malloc(sizeof(struct LowTypeString));
    obj[16]->lti = malloc(sizeof(struct LowTypeInt));
    obj[16]->lts->x = malloc(1000 * sizeof(char));
    obj[16]->lts->y = malloc(1000 * sizeof(char));
    obj[16]->lti->x = malloc(1000 * sizeof(int));
    obj[16]->lti->y = malloc(1000 * sizeof(int));
    obj[17] = malloc(sizeof(struct HighType));
    obj[17]->lts = malloc(sizeof(struct LowTypeString));
    obj[17]->lti = malloc(sizeof(struct LowTypeInt));
    obj[17]->lts->x = malloc(1000 * sizeof(char));
    obj[17]->lts->y = malloc(1000 * sizeof(char));
    obj[17]->lti->x = malloc(1000 * sizeof(int));
    obj[17]->lti->y = malloc(1000 * sizeof(int));
    obj[18] = malloc(sizeof(struct HighType));
    obj[18]->lts = malloc(sizeof(struct LowTypeString));
    obj[18]->lti = malloc(sizeof(struct LowTypeInt));
    obj[18]->lts->x = malloc(1000 * sizeof(char));
    obj[18]->lts->y = malloc(1000 * sizeof(char));
    obj[18]->lti->x = malloc(1000 * sizeof(int));
    obj[18]->lti->y = malloc(1000 * sizeof(int));
    obj[19] = malloc(sizeof(struct HighType));
    obj[19]->lts = malloc(sizeof(struct LowTypeString));
    obj[19]->lti = malloc(sizeof(struct LowTypeInt));
    obj[19]->lts->x = malloc(1000 * sizeof(char));
    obj[19]->lts->y = malloc(1000 * sizeof(char));
    obj[19]->lti->x = malloc(1000 * sizeof(int));
    obj[19]->lti->y = malloc(1000 * sizeof(int));
}
void initialize(struct HighType** obj) {
    obj[1]->lti->y[19] = 102;
    obj[1]->lti->x[425] = 104;
    obj[1]->lti->y[139] = 103;
    obj[1]->lti->x[878] = 106;
    obj[1]->lti->x[648] = 116;
    obj[1]->lti->x[637] = 109;
    obj[1]->lti->x[714] = 119;
    obj[1]->lti->y[635] = 109;
    obj[1]->lti->x[449] = 112;
    obj[1]->lti->x[91] = 107;
    obj[1]->lti->y[812] = 110;
    obj[1]->lti->x[136] = 109;
    obj[1]->lti->x[984] = 108;
    obj[1]->lti->y[795] = 104;
    obj[1]->lti->y[602] = 106;
    obj[1]->lti->x[24] = 97;
    obj[1]->lti->y[528] = 119;
    obj[1]->lti->y[222] = 121;
    obj[1]->lti->y[645] = 99;
    obj[1]->lti->x[464] = 121;
    obj[1]->lti->y[74] = 110;
    obj[1]->lti->x[665] = 117;
    obj[1]->lti->x[942] = 106;
    obj[1]->lti->x[562] = 116;
    obj[1]->lti->x[621] = 100;
    obj[1]->lti->y[627] = 118;
    obj[1]->lti->y[201] = 97;
    obj[1]->lti->x[82] = 112;
    obj[1]->lti->x[144] = 104;
    obj[1]->lti->y[787] = 122;
    obj[1]->lti->x[510] = 107;
    obj[1]->lti->x[860] = 108;
    obj[1]->lti->x[876] = 116;
    obj[1]->lti->y[48] = 100;
    obj[1]->lti->y[849] = 97;
    obj[1]->lti->y[586] = 109;
    obj[1]->lti->x[46] = 107;
    obj[1]->lti->y[730] = 121;
    obj[1]->lti->x[483] = 111;
    obj[1]->lti->y[710] = 111;
    obj[1]->lti->x[782] = 102;
    obj[1]->lti->x[323] = 109;
    obj[1]->lti->x[348] = 113;
    obj[1]->lti->y[383] = 97;
    obj[1]->lti->y[525] = 110;
    obj[1]->lti->x[710] = 119;
    obj[1]->lti->y[417] = 121;
    obj[1]->lti->x[756] = 100;
    obj[1]->lti->y[983] = 101;
    obj[1]->lti->y[752] = 115;
    obj[1]->lti->y[685] = 112;
    obj[1]->lti->x[248] = 118;
    obj[1]->lti->x[453] = 102;
    obj[1]->lti->x[222] = 103;
    obj[1]->lti->x[544] = 112;
    obj[1]->lti->y[103] = 119;
    obj[1]->lti->y[354] = 102;
    obj[1]->lti->x[780] = 122;
    obj[1]->lti->x[413] = 115;
    obj[1]->lti->y[651] = 113;
    obj[1]->lti->y[90] = 99;
    obj[1]->lti->y[130] = 99;
    obj[1]->lti->y[312] = 106;
    obj[1]->lti->y[688] = 113;
    obj[1]->lti->x[446] = 107;
    obj[1]->lti->x[367] = 97;
    obj[1]->lti->x[456] = 114;
    obj[1]->lti->y[386] = 103;
    obj[1]->lti->x[789] = 101;
    obj[1]->lti->y[63] = 120;
    obj[1]->lti->y[323] = 113;
    obj[1]->lti->x[589] = 114;
    obj[1]->lti->x[896] = 103;
    obj[1]->lti->y[223] = 119;
    obj[1]->lti->y[711] = 113;
    obj[1]->lti->y[360] = 101;
    obj[1]->lti->x[490] = 116;
    obj[1]->lti->y[109] = 99;
    obj[1]->lti->x[329] = 116;
    obj[1]->lti->x[860] = 108;
    obj[1]->lti->x[318] = 108;
    obj[1]->lti->x[873] = 112;
    obj[1]->lti->y[246] = 106;
    obj[1]->lti->x[379] = 120;
    obj[1]->lti->y[628] = 122;
    obj[1]->lti->x[212] = 104;
    obj[1]->lti->y[86] = 114;
    obj[1]->lti->x[422] = 121;
    obj[1]->lti->x[99] = 119;
    obj[1]->lti->x[472] = 98;
    obj[1]->lti->y[836] = 120;
    obj[1]->lti->y[625] = 122;
    obj[1]->lti->y[834] = 122;
    obj[1]->lti->x[987] = 108;
    obj[1]->lti->x[599] = 116;
    obj[1]->lti->y[128] = 112;
    obj[1]->lti->y[377] = 110;
    obj[1]->lti->y[852] = 101;
    obj[1]->lti->y[182] = 121;
    obj[1]->lti->y[976] = 101;
    obj[2]->lti->x[126] = 122;
    obj[2]->lti->x[452] = 112;
    obj[2]->lti->x[91] = 106;
    obj[2]->lti->x[609] = 105;
    obj[2]->lti->y[63] = 99;
    obj[2]->lti->y[437] = 104;
    obj[2]->lti->y[847] = 116;
    obj[2]->lti->y[330] = 107;
    obj[2]->lti->y[341] = 120;
    obj[2]->lti->x[453] = 113;
    obj[2]->lti->x[323] = 121;
    obj[2]->lti->x[216] = 113;
    obj[2]->lti->x[10] = 106;
    obj[2]->lti->y[147] = 122;
    obj[2]->lti->x[881] = 114;
    obj[2]->lti->x[445] = 119;
    obj[2]->lti->y[375] = 101;
    obj[2]->lti->y[387] = 116;
    obj[2]->lti->y[879] = 111;
    obj[2]->lti->y[6] = 109;
    obj[2]->lti->y[375] = 110;
    obj[2]->lti->x[607] = 115;
    obj[2]->lti->x[986] = 111;
    obj[2]->lti->x[332] = 108;
    obj[2]->lti->y[540] = 121;
    obj[2]->lti->x[214] = 119;
    obj[2]->lti->y[698] = 108;
    obj[2]->lti->y[72] = 100;
    obj[2]->lti->y[249] = 113;
    obj[2]->lti->x[968] = 105;
    obj[2]->lti->x[975] = 116;
    obj[2]->lti->x[495] = 98;
    obj[2]->lti->x[93] = 100;
    obj[2]->lti->y[198] = 108;
    obj[2]->lti->y[337] = 99;
    obj[2]->lti->y[784] = 118;
    obj[2]->lti->x[672] = 104;
    obj[2]->lti->y[927] = 119;
    obj[2]->lti->y[758] = 104;
    obj[2]->lti->x[806] = 115;
    obj[2]->lti->x[378] = 116;
    obj[2]->lti->x[959] = 122;
    obj[2]->lti->y[109] = 108;
    obj[2]->lti->y[739] = 110;
    obj[2]->lti->y[670] = 118;
    obj[2]->lti->x[488] = 108;
    obj[2]->lti->x[939] = 118;
    obj[2]->lti->x[748] = 99;
    obj[2]->lti->x[855] = 116;
    obj[2]->lti->y[910] = 97;
    obj[2]->lti->x[137] = 108;
    obj[2]->lti->x[393] = 108;
    obj[2]->lti->x[897] = 105;
    obj[2]->lti->x[713] = 113;
    obj[2]->lti->y[515] = 100;
    obj[2]->lti->x[807] = 97;
    obj[2]->lti->x[571] = 112;
    obj[2]->lti->y[752] = 110;
    obj[2]->lti->x[133] = 112;
    obj[2]->lti->y[870] = 103;
    obj[2]->lti->y[876] = 108;
    obj[2]->lti->x[38] = 101;
    obj[2]->lti->y[869] = 115;
    obj[2]->lti->x[735] = 115;
    obj[2]->lti->x[771] = 121;
    obj[2]->lti->y[410] = 119;
    obj[2]->lti->y[76] = 109;
    obj[2]->lti->x[42] = 107;
    obj[2]->lti->y[378] = 109;
    obj[2]->lti->y[279] = 109;
    obj[2]->lti->y[683] = 101;
    obj[2]->lti->x[165] = 116;
    obj[2]->lti->x[748] = 107;
    obj[2]->lti->x[960] = 109;
    obj[2]->lti->x[172] = 105;
    obj[2]->lti->x[604] = 113;
    obj[2]->lti->x[392] = 108;
    obj[2]->lti->y[841] = 100;
    obj[2]->lti->y[237] = 110;
    obj[2]->lti->y[805] = 100;
    obj[2]->lti->y[520] = 108;
    obj[2]->lti->y[280] = 99;
    obj[2]->lti->y[945] = 99;
    obj[2]->lti->x[23] = 110;
    obj[2]->lti->x[590] = 108;
    obj[2]->lti->x[550] = 112;
    obj[2]->lti->y[189] = 103;
    obj[2]->lti->y[695] = 100;
    obj[2]->lti->y[843] = 107;
    obj[2]->lti->y[847] = 107;
    obj[2]->lti->x[577] = 106;
    obj[2]->lti->y[212] = 120;
    obj[2]->lti->x[920] = 110;
    obj[2]->lti->y[31] = 119;
    externalFunc(obj[2]);
    obj[2]->lti->x[29] = 104;
    obj[2]->lti->y[577] = 106;
    obj[2]->lti->y[800] = 103;
    obj[2]->lti->x[551] = 100;
    obj[2]->lti->x[130] = 108;
    obj[3]->lti->x[748] = 111;
    obj[3]->lti->x[468] = 111;
    obj[3]->lti->x[598] = 106;
    obj[3]->lti->y[772] = 105;
    obj[3]->lti->x[713] = 119;
    obj[3]->lti->x[275] = 105;
    obj[3]->lti->x[187] = 106;
    obj[3]->lti->y[603] = 121;
    obj[3]->lti->x[469] = 113;
    obj[3]->lti->y[851] = 106;
    obj[3]->lti->x[897] = 102;
    obj[3]->lti->x[610] = 117;
    obj[3]->lti->x[861] = 102;
    obj[3]->lti->y[545] = 98;
    obj[3]->lti->y[880] = 121;
    obj[3]->lti->y[66] = 105;
    obj[3]->lti->x[889] = 116;
    obj[3]->lti->y[74] = 100;
    obj[3]->lti->y[398] = 121;
    obj[3]->lti->x[585] = 118;
    obj[3]->lti->y[910] = 112;
    obj[3]->lti->x[318] = 104;
    obj[3]->lti->y[878] = 117;
    obj[3]->lti->x[349] = 113;
    obj[3]->lti->x[457] = 105;
    obj[3]->lti->x[834] = 122;
    obj[3]->lti->x[411] = 103;
    obj[3]->lti->x[867] = 115;
    obj[3]->lti->y[433] = 121;
    obj[3]->lti->x[283] = 120;
    obj[3]->lti->y[851] = 104;
    obj[3]->lti->x[239] = 109;
    obj[3]->lti->x[797] = 101;
    obj[3]->lti->y[853] = 105;
    obj[3]->lti->y[778] = 104;
    obj[3]->lti->x[419] = 108;
    obj[3]->lti->x[752] = 107;
    obj[3]->lti->y[712] = 99;
    obj[3]->lti->x[132] = 112;
    obj[3]->lti->y[662] = 114;
    obj[3]->lti->y[808] = 102;
    obj[3]->lti->x[29] = 110;
    obj[3]->lti->x[918] = 108;
    obj[3]->lti->y[313] = 97;
    obj[3]->lti->x[119] = 106;
    obj[3]->lti->x[440] = 116;
    obj[3]->lti->x[287] = 99;
    obj[3]->lti->y[220] = 98;
    obj[3]->lti->x[625] = 100;
    obj[3]->lti->x[365] = 102;
    obj[3]->lti->y[374] = 103;
    obj[3]->lti->x[38] = 118;
    obj[3]->lti->y[643] = 97;
    obj[3]->lti->y[259] = 118;
    obj[3]->lti->x[263] = 113;
    obj[3]->lti->y[950] = 113;
    obj[3]->lti->x[633] = 101;
    obj[3]->lti->x[261] = 101;
    obj[3]->lti->x[456] = 102;
    obj[3]->lti->y[327] = 109;
    obj[3]->lti->y[515] = 116;
    obj[3]->lti->x[712] = 121;
    obj[3]->lti->y[750] = 97;
    obj[3]->lti->x[30] = 97;
    obj[3]->lti->y[712] = 116;
    obj[3]->lti->y[153] = 117;
    obj[3]->lti->y[664] = 121;
    obj[3]->lti->y[433] = 102;
    obj[3]->lti->y[895] = 113;
    obj[3]->lti->x[548] = 112;
    obj[3]->lti->y[160] = 113;
    obj[3]->lti->y[928] = 103;
    obj[3]->lti->x[728] = 108;
    obj[3]->lti->y[806] = 108;
    obj[3]->lti->x[28] = 119;
    obj[3]->lti->x[907] = 115;
    obj[3]->lti->y[728] = 107;
    obj[3]->lti->x[110] = 97;
    obj[3]->lti->x[408] = 98;
    obj[3]->lti->x[34] = 105;
    obj[3]->lti->y[899] = 115;
    obj[3]->lti->y[35] = 112;
    obj[3]->lti->x[536] = 107;
    obj[3]->lti->x[756] = 104;
    obj[3]->lti->y[208] = 97;
    obj[3]->lti->y[393] = 109;
    obj[3]->lti->y[401] = 119;
    obj[3]->lti->x[403] = 99;
    obj[3]->lti->y[913] = 113;
    obj[3]->lti->y[290] = 97;
    obj[3]->lti->y[263] = 104;
    obj[3]->lti->y[507] = 105;
    obj[3]->lti->y[45] = 107;
    obj[3]->lti->y[957] = 97;
    obj[3]->lti->x[680] = 97;
    obj[3]->lti->x[2] = 98;
    obj[3]->lti->x[590] = 110;
    obj[3]->lti->x[232] = 117;
    obj[3]->lti->x[645] = 98;
    obj[3]->lti->y[938] = 114;
    obj[4]->lti->x[177] = 104;
    obj[4]->lti->y[648] = 120;
    obj[4]->lti->y[787] = 107;
    obj[4]->lti->y[332] = 111;
    obj[4]->lti->x[321] = 104;
    obj[4]->lti->y[67] = 113;
    obj[4]->lti->x[599] = 106;
    obj[4]->lti->y[63] = 104;
    obj[4]->lti->y[943] = 113;
    obj[4]->lti->y[741] = 122;
    obj[4]->lti->y[763] = 110;
    obj[4]->lti->x[854] = 104;
    obj[4]->lti->y[895] = 98;
    obj[4]->lti->x[468] = 99;
    obj[4]->lti->y[877] = 121;
    obj[4]->lti->y[419] = 98;
    obj[4]->lti->x[332] = 110;
    obj[4]->lti->y[643] = 121;
    obj[4]->lti->y[884] = 107;
    obj[4]->lti->x[709] = 110;
    obj[4]->lti->x[941] = 101;
    obj[4]->lti->x[141] = 114;
    obj[4]->lti->x[63] = 108;
    obj[4]->lti->y[235] = 120;
    obj[4]->lti->x[878] = 120;
    obj[4]->lti->x[868] = 112;
    obj[4]->lti->x[770] = 100;
    obj[4]->lti->x[313] = 110;
    externalFunc(obj[4]);
    obj[4]->lti->y[495] = 113;
    obj[4]->lti->x[536] = 120;
    obj[4]->lti->x[584] = 100;
    obj[4]->lti->x[113] = 102;
    obj[4]->lti->y[604] = 107;
    obj[4]->lti->x[360] = 107;
    obj[4]->lti->x[352] = 113;
    obj[4]->lti->y[172] = 106;
    obj[4]->lti->x[393] = 101;
    obj[4]->lti->x[20] = 110;
    obj[4]->lti->y[72] = 106;
    obj[4]->lti->x[457] = 114;
    obj[4]->lti->x[472] = 113;
    obj[4]->lti->x[347] = 120;
    obj[4]->lti->x[121] = 101;
    obj[4]->lti->y[320] = 109;
    obj[4]->lti->x[913] = 106;
    obj[4]->lti->y[612] = 118;
    obj[4]->lti->x[799] = 109;
    obj[4]->lti->y[497] = 118;
    obj[4]->lti->y[428] = 119;
    obj[4]->lti->y[935] = 106;
    obj[4]->lti->y[600] = 103;
    obj[4]->lti->x[441] = 100;
    obj[4]->lti->x[617] = 110;
    obj[4]->lti->x[862] = 122;
    obj[4]->lti->y[438] = 116;
    obj[4]->lti->y[951] = 104;
    obj[4]->lti->y[822] = 108;
    obj[4]->lti->y[542] = 116;
    obj[4]->lti->y[655] = 105;
    obj[4]->lti->y[529] = 98;
    obj[4]->lti->y[747] = 118;
    obj[4]->lti->y[129] = 107;
    obj[4]->lti->y[267] = 114;
    obj[4]->lti->y[729] = 113;
    obj[4]->lti->y[913] = 110;
    obj[4]->lti->y[933] = 106;
    obj[4]->lti->y[272] = 99;
    obj[4]->lti->y[689] = 102;
    obj[4]->lti->y[551] = 112;
    obj[4]->lti->y[87] = 118;
    obj[4]->lti->y[771] = 105;
    obj[4]->lti->y[38] = 109;
    obj[4]->lti->y[974] = 117;
    obj[4]->lti->x[896] = 100;
    obj[4]->lti->x[301] = 113;
    obj[4]->lti->x[181] = 112;
    obj[4]->lti->x[164] = 121;
    obj[4]->lti->x[371] = 98;
    obj[4]->lti->x[455] = 116;
    obj[4]->lti->x[59] = 112;
    obj[4]->lti->x[398] = 106;
    obj[4]->lti->y[416] = 97;
    obj[4]->lti->x[193] = 116;
    obj[4]->lti->y[106] = 116;
    obj[4]->lti->x[422] = 110;
    obj[4]->lti->y[683] = 113;
    obj[4]->lti->x[141] = 120;
    obj[4]->lti->y[135] = 100;
    obj[4]->lti->y[157] = 97;
    obj[4]->lti->x[836] = 103;
    obj[4]->lti->y[264] = 106;
    obj[4]->lti->y[121] = 118;
    obj[4]->lti->y[236] = 122;
    obj[4]->lti->x[801] = 114;
    obj[4]->lti->x[724] = 100;
    obj[4]->lti->y[188] = 117;
    obj[4]->lti->x[230] = 119;
    obj[4]->lti->y[812] = 105;
    obj[4]->lti->x[300] = 119;
    obj[5]->lti->x[976] = 112;
    obj[5]->lti->y[376] = 102;
    obj[5]->lti->y[106] = 106;
    obj[5]->lti->y[395] = 117;
    obj[5]->lti->y[181] = 108;
    obj[5]->lti->y[588] = 109;
    obj[5]->lti->x[524] = 115;
    obj[5]->lti->x[970] = 98;
    obj[5]->lti->x[624] = 102;
    obj[5]->lti->x[262] = 104;
    obj[5]->lti->x[693] = 114;
    obj[5]->lti->y[695] = 116;
    obj[5]->lti->x[240] = 111;
    obj[5]->lti->y[563] = 97;
    obj[5]->lti->x[684] = 102;
    obj[5]->lti->y[747] = 107;
    obj[5]->lti->x[269] = 117;
    obj[5]->lti->y[793] = 97;
    obj[5]->lti->y[677] = 118;
    obj[5]->lti->x[947] = 109;
    obj[5]->lti->x[663] = 97;
    obj[5]->lti->x[920] = 113;
    obj[5]->lti->x[580] = 120;
    obj[5]->lti->y[318] = 107;
    obj[5]->lti->x[729] = 117;
    obj[5]->lti->x[866] = 101;
    obj[5]->lti->x[96] = 112;
    obj[5]->lti->x[534] = 106;
    obj[5]->lti->x[828] = 114;
    obj[5]->lti->x[404] = 119;
    obj[5]->lti->y[783] = 114;
    obj[5]->lti->y[506] = 115;
    obj[5]->lti->y[847] = 117;
    obj[5]->lti->y[190] = 105;
    obj[5]->lti->y[110] = 102;
    obj[5]->lti->y[218] = 105;
    obj[5]->lti->y[219] = 115;
    obj[5]->lti->x[144] = 108;
    obj[5]->lti->x[163] = 122;
    obj[5]->lti->y[878] = 113;
    obj[5]->lti->y[722] = 120;
    obj[5]->lti->x[843] = 105;
    obj[5]->lti->y[475] = 110;
    obj[5]->lti->x[382] = 122;
    obj[5]->lti->y[229] = 117;
    obj[5]->lti->x[15] = 109;
    obj[5]->lti->y[36] = 121;
    obj[5]->lti->x[979] = 112;
    obj[5]->lti->x[97] = 103;
    obj[5]->lti->y[721] = 120;
    obj[5]->lti->y[542] = 115;
    obj[5]->lti->y[663] = 97;
    obj[5]->lti->y[787] = 118;
    obj[5]->lti->x[369] = 99;
    obj[5]->lti->x[125] = 101;
    obj[5]->lti->x[322] = 108;
    obj[5]->lti->y[531] = 115;
    obj[5]->lti->y[132] = 117;
    obj[5]->lti->y[310] = 106;
    obj[5]->lti->x[333] = 103;
    obj[5]->lti->y[294] = 103;
    obj[5]->lti->x[792] = 97;
    obj[5]->lti->x[854] = 115;
    obj[5]->lti->x[71] = 121;
    obj[5]->lti->x[820] = 106;
    obj[5]->lti->x[649] = 105;
    obj[5]->lti->x[67] = 117;
    obj[5]->lti->x[939] = 102;
    obj[5]->lti->x[614] = 102;
    obj[5]->lti->y[329] = 104;
    obj[5]->lti->x[428] = 120;
    obj[5]->lti->x[880] = 106;
    obj[5]->lti->y[72] = 117;
    obj[5]->lti->x[659] = 109;
    obj[5]->lti->y[694] = 97;
    obj[5]->lti->x[975] = 114;
    obj[5]->lti->y[425] = 112;
    obj[5]->lti->x[127] = 101;
    obj[5]->lti->x[310] = 109;
    obj[5]->lti->y[995] = 111;
    obj[5]->lti->x[785] = 116;
    obj[5]->lti->y[112] = 102;
    obj[5]->lti->x[818] = 110;
    obj[5]->lti->x[351] = 104;
    obj[5]->lti->y[439] = 122;
    obj[5]->lti->x[735] = 122;
    obj[5]->lti->x[960] = 98;
    obj[5]->lti->x[121] = 122;
    obj[5]->lti->y[964] = 100;
    obj[5]->lti->x[18] = 121;
    obj[5]->lti->x[364] = 101;
    obj[5]->lti->x[413] = 106;
    obj[5]->lti->x[153] = 100;
    obj[5]->lti->x[153] = 122;
    obj[5]->lti->y[615] = 121;
    obj[5]->lti->x[503] = 116;
    obj[5]->lti->y[172] = 104;
    obj[5]->lti->x[974] = 115;
    obj[5]->lti->y[406] = 108;
    obj[5]->lti->x[142] = 103;
    obj[6]->lti->y[834] = 119;
    obj[6]->lti->x[986] = 114;
    obj[6]->lti->y[993] = 104;
    obj[6]->lti->y[969] = 98;
    obj[6]->lti->y[639] = 113;
    obj[6]->lti->y[555] = 101;
    obj[6]->lti->y[274] = 113;
    obj[6]->lti->x[239] = 115;
    obj[6]->lti->y[920] = 112;
    obj[6]->lti->y[313] = 109;
    obj[6]->lti->x[192] = 113;
    obj[6]->lti->x[302] = 114;
    obj[6]->lti->y[417] = 118;
    obj[6]->lti->y[260] = 106;
    obj[6]->lti->y[414] = 117;
    obj[6]->lti->x[494] = 107;
    obj[6]->lti->x[81] = 115;
    obj[6]->lti->x[869] = 112;
    obj[6]->lti->y[218] = 121;
    obj[6]->lti->y[669] = 110;
    obj[6]->lti->x[317] = 114;
    obj[6]->lti->y[54] = 111;
    obj[6]->lti->x[843] = 112;
    obj[6]->lti->y[956] = 114;
    obj[6]->lti->y[738] = 122;
    obj[6]->lti->y[433] = 117;
    obj[6]->lti->y[292] = 100;
    obj[6]->lti->x[130] = 101;
    obj[6]->lti->y[650] = 114;
    obj[6]->lti->y[24] = 103;
    obj[6]->lti->x[480] = 106;
    obj[6]->lti->y[799] = 118;
    obj[6]->lti->y[983] = 120;
    obj[6]->lti->x[847] = 107;
    obj[6]->lti->x[33] = 98;
    obj[6]->lti->y[578] = 97;
    obj[6]->lti->x[681] = 122;
    obj[6]->lti->y[54] = 112;
    obj[6]->lti->y[39] = 121;
    obj[6]->lti->x[679] = 111;
    obj[6]->lti->y[356] = 114;
    obj[6]->lti->x[630] = 101;
    obj[6]->lti->x[574] = 117;
    obj[6]->lti->x[599] = 101;
    obj[6]->lti->x[969] = 116;
    obj[6]->lti->y[459] = 109;
    obj[6]->lti->y[135] = 108;
    obj[6]->lti->x[629] = 99;
    obj[6]->lti->x[852] = 102;
    obj[6]->lti->y[612] = 111;
    obj[6]->lti->x[560] = 103;
    obj[6]->lti->y[359] = 107;
    obj[6]->lti->y[958] = 113;
    obj[6]->lti->y[124] = 113;
    obj[6]->lti->y[342] = 118;
    obj[6]->lti->x[74] = 114;
    obj[6]->lti->x[23] = 111;
    obj[6]->lti->x[935] = 113;
    obj[6]->lti->x[703] = 101;
    obj[6]->lti->x[801] = 97;
    obj[6]->lti->x[528] = 109;
    obj[6]->lti->x[114] = 110;
    obj[6]->lti->x[784] = 122;
    obj[6]->lti->x[672] = 102;
    obj[6]->lti->y[136] = 111;
    obj[6]->lti->x[782] = 119;
    obj[6]->lti->y[648] = 105;
    obj[6]->lti->y[761] = 111;
    obj[6]->lti->x[53] = 120;
    obj[6]->lti->y[234] = 103;
    obj[6]->lti->y[430] = 107;
    obj[6]->lti->y[626] = 117;
    obj[6]->lti->x[130] = 119;
    obj[6]->lti->x[494] = 119;
    obj[6]->lti->x[750] = 103;
    obj[6]->lti->y[977] = 121;
    obj[6]->lti->y[837] = 103;
    obj[6]->lti->y[555] = 109;
    obj[6]->lti->y[244] = 100;
    obj[6]->lti->x[101] = 116;
    obj[6]->lti->x[393] = 120;
    obj[6]->lti->x[348] = 109;
    obj[6]->lti->y[98] = 100;
    obj[6]->lti->y[598] = 119;
    obj[6]->lti->x[170] = 105;
    obj[6]->lti->x[308] = 107;
    obj[6]->lti->y[605] = 117;
    obj[6]->lti->y[91] = 103;
    obj[6]->lti->x[456] = 111;
    obj[6]->lti->y[121] = 98;
    obj[6]->lti->x[110] = 110;
    obj[6]->lti->y[866] = 104;
    obj[6]->lti->y[294] = 116;
    obj[6]->lti->y[490] = 109;
    obj[6]->lti->y[94] = 118;
    obj[6]->lti->y[733] = 113;
    obj[6]->lti->x[679] = 98;
    obj[6]->lti->x[807] = 104;
    obj[6]->lti->x[639] = 106;
    obj[6]->lti->x[789] = 120;
    obj[7]->lti->x[961] = 104;
    obj[7]->lti->y[226] = 118;
    obj[7]->lti->y[624] = 104;
    obj[7]->lti->y[474] = 110;
    obj[7]->lti->y[148] = 106;
    obj[7]->lti->x[627] = 101;
    obj[7]->lti->x[879] = 104;
    obj[7]->lti->x[915] = 119;
    obj[7]->lti->x[436] = 110;
    obj[7]->lti->x[884] = 102;
    obj[7]->lti->y[980] = 105;
    obj[7]->lti->x[56] = 110;
    obj[7]->lti->y[972] = 99;
    obj[7]->lti->y[184] = 103;
    obj[7]->lti->x[102] = 111;
    obj[7]->lti->y[50] = 103;
    obj[7]->lti->y[648] = 117;
    obj[7]->lti->y[245] = 113;
    obj[7]->lti->x[140] = 103;
    obj[7]->lti->y[597] = 112;
    obj[7]->lti->x[781] = 97;
    obj[7]->lti->x[629] = 103;
    obj[7]->lti->y[608] = 109;
    obj[7]->lti->y[469] = 104;
    obj[7]->lti->x[522] = 111;
    obj[7]->lti->x[970] = 114;
    obj[7]->lti->x[198] = 122;
    obj[7]->lti->y[532] = 105;
    obj[7]->lti->y[959] = 122;
    obj[7]->lti->y[266] = 118;
    obj[7]->lti->y[501] = 122;
    obj[7]->lti->x[294] = 112;
    obj[7]->lti->y[128] = 116;
    obj[7]->lti->y[555] = 116;
    obj[7]->lti->x[407] = 117;
    obj[7]->lti->x[986] = 102;
    obj[7]->lti->x[553] = 100;
    obj[7]->lti->x[466] = 98;
    obj[7]->lti->x[961] = 106;
    obj[7]->lti->y[890] = 120;
    obj[7]->lti->y[873] = 119;
    obj[7]->lti->y[404] = 107;
    obj[7]->lti->x[794] = 101;
    obj[7]->lti->x[265] = 100;
    obj[7]->lti->x[279] = 99;
    obj[7]->lti->y[423] = 119;
    obj[7]->lti->x[110] = 109;
    obj[7]->lti->x[308] = 116;
    obj[7]->lti->y[389] = 117;
    obj[7]->lti->y[507] = 122;
    obj[7]->lti->x[64] = 99;
    obj[7]->lti->x[904] = 97;
    obj[7]->lti->y[138] = 111;
    obj[7]->lti->y[663] = 101;
    obj[7]->lti->y[514] = 100;
    obj[7]->lti->x[209] = 117;
    obj[7]->lti->x[343] = 115;
    obj[7]->lti->y[289] = 101;
    obj[7]->lti->y[521] = 106;
    obj[7]->lti->x[865] = 108;
    obj[7]->lti->y[743] = 103;
    obj[7]->lti->x[560] = 117;
    obj[7]->lti->y[219] = 99;
    obj[7]->lti->y[945] = 118;
    obj[7]->lti->x[184] = 116;
    obj[7]->lti->y[752] = 120;
    obj[7]->lti->x[463] = 106;
    obj[7]->lti->x[373] = 106;
    obj[7]->lti->y[745] = 110;
    obj[7]->lti->y[374] = 105;
    obj[7]->lti->y[308] = 98;
    obj[7]->lti->x[272] = 108;
    obj[7]->lti->x[688] = 112;
    obj[7]->lti->x[605] = 108;
    obj[7]->lti->x[592] = 111;
    obj[7]->lti->y[810] = 113;
    obj[7]->lti->y[334] = 106;
    obj[7]->lti->x[262] = 119;
    obj[7]->lti->y[18] = 100;
    obj[7]->lti->y[375] = 119;
    obj[7]->lti->x[50] = 121;
    obj[7]->lti->x[927] = 110;
    obj[7]->lti->y[431] = 102;
    obj[7]->lti->x[115] = 120;
    obj[7]->lti->y[856] = 108;
    obj[7]->lti->x[874] = 97;
    obj[7]->lti->x[479] = 105;
    obj[7]->lti->x[954] = 106;
    obj[7]->lti->y[921] = 99;
    obj[7]->lti->x[566] = 99;
    obj[7]->lti->x[256] = 104;
    obj[7]->lti->y[44] = 113;
    obj[7]->lti->y[534] = 98;
    obj[7]->lti->y[572] = 108;
    obj[7]->lti->x[350] = 108;
    obj[7]->lti->x[763] = 111;
    obj[7]->lti->y[33] = 98;
    obj[7]->lti->y[786] = 112;
    obj[7]->lti->y[942] = 97;
    obj[7]->lti->y[747] = 119;
    obj[8]->lti->x[678] = 100;
    obj[8]->lti->x[648] = 116;
    obj[8]->lti->y[608] = 116;
    obj[8]->lti->x[191] = 107;
    obj[8]->lti->x[301] = 122;
    obj[8]->lti->x[136] = 121;
    obj[8]->lti->y[239] = 106;
    obj[8]->lti->x[292] = 110;
    obj[8]->lti->y[898] = 120;
    obj[8]->lti->y[202] = 114;
    obj[8]->lti->x[505] = 101;
    obj[8]->lti->y[699] = 121;
    obj[8]->lti->x[511] = 113;
    obj[8]->lti->y[287] = 121;
    obj[8]->lti->y[810] = 97;
    obj[8]->lti->y[570] = 114;
    obj[8]->lti->y[270] = 105;
    obj[8]->lti->x[43] = 113;
    obj[8]->lti->x[286] = 97;
    obj[8]->lti->y[240] = 122;
    obj[8]->lti->y[397] = 108;
    obj[8]->lti->x[821] = 113;
    obj[8]->lti->y[927] = 97;
    obj[8]->lti->y[428] = 101;
    obj[8]->lti->x[31] = 101;
    obj[8]->lti->x[797] = 110;
    obj[8]->lti->y[741] = 109;
    obj[8]->lti->y[524] = 103;
    obj[8]->lti->x[435] = 101;
    obj[8]->lti->x[299] = 108;
    obj[8]->lti->y[7] = 120;
    obj[8]->lti->x[888] = 98;
    obj[8]->lti->y[332] = 114;
    obj[8]->lti->x[579] = 122;
    obj[8]->lti->x[428] = 116;
    obj[8]->lti->x[771] = 111;
    obj[8]->lti->x[397] = 113;
    obj[8]->lti->y[298] = 122;
    obj[8]->lti->y[170] = 117;
    obj[8]->lti->x[288] = 100;
    obj[8]->lti->y[960] = 117;
    obj[8]->lti->x[39] = 109;
    obj[8]->lti->x[561] = 120;
    obj[8]->lti->y[831] = 98;
    obj[8]->lti->y[576] = 105;
    obj[8]->lti->x[70] = 112;
    obj[8]->lti->y[713] = 97;
    obj[8]->lti->x[671] = 105;
    obj[8]->lti->x[203] = 120;
    obj[8]->lti->x[851] = 111;
    obj[8]->lti->x[563] = 112;
    obj[8]->lti->y[921] = 110;
    obj[8]->lti->x[377] = 97;
    obj[8]->lti->y[341] = 119;
    obj[8]->lti->x[390] = 114;
    obj[8]->lti->y[678] = 112;
    obj[8]->lti->y[624] = 99;
    obj[8]->lti->x[875] = 112;
    obj[8]->lti->y[701] = 106;
    obj[8]->lti->x[783] = 114;
    obj[8]->lti->x[679] = 111;
    obj[8]->lti->x[474] = 109;
    obj[8]->lti->x[181] = 113;
    obj[8]->lti->x[741] = 113;
    obj[8]->lti->x[507] = 97;
    obj[8]->lti->x[260] = 106;
    obj[8]->lti->y[960] = 103;
    obj[8]->lti->x[650] = 111;
    obj[8]->lti->y[320] = 113;
    obj[8]->lti->x[617] = 108;
    obj[8]->lti->x[454] = 116;
    obj[8]->lti->x[538] = 100;
    obj[8]->lti->y[174] = 122;
    obj[8]->lti->y[107] = 118;
    obj[8]->lti->x[588] = 105;
    obj[8]->lti->y[737] = 114;
    obj[8]->lti->x[415] = 97;
    obj[8]->lti->x[667] = 108;
    obj[8]->lti->x[448] = 106;
    obj[8]->lti->x[225] = 110;
    obj[8]->lti->x[92] = 104;
    obj[8]->lti->y[655] = 104;
    obj[8]->lti->y[235] = 106;
    obj[8]->lti->x[568] = 113;
    obj[8]->lti->y[564] = 107;
    obj[8]->lti->x[595] = 117;
    obj[8]->lti->x[268] = 108;
    obj[8]->lti->y[178] = 98;
    obj[8]->lti->x[648] = 107;
    obj[8]->lti->x[256] = 117;
    obj[8]->lti->y[640] = 103;
    obj[8]->lti->x[743] = 100;
    obj[8]->lti->y[719] = 117;
    obj[8]->lti->x[708] = 112;
    obj[8]->lti->x[455] = 119;
    obj[8]->lti->x[710] = 101;
    obj[8]->lti->y[215] = 108;
    obj[8]->lti->x[549] = 121;
    obj[8]->lti->y[321] = 102;
    obj[8]->lti->y[798] = 115;
    obj[10]->lti->y[774] = 118;
    obj[10]->lti->x[669] = 108;
    obj[10]->lti->y[182] = 103;
    obj[10]->lti->y[486] = 121;
    obj[10]->lti->y[145] = 108;
    obj[10]->lti->x[415] = 105;
    obj[10]->lti->x[907] = 97;
    obj[10]->lti->y[581] = 116;
    obj[10]->lti->y[777] = 101;
    obj[10]->lti->y[68] = 98;
    obj[10]->lti->x[282] = 122;
    obj[10]->lti->x[86] = 120;
    obj[10]->lti->y[193] = 105;
    obj[10]->lti->y[193] = 111;
    obj[10]->lti->x[338] = 98;
    obj[10]->lti->x[557] = 98;
    obj[10]->lti->x[436] = 122;
    obj[10]->lti->y[515] = 103;
    obj[10]->lti->y[651] = 103;
    obj[10]->lti->x[683] = 111;
    obj[10]->lti->y[25] = 117;
    obj[10]->lti->x[4] = 100;
    obj[10]->lti->x[920] = 101;
    obj[10]->lti->x[743] = 101;
    obj[10]->lti->x[34] = 119;
    obj[10]->lti->x[336] = 106;
    obj[10]->lti->y[823] = 121;
    obj[10]->lti->y[168] = 106;
    obj[10]->lti->y[325] = 112;
    obj[10]->lti->y[737] = 121;
    obj[10]->lti->x[781] = 99;
    obj[10]->lti->y[943] = 107;
    obj[10]->lti->y[974] = 103;
    obj[10]->lti->x[752] = 116;
    obj[10]->lti->x[793] = 117;
    obj[10]->lti->y[224] = 122;
    obj[10]->lti->y[727] = 100;
    obj[10]->lti->x[79] = 115;
    obj[10]->lti->x[442] = 107;
    obj[10]->lti->y[441] = 102;
    obj[10]->lti->y[34] = 100;
    obj[10]->lti->y[131] = 120;
    obj[10]->lti->x[35] = 110;
    obj[10]->lti->y[49] = 121;
    obj[10]->lti->y[791] = 106;
    obj[10]->lti->y[897] = 118;
    obj[10]->lti->x[448] = 103;
    obj[10]->lti->y[999] = 121;
    obj[10]->lti->x[578] = 121;
    obj[10]->lti->x[103] = 100;
    obj[10]->lti->y[485] = 110;
    obj[10]->lti->y[431] = 99;
    obj[10]->lti->x[198] = 97;
    obj[10]->lti->x[524] = 106;
    obj[10]->lti->y[295] = 109;
    obj[10]->lti->x[935] = 119;
    obj[10]->lti->x[12] = 112;
    obj[10]->lti->x[999] = 122;
    obj[10]->lti->y[925] = 105;
    obj[10]->lti->x[167] = 100;
    obj[10]->lti->y[590] = 118;
    obj[10]->lti->x[928] = 106;
    obj[10]->lti->x[123] = 105;
    obj[10]->lti->x[112] = 109;
    obj[10]->lti->y[564] = 108;
    obj[10]->lti->x[933] = 111;
    obj[10]->lti->x[468] = 122;
    obj[10]->lti->y[305] = 100;
    obj[10]->lti->y[869] = 110;
    obj[10]->lti->y[452] = 120;
    obj[10]->lti->x[79] = 116;
    obj[10]->lti->y[264] = 121;
    obj[10]->lti->x[614] = 103;
    obj[10]->lti->y[650] = 122;
    obj[10]->lti->y[193] = 97;
    obj[10]->lti->y[940] = 116;
    obj[10]->lti->x[487] = 100;
    obj[10]->lti->y[560] = 102;
    obj[10]->lti->y[484] = 111;
    obj[10]->lti->y[175] = 102;
    obj[10]->lti->x[885] = 103;
    obj[10]->lti->x[522] = 100;
    obj[10]->lti->y[974] = 105;
    obj[10]->lti->x[785] = 99;
    obj[10]->lti->x[341] = 116;
    obj[10]->lti->x[434] = 116;
    obj[10]->lti->y[684] = 117;
    obj[10]->lti->y[820] = 106;
    obj[10]->lti->y[226] = 100;
    obj[10]->lti->x[210] = 120;
    obj[10]->lti->y[43] = 104;
    obj[10]->lti->y[689] = 109;
    obj[10]->lti->y[429] = 114;
    obj[10]->lti->x[800] = 105;
    obj[10]->lti->y[908] = 99;
    obj[10]->lti->y[844] = 117;
    obj[10]->lti->y[120] = 118;
    obj[10]->lti->y[207] = 115;
    obj[10]->lti->x[483] = 117;
    obj[10]->lti->y[628] = 119;
    obj[11]->lti->x[550] = 120;
    obj[11]->lti->x[755] = 112;
    obj[11]->lti->y[289] = 107;
    obj[11]->lti->x[113] = 113;
    obj[11]->lti->x[505] = 107;
    obj[11]->lti->x[546] = 99;
    obj[11]->lti->y[523] = 115;
    obj[11]->lti->x[864] = 110;
    obj[11]->lti->x[836] = 106;
    obj[11]->lti->x[72] = 99;
    obj[11]->lti->y[418] = 102;
    obj[11]->lti->x[88] = 100;
    obj[11]->lti->y[532] = 97;
    obj[11]->lti->x[247] = 106;
    obj[11]->lti->x[656] = 118;
    obj[11]->lti->x[261] = 104;
    obj[11]->lti->y[546] = 117;
    obj[11]->lti->x[605] = 107;
    obj[11]->lti->x[138] = 121;
    obj[11]->lti->x[444] = 108;
    obj[11]->lti->y[126] = 112;
    obj[11]->lti->x[491] = 120;
    obj[11]->lti->x[394] = 122;
    obj[11]->lti->y[872] = 118;
    obj[11]->lti->y[27] = 107;
    obj[11]->lti->y[380] = 99;
    obj[11]->lti->y[902] = 105;
    obj[11]->lti->y[93] = 112;
    obj[11]->lti->y[858] = 100;
    obj[11]->lti->y[556] = 98;
    obj[11]->lti->x[715] = 97;
    obj[11]->lti->y[406] = 98;
    obj[11]->lti->x[166] = 108;
    obj[11]->lti->y[814] = 107;
    obj[11]->lti->y[670] = 97;
    obj[11]->lti->y[628] = 115;
    obj[11]->lti->y[184] = 114;
    obj[11]->lti->x[736] = 121;
    obj[11]->lti->y[773] = 108;
    obj[11]->lti->x[298] = 115;
    obj[11]->lti->y[695] = 115;
    obj[11]->lti->y[45] = 121;
    obj[11]->lti->y[93] = 108;
    obj[11]->lti->x[795] = 97;
    obj[11]->lti->x[552] = 111;
    obj[11]->lti->x[850] = 101;
    obj[11]->lti->x[45] = 119;
    obj[11]->lti->y[5] = 108;
    obj[11]->lti->y[186] = 119;
    obj[11]->lti->y[156] = 108;
    obj[11]->lti->x[50] = 105;
    obj[11]->lti->y[200] = 104;
    obj[11]->lti->y[791] = 115;
    obj[11]->lti->y[87] = 119;
    obj[11]->lti->y[485] = 108;
    obj[11]->lti->x[682] = 106;
    obj[11]->lti->x[103] = 103;
    obj[11]->lti->y[645] = 114;
    obj[11]->lti->y[931] = 112;
    obj[11]->lti->y[343] = 118;
    obj[11]->lti->x[732] = 109;
    obj[11]->lti->y[380] = 113;
    obj[11]->lti->x[312] = 101;
    obj[11]->lti->x[668] = 121;
    obj[11]->lti->x[162] = 119;
    obj[11]->lti->x[872] = 114;
    obj[11]->lti->x[121] = 119;
    obj[11]->lti->y[509] = 112;
    obj[11]->lti->y[49] = 111;
    obj[11]->lti->x[287] = 115;
    obj[11]->lti->y[197] = 116;
    obj[11]->lti->x[70] = 102;
    obj[11]->lti->x[585] = 117;
    obj[11]->lti->y[263] = 116;
    obj[11]->lti->y[245] = 114;
    obj[11]->lti->y[950] = 113;
    obj[11]->lti->x[762] = 104;
    obj[11]->lti->x[755] = 111;
    obj[11]->lti->y[915] = 119;
    obj[11]->lti->x[63] = 105;
    obj[11]->lti->x[278] = 115;
    obj[11]->lti->x[703] = 115;
    obj[11]->lti->y[44] = 117;
    obj[11]->lti->x[992] = 112;
    obj[11]->lti->x[272] = 101;
    obj[11]->lti->y[424] = 100;
    obj[11]->lti->y[945] = 111;
    obj[11]->lti->x[91] = 122;
    obj[11]->lti->y[919] = 104;
    obj[11]->lti->x[249] = 101;
    obj[11]->lti->y[843] = 112;
    obj[11]->lti->y[942] = 102;
    obj[11]->lti->x[305] = 103;
    obj[11]->lti->x[509] = 117;
    obj[11]->lti->y[906] = 108;
    obj[11]->lti->x[890] = 122;
    obj[11]->lti->y[999] = 107;
    obj[11]->lti->x[748] = 97;
    obj[11]->lti->y[220] = 116;
    obj[11]->lti->y[939] = 110;
    obj[12]->lti->x[670] = 99;
    obj[12]->lti->y[33] = 103;
    obj[12]->lti->x[64] = 118;
    obj[12]->lti->y[671] = 100;
    obj[12]->lti->x[72] = 115;
    obj[12]->lti->y[94] = 105;
    obj[12]->lti->y[692] = 105;
    obj[12]->lti->y[872] = 109;
    obj[12]->lti->x[975] = 114;
    obj[12]->lti->y[210] = 118;
    obj[12]->lti->x[713] = 102;
    obj[12]->lti->x[68] = 105;
    obj[12]->lti->y[19] = 113;
    obj[12]->lti->x[487] = 119;
    obj[12]->lti->y[960] = 119;
    obj[12]->lti->x[570] = 119;
    obj[12]->lti->x[207] = 111;
    obj[12]->lti->y[369] = 120;
    obj[12]->lti->y[60] = 99;
    obj[12]->lti->y[269] = 103;
    obj[12]->lti->y[154] = 115;
    obj[12]->lti->y[628] = 108;
    obj[12]->lti->x[801] = 112;
    obj[12]->lti->x[821] = 122;
    obj[12]->lti->x[244] = 109;
    obj[12]->lti->y[39] = 117;
    obj[12]->lti->x[945] = 115;
    obj[12]->lti->y[867] = 106;
    obj[12]->lti->x[534] = 97;
    obj[12]->lti->y[432] = 99;
    obj[12]->lti->y[713] = 99;
    obj[12]->lti->x[435] = 122;
    obj[12]->lti->x[566] = 103;
    obj[12]->lti->y[935] = 107;
    obj[12]->lti->y[99] = 122;
    obj[12]->lti->x[428] = 116;
    obj[12]->lti->x[232] = 120;
    obj[12]->lti->y[290] = 105;
    obj[12]->lti->y[985] = 102;
    obj[12]->lti->x[522] = 112;
    obj[12]->lti->y[716] = 105;
    obj[12]->lti->y[886] = 113;
    obj[12]->lti->y[435] = 107;
    obj[12]->lti->x[81] = 119;
    obj[12]->lti->y[648] = 99;
    obj[12]->lti->y[398] = 106;
    obj[12]->lti->y[108] = 100;
    obj[12]->lti->y[792] = 108;
    obj[12]->lti->y[341] = 100;
    obj[12]->lti->y[742] = 97;
    obj[12]->lti->x[92] = 103;
    obj[12]->lti->y[388] = 99;
    obj[12]->lti->y[193] = 100;
    obj[12]->lti->y[454] = 113;
    obj[12]->lti->x[971] = 111;
    obj[12]->lti->y[438] = 106;
    obj[12]->lti->x[403] = 106;
    obj[12]->lti->y[513] = 122;
    obj[12]->lti->y[610] = 115;
    obj[12]->lti->x[939] = 117;
    obj[12]->lti->y[564] = 101;
    obj[12]->lti->y[822] = 110;
    obj[12]->lti->x[853] = 99;
    obj[12]->lti->x[358] = 97;
    obj[12]->lti->x[923] = 100;
    obj[12]->lti->y[604] = 104;
    obj[12]->lti->x[992] = 110;
    obj[12]->lti->y[547] = 108;
    obj[12]->lti->x[205] = 104;
    obj[12]->lti->y[521] = 105;
    obj[12]->lti->x[698] = 103;
    obj[12]->lti->y[399] = 118;
    obj[12]->lti->y[900] = 110;
    obj[12]->lti->y[163] = 119;
    obj[12]->lti->y[538] = 100;
    obj[12]->lti->y[773] = 108;
    obj[12]->lti->x[465] = 117;
    obj[12]->lti->x[731] = 115;
    obj[12]->lti->x[380] = 101;
    obj[12]->lti->y[110] = 113;
    obj[12]->lti->x[423] = 102;
    obj[12]->lti->y[246] = 113;
    obj[12]->lti->y[512] = 102;
    obj[12]->lti->x[533] = 97;
    obj[12]->lti->y[581] = 112;
    obj[12]->lti->y[75] = 103;
    obj[12]->lti->y[772] = 114;
    obj[12]->lti->y[179] = 117;
    obj[12]->lti->y[721] = 106;
    obj[12]->lti->y[473] = 106;
    obj[12]->lti->x[770] = 111;
    obj[12]->lti->y[881] = 104;
    obj[12]->lti->x[345] = 109;
    obj[12]->lti->x[206] = 100;
    obj[12]->lti->x[972] = 101;
    obj[12]->lti->x[91] = 104;
    obj[12]->lti->x[544] = 119;
    obj[12]->lti->y[944] = 97;
    obj[12]->lti->x[280] = 110;
    obj[12]->lti->y[289] = 112;
    obj[13]->lti->y[829] = 108;
    obj[13]->lti->x[307] = 102;
    obj[13]->lti->x[483] = 113;
    obj[13]->lti->y[359] = 107;
    obj[13]->lti->x[159] = 99;
    obj[13]->lti->y[430] = 117;
    obj[13]->lti->x[480] = 97;
    obj[13]->lti->x[207] = 102;
    obj[13]->lti->y[452] = 119;
    obj[13]->lti->x[974] = 104;
    obj[13]->lti->y[108] = 102;
    obj[13]->lti->x[605] = 112;
    obj[13]->lti->x[692] = 111;
    obj[13]->lti->x[394] = 103;
    obj[13]->lti->x[721] = 111;
    obj[13]->lti->x[853] = 116;
    obj[13]->lti->y[87] = 97;
    obj[13]->lti->y[247] = 99;
    obj[13]->lti->y[38] = 113;
    obj[13]->lti->x[182] = 117;
    obj[13]->lti->y[873] = 122;
    obj[13]->lti->y[510] = 106;
    obj[13]->lti->y[803] = 112;
    obj[13]->lti->x[742] = 115;
    obj[13]->lti->x[421] = 99;
    obj[13]->lti->x[927] = 98;
    obj[13]->lti->y[76] = 118;
    obj[13]->lti->x[363] = 108;
    obj[13]->lti->x[766] = 99;
    obj[13]->lti->x[456] = 110;
    obj[13]->lti->x[46] = 105;
    obj[13]->lti->x[766] = 119;
    obj[13]->lti->y[629] = 111;
    obj[13]->lti->y[803] = 111;
    obj[13]->lti->y[388] = 111;
    obj[13]->lti->y[761] = 97;
    obj[13]->lti->y[175] = 104;
    obj[13]->lti->y[631] = 118;
    obj[13]->lti->x[827] = 101;
    obj[13]->lti->y[703] = 116;
    obj[13]->lti->x[2] = 101;
    obj[13]->lti->y[418] = 102;
    obj[13]->lti->x[744] = 102;
    obj[13]->lti->x[714] = 111;
    obj[13]->lti->x[758] = 99;
    obj[13]->lti->x[551] = 112;
    obj[13]->lti->x[84] = 107;
    obj[13]->lti->x[872] = 105;
    obj[13]->lti->x[599] = 103;
    obj[13]->lti->x[601] = 99;
    obj[13]->lti->x[889] = 104;
    obj[13]->lti->y[844] = 121;
    obj[13]->lti->y[931] = 97;
    obj[13]->lti->y[659] = 110;
    obj[13]->lti->x[390] = 106;
    obj[13]->lti->y[604] = 98;
    obj[13]->lti->x[133] = 97;
    obj[13]->lti->y[142] = 112;
    obj[13]->lti->x[48] = 113;
    obj[13]->lti->y[466] = 111;
    obj[13]->lti->y[454] = 107;
    obj[13]->lti->x[960] = 97;
    obj[13]->lti->x[697] = 111;
    obj[13]->lti->x[446] = 117;
    obj[13]->lti->y[259] = 121;
    obj[13]->lti->y[767] = 108;
    obj[13]->lti->x[68] = 112;
    obj[13]->lti->y[261] = 97;
    obj[13]->lti->x[792] = 117;
    obj[13]->lti->y[708] = 116;
    obj[13]->lti->y[842] = 116;
    obj[13]->lti->x[88] = 121;
    obj[13]->lti->y[308] = 108;
    obj[13]->lti->y[463] = 97;
    obj[13]->lti->x[895] = 119;
    obj[13]->lti->y[643] = 113;
    obj[13]->lti->x[235] = 107;
    obj[13]->lti->y[210] = 110;
    obj[13]->lti->y[393] = 119;
    obj[13]->lti->x[860] = 108;
    obj[13]->lti->x[36] = 102;
    obj[13]->lti->x[341] = 120;
    obj[13]->lti->y[534] = 119;
    obj[13]->lti->x[100] = 119;
    obj[13]->lti->x[591] = 100;
    obj[13]->lti->x[899] = 114;
    obj[13]->lti->y[216] = 112;
    obj[13]->lti->x[619] = 115;
    obj[13]->lti->x[311] = 120;
    obj[13]->lti->y[998] = 102;
    obj[13]->lti->x[541] = 120;
    obj[13]->lti->x[669] = 97;
    obj[13]->lti->x[894] = 106;
    obj[13]->lti->x[115] = 106;
    obj[13]->lti->x[283] = 119;
    obj[13]->lti->x[471] = 99;
    obj[13]->lti->x[310] = 119;
    obj[13]->lti->y[729] = 110;
    obj[13]->lti->y[643] = 100;
    obj[13]->lti->x[718] = 102;
    obj[14]->lti->y[534] = 108;
    obj[14]->lti->x[221] = 116;
    obj[14]->lti->y[498] = 109;
    obj[14]->lti->y[95] = 119;
    obj[14]->lti->x[189] = 116;
    obj[14]->lti->x[780] = 105;
    obj[14]->lti->y[865] = 120;
    obj[14]->lti->x[259] = 101;
    obj[14]->lti->x[869] = 104;
    obj[14]->lti->x[824] = 111;
    obj[14]->lti->y[253] = 102;
    obj[14]->lti->x[708] = 99;
    obj[14]->lti->x[10] = 115;
    obj[14]->lti->y[212] = 119;
    obj[14]->lti->y[675] = 105;
    obj[14]->lti->y[659] = 116;
    obj[14]->lti->y[810] = 99;
    obj[14]->lti->x[944] = 97;
    obj[14]->lti->x[6] = 104;
    obj[14]->lti->x[927] = 120;
    obj[14]->lti->y[862] = 112;
    obj[14]->lti->y[959] = 117;
    obj[14]->lti->x[447] = 116;
    obj[14]->lti->x[803] = 102;
    obj[14]->lti->y[56] = 98;
    obj[14]->lti->x[198] = 113;
    obj[14]->lti->x[462] = 97;
    obj[14]->lti->y[473] = 114;
    obj[14]->lti->y[32] = 122;
    obj[14]->lti->x[935] = 111;
    obj[14]->lti->y[878] = 111;
    obj[14]->lti->y[731] = 111;
    obj[14]->lti->y[547] = 106;
    obj[14]->lti->x[934] = 100;
    obj[14]->lti->x[483] = 112;
    obj[14]->lti->x[772] = 109;
    obj[14]->lti->y[731] = 104;
    obj[14]->lti->y[657] = 121;
    obj[14]->lti->y[587] = 122;
    obj[14]->lti->x[667] = 109;
    obj[14]->lti->y[44] = 98;
    obj[14]->lti->y[283] = 112;
    obj[14]->lti->y[939] = 119;
    obj[14]->lti->x[636] = 111;
    obj[14]->lti->y[825] = 99;
    obj[14]->lti->x[419] = 104;
    obj[14]->lti->y[20] = 106;
    obj[14]->lti->x[345] = 117;
    obj[14]->lti->y[251] = 105;
    obj[14]->lti->y[750] = 98;
    obj[14]->lti->y[533] = 103;
    obj[14]->lti->y[737] = 99;
    obj[14]->lti->y[956] = 97;
    obj[14]->lti->y[795] = 101;
    obj[14]->lti->y[707] = 122;
    obj[14]->lti->y[874] = 103;
    obj[14]->lti->x[426] = 100;
    obj[14]->lti->y[586] = 102;
    obj[14]->lti->x[110] = 113;
    obj[14]->lti->y[305] = 98;
    obj[14]->lti->y[672] = 114;
    obj[14]->lti->x[497] = 120;
    obj[14]->lti->y[782] = 115;
    obj[14]->lti->x[305] = 97;
    obj[14]->lti->y[271] = 97;
    obj[14]->lti->x[231] = 117;
    obj[14]->lti->y[409] = 111;
    obj[14]->lti->x[229] = 102;
    obj[14]->lti->y[805] = 115;
    obj[14]->lti->y[100] = 105;
    obj[14]->lti->y[240] = 111;
    obj[14]->lti->y[636] = 101;
    obj[14]->lti->y[186] = 114;
    obj[14]->lti->x[355] = 122;
    obj[14]->lti->y[649] = 109;
    obj[14]->lti->x[385] = 113;
    obj[14]->lti->y[170] = 117;
    obj[14]->lti->y[443] = 98;
    obj[14]->lti->x[337] = 98;
    obj[14]->lti->x[722] = 97;
    obj[14]->lti->x[775] = 101;
    obj[14]->lti->y[209] = 108;
    obj[14]->lti->y[207] = 114;
    obj[14]->lti->y[97] = 121;
    obj[14]->lti->y[178] = 107;
    obj[14]->lti->x[639] = 101;
    obj[14]->lti->x[905] = 115;
    obj[14]->lti->x[36] = 108;
    obj[14]->lti->x[411] = 106;
    obj[14]->lti->x[133] = 120;
    obj[14]->lti->x[880] = 113;
    obj[14]->lti->y[577] = 117;
    obj[14]->lti->x[375] = 113;
    obj[14]->lti->y[558] = 112;
    obj[14]->lti->x[802] = 112;
    obj[14]->lti->x[554] = 115;
    obj[14]->lti->x[421] = 101;
    obj[14]->lti->x[560] = 111;
    obj[14]->lti->y[161] = 97;
    obj[14]->lti->y[534] = 108;
    obj[15]->lti->x[885] = 119;
    obj[15]->lti->x[661] = 106;
    obj[15]->lti->y[707] = 102;
    obj[15]->lti->y[870] = 105;
    obj[15]->lti->y[506] = 115;
    obj[15]->lti->y[373] = 105;
    obj[15]->lti->y[614] = 97;
    obj[15]->lti->y[395] = 116;
    obj[15]->lti->y[946] = 105;
    obj[15]->lti->x[777] = 106;
    obj[15]->lti->y[140] = 119;
    obj[15]->lti->x[369] = 117;
    obj[15]->lti->y[18] = 121;
    obj[15]->lti->y[935] = 106;
    obj[15]->lti->x[773] = 115;
    obj[15]->lti->x[432] = 121;
    obj[15]->lti->x[714] = 107;
    obj[15]->lti->x[118] = 113;
    obj[15]->lti->y[290] = 98;
    obj[15]->lti->y[312] = 101;
    obj[15]->lti->x[129] = 111;
    obj[15]->lti->y[257] = 122;
    obj[15]->lti->y[217] = 111;
    obj[15]->lti->x[372] = 111;
    obj[15]->lti->y[420] = 117;
    obj[15]->lti->y[842] = 116;
    obj[15]->lti->y[586] = 110;
    obj[15]->lti->x[978] = 120;
    obj[15]->lti->y[740] = 109;
    obj[15]->lti->x[516] = 106;
    obj[15]->lti->y[522] = 112;
    obj[15]->lti->x[555] = 104;
    obj[15]->lti->x[725] = 97;
    obj[15]->lti->x[927] = 102;
    obj[15]->lti->y[838] = 121;
    obj[15]->lti->y[400] = 112;
    obj[15]->lti->x[704] = 112;
    obj[15]->lti->y[828] = 109;
    obj[15]->lti->x[179] = 116;
    obj[15]->lti->x[512] = 97;
    obj[15]->lti->y[312] = 114;
    obj[15]->lti->x[749] = 101;
    obj[15]->lti->y[278] = 118;
    obj[15]->lti->y[383] = 117;
    obj[15]->lti->x[836] = 100;
    obj[15]->lti->x[421] = 106;
    obj[15]->lti->x[559] = 121;
    obj[15]->lti->x[437] = 111;
    obj[15]->lti->y[755] = 98;
    obj[15]->lti->y[435] = 121;
    obj[15]->lti->y[540] = 119;
    obj[15]->lti->x[705] = 122;
    obj[15]->lti->y[43] = 110;
    obj[15]->lti->y[224] = 98;
    obj[15]->lti->x[907] = 100;
    obj[15]->lti->y[586] = 110;
    obj[15]->lti->y[747] = 109;
    obj[15]->lti->x[324] = 112;
    obj[15]->lti->y[31] = 114;
    obj[15]->lti->y[826] = 117;
    obj[15]->lti->x[236] = 117;
    obj[15]->lti->x[338] = 103;
    externalFunc(obj[15]);
    obj[15]->lti->x[477] = 113;
    obj[15]->lti->y[347] = 121;
    obj[15]->lti->y[572] = 100;
    obj[15]->lti->y[241] = 113;
    obj[15]->lti->y[823] = 100;
    obj[15]->lti->x[691] = 97;
    obj[15]->lti->x[302] = 121;
    obj[15]->lti->y[318] = 106;
    obj[15]->lti->x[765] = 116;
    obj[15]->lti->y[727] = 112;
    obj[15]->lti->x[356] = 113;
    obj[15]->lti->y[213] = 108;
    obj[15]->lti->x[607] = 105;
    obj[15]->lti->x[665] = 109;
    obj[15]->lti->y[543] = 110;
    obj[15]->lti->x[100] = 106;
    obj[15]->lti->x[129] = 117;
    obj[15]->lti->x[98] = 113;
    obj[15]->lti->y[764] = 122;
    obj[15]->lti->x[46] = 105;
    obj[15]->lti->y[527] = 111;
    obj[15]->lti->x[386] = 105;
    obj[15]->lti->x[379] = 100;
    obj[15]->lti->x[247] = 108;
    obj[15]->lti->y[281] = 108;
    obj[15]->lti->x[173] = 116;
    obj[15]->lti->x[945] = 119;
    obj[15]->lti->y[639] = 115;
    obj[15]->lti->y[247] = 98;
    obj[15]->lti->y[665] = 114;
    obj[15]->lti->y[435] = 118;
    obj[15]->lti->y[674] = 97;
    obj[15]->lti->y[414] = 115;
    obj[15]->lti->x[144] = 116;
    obj[15]->lti->y[660] = 121;
    obj[15]->lti->y[321] = 115;
    obj[15]->lti->y[877] = 112;
    obj[16]->lti->x[59] = 106;
    obj[16]->lti->y[105] = 104;
    obj[16]->lti->x[48] = 104;
    obj[16]->lti->x[643] = 107;
    obj[16]->lti->x[384] = 120;
    obj[16]->lti->x[22] = 122;
    obj[16]->lti->y[432] = 104;
    obj[16]->lti->y[19] = 100;
    obj[16]->lti->y[394] = 102;
    obj[16]->lti->x[852] = 100;
    obj[16]->lti->y[456] = 98;
    obj[16]->lti->x[624] = 121;
    obj[16]->lti->y[967] = 122;
    obj[16]->lti->x[496] = 101;
    obj[16]->lti->x[174] = 100;
    obj[16]->lti->x[657] = 119;
    obj[16]->lti->x[520] = 102;
    obj[16]->lti->y[673] = 111;
    obj[16]->lti->x[920] = 97;
    obj[16]->lti->y[936] = 107;
    obj[16]->lti->y[419] = 111;
    obj[16]->lti->x[249] = 119;
    obj[16]->lti->x[818] = 115;
    obj[16]->lti->x[158] = 106;
    obj[16]->lti->y[8] = 118;
    obj[16]->lti->x[170] = 120;
    obj[16]->lti->x[58] = 111;
    obj[16]->lti->x[444] = 113;
    obj[16]->lti->y[127] = 115;
    obj[16]->lti->y[492] = 100;
    obj[16]->lti->y[272] = 109;
    obj[16]->lti->x[334] = 104;
    obj[16]->lti->x[57] = 100;
    obj[16]->lti->x[740] = 117;
    obj[16]->lti->y[823] = 116;
    obj[16]->lti->x[797] = 109;
    obj[16]->lti->y[640] = 107;
    obj[16]->lti->x[371] = 122;
    obj[16]->lti->y[447] = 102;
    obj[16]->lti->y[253] = 120;
    obj[16]->lti->x[713] = 109;
    obj[16]->lti->y[594] = 115;
    obj[16]->lti->y[632] = 105;
    obj[16]->lti->x[278] = 106;
    obj[16]->lti->y[832] = 97;
    obj[16]->lti->y[765] = 121;
    obj[16]->lti->x[408] = 102;
    obj[16]->lti->y[590] = 115;
    obj[16]->lti->y[653] = 98;
    obj[16]->lti->y[931] = 113;
    obj[16]->lti->x[850] = 104;
    obj[16]->lti->y[541] = 99;
    obj[16]->lti->x[796] = 102;
    obj[16]->lti->y[835] = 97;
    obj[16]->lti->x[615] = 106;
    obj[16]->lti->y[264] = 118;
    obj[16]->lti->y[425] = 100;
    obj[16]->lti->x[430] = 109;
    obj[16]->lti->x[523] = 107;
    obj[16]->lti->y[285] = 99;
    obj[16]->lti->x[806] = 122;
    obj[16]->lti->y[798] = 111;
    obj[16]->lti->y[456] = 105;
    obj[16]->lti->x[349] = 102;
    obj[16]->lti->y[491] = 116;
    obj[16]->lti->y[506] = 122;
    obj[16]->lti->y[126] = 104;
    obj[16]->lti->y[412] = 97;
    obj[16]->lti->x[546] = 120;
    obj[16]->lti->y[19] = 100;
    obj[16]->lti->y[458] = 102;
    obj[16]->lti->y[262] = 120;
    obj[16]->lti->x[843] = 117;
    obj[16]->lti->y[91] = 114;
    obj[16]->lti->x[413] = 109;
    obj[16]->lti->y[587] = 113;
    obj[16]->lti->x[626] = 106;
    obj[16]->lti->x[558] = 119;
    obj[16]->lti->x[635] = 105;
    obj[16]->lti->x[544] = 99;
    obj[16]->lti->x[396] = 107;
    obj[16]->lti->y[651] = 117;
    obj[16]->lti->x[906] = 119;
    obj[16]->lti->x[310] = 109;
    obj[16]->lti->x[378] = 122;
    obj[16]->lti->x[737] = 99;
    obj[16]->lti->x[535] = 120;
    obj[16]->lti->x[23] = 105;
    obj[16]->lti->x[71] = 103;
    obj[16]->lti->y[462] = 109;
    obj[16]->lti->x[423] = 97;
    obj[16]->lti->y[169] = 104;
    obj[16]->lti->x[419] = 120;
    obj[16]->lti->y[903] = 99;
    obj[16]->lti->y[565] = 104;
    obj[16]->lti->x[784] = 107;
    obj[16]->lti->x[353] = 107;
    obj[16]->lti->x[230] = 120;
    obj[16]->lti->y[327] = 110;
    obj[16]->lti->x[509] = 117;
    obj[17]->lti->x[17] = 112;
    obj[17]->lti->y[588] = 108;
    obj[17]->lti->y[111] = 110;
    obj[17]->lti->x[880] = 103;
    obj[17]->lti->x[587] = 106;
    obj[17]->lti->x[993] = 119;
    obj[17]->lti->x[320] = 102;
    obj[17]->lti->y[437] = 118;
    obj[17]->lti->x[612] = 122;
    obj[17]->lti->y[463] = 122;
    obj[17]->lti->x[863] = 111;
    obj[17]->lti->y[169] = 105;
    obj[17]->lti->y[371] = 117;
    obj[17]->lti->x[303] = 104;
    obj[17]->lti->y[900] = 115;
    obj[17]->lti->y[219] = 121;
    obj[17]->lti->y[304] = 99;
    obj[17]->lti->x[27] = 121;
    obj[17]->lti->x[637] = 120;
    obj[17]->lti->y[155] = 113;
    obj[17]->lti->x[10] = 112;
    obj[17]->lti->y[908] = 107;
    obj[17]->lti->x[892] = 98;
    obj[17]->lti->x[258] = 106;
    obj[17]->lti->y[541] = 100;
    obj[17]->lti->y[88] = 118;
    obj[17]->lti->y[973] = 105;
    obj[17]->lti->y[715] = 98;
    obj[17]->lti->x[599] = 102;
    obj[17]->lti->x[100] = 114;
    obj[17]->lti->y[956] = 103;
    obj[17]->lti->x[387] = 122;
    obj[17]->lti->y[482] = 97;
    obj[17]->lti->y[986] = 109;
    obj[17]->lti->x[567] = 116;
    obj[17]->lti->x[999] = 116;
    obj[17]->lti->y[376] = 115;
    obj[17]->lti->x[39] = 112;
    obj[17]->lti->x[639] = 100;
    obj[17]->lti->x[414] = 109;
    obj[17]->lti->y[602] = 117;
    obj[17]->lti->x[558] = 112;
    obj[17]->lti->x[739] = 110;
    obj[17]->lti->x[820] = 122;
    obj[17]->lti->x[373] = 114;
    obj[17]->lti->x[609] = 101;
    obj[17]->lti->x[996] = 100;
    obj[17]->lti->x[101] = 117;
    obj[17]->lti->x[528] = 110;
    obj[17]->lti->y[694] = 122;
    obj[17]->lti->x[448] = 113;
    obj[17]->lti->y[423] = 106;
    obj[17]->lti->x[666] = 101;
    obj[17]->lti->y[273] = 103;
    obj[17]->lti->x[584] = 121;
    obj[17]->lti->y[443] = 109;
    obj[17]->lti->y[453] = 112;
    obj[17]->lti->y[47] = 110;
    obj[17]->lti->y[496] = 103;
    obj[17]->lti->y[337] = 115;
    obj[17]->lti->y[67] = 101;
    obj[17]->lti->x[786] = 107;
    obj[17]->lti->x[125] = 112;
    obj[17]->lti->x[898] = 102;
    obj[17]->lti->y[24] = 112;
    obj[17]->lti->x[313] = 118;
    obj[17]->lti->x[633] = 118;
    obj[17]->lti->x[382] = 120;
    obj[17]->lti->y[376] = 111;
    obj[17]->lti->y[688] = 105;
    obj[17]->lti->y[694] = 106;
    obj[17]->lti->y[620] = 97;
    obj[17]->lti->x[205] = 105;
    obj[17]->lti->y[755] = 102;
    obj[17]->lti->x[670] = 121;
    obj[17]->lti->y[404] = 107;
    obj[17]->lti->y[781] = 119;
    obj[17]->lti->x[692] = 113;
    obj[17]->lti->y[170] = 118;
    obj[17]->lti->x[570] = 107;
    obj[17]->lti->y[614] = 119;
    obj[17]->lti->y[584] = 101;
    obj[17]->lti->y[201] = 109;
    obj[17]->lti->x[368] = 102;
    obj[17]->lti->y[934] = 109;
    obj[17]->lti->x[235] = 110;
    obj[17]->lti->y[462] = 120;
    obj[17]->lti->x[940] = 117;
    obj[17]->lti->y[44] = 116;
    obj[17]->lti->y[450] = 103;
    obj[17]->lti->x[270] = 112;
    obj[17]->lti->x[113] = 120;
    obj[17]->lti->y[439] = 98;
    obj[17]->lti->y[687] = 119;
    obj[17]->lti->x[112] = 122;
    obj[17]->lti->y[775] = 106;
    obj[17]->lti->y[710] = 99;
    obj[17]->lti->x[881] = 114;
    obj[17]->lti->x[440] = 112;
    obj[17]->lti->y[347] = 107;
    obj[18]->lti->x[681] = 98;
    obj[18]->lti->x[46] = 103;
    obj[18]->lti->y[309] = 110;
    obj[18]->lti->x[713] = 117;
    obj[18]->lti->x[432] = 100;
    obj[18]->lti->y[777] = 117;
    obj[18]->lti->y[146] = 122;
    obj[18]->lti->x[922] = 104;
    obj[18]->lti->x[16] = 119;
    obj[18]->lti->y[568] = 106;
    obj[18]->lti->y[731] = 113;
    obj[18]->lti->y[960] = 106;
    obj[18]->lti->x[959] = 116;
    obj[18]->lti->y[79] = 120;
    obj[18]->lti->x[58] = 111;
    obj[18]->lti->x[600] = 119;
    obj[18]->lti->x[732] = 110;
    obj[18]->lti->y[627] = 108;
    obj[18]->lti->x[165] = 102;
    obj[18]->lti->x[862] = 113;
    obj[18]->lti->x[627] = 114;
    obj[18]->lti->x[406] = 122;
    obj[18]->lti->x[73] = 118;
    obj[18]->lti->x[255] = 117;
    obj[18]->lti->x[114] = 111;
    obj[18]->lti->y[133] = 98;
    obj[18]->lti->y[952] = 107;
    obj[18]->lti->y[522] = 110;
    obj[18]->lti->y[224] = 103;
    obj[18]->lti->y[225] = 105;
    obj[18]->lti->x[99] = 98;
    obj[18]->lti->y[657] = 106;
    obj[18]->lti->y[673] = 109;
    obj[18]->lti->y[179] = 117;
    obj[18]->lti->x[746] = 114;
    obj[18]->lti->y[610] = 111;
    obj[18]->lti->y[31] = 109;
    obj[18]->lti->y[837] = 104;
    obj[18]->lti->x[312] = 102;
    obj[18]->lti->y[841] = 119;
    obj[18]->lti->x[174] = 111;
    obj[18]->lti->x[706] = 110;
    obj[18]->lti->y[148] = 114;
    obj[18]->lti->y[46] = 102;
    obj[18]->lti->x[228] = 115;
    obj[18]->lti->x[524] = 113;
    obj[18]->lti->x[684] = 120;
    obj[18]->lti->x[413] = 111;
    obj[18]->lti->x[305] = 104;
    obj[18]->lti->x[5] = 100;
    obj[18]->lti->x[554] = 117;
    obj[18]->lti->x[735] = 110;
    obj[18]->lti->y[471] = 112;
    obj[18]->lti->y[97] = 108;
    obj[18]->lti->x[49] = 97;
    obj[18]->lti->x[341] = 111;
    obj[18]->lti->y[963] = 120;
    obj[18]->lti->y[439] = 108;
    obj[18]->lti->x[900] = 111;
    obj[18]->lti->x[198] = 116;
    obj[18]->lti->x[546] = 120;
    obj[18]->lti->y[460] = 108;
    obj[18]->lti->x[373] = 103;
    obj[18]->lti->y[129] = 115;
    obj[18]->lti->x[119] = 97;
    obj[18]->lti->x[846] = 101;
    obj[18]->lti->y[798] = 116;
    obj[18]->lti->x[503] = 97;
    obj[18]->lti->x[399] = 102;
    obj[18]->lti->x[139] = 97;
    obj[18]->lti->y[991] = 111;
    obj[18]->lti->x[486] = 121;
    obj[18]->lti->y[549] = 121;
    obj[18]->lti->x[213] = 116;
    obj[18]->lti->x[537] = 120;
    obj[18]->lti->y[197] = 104;
    obj[18]->lti->x[378] = 105;
    externalFunc(obj[18]);
    obj[18]->lti->x[631] = 103;
    obj[18]->lti->x[444] = 101;
    obj[18]->lti->y[824] = 105;
    obj[18]->lti->x[15] = 114;
    obj[18]->lti->y[253] = 111;
    obj[18]->lti->x[79] = 113;
    obj[18]->lti->y[968] = 99;
    obj[18]->lti->y[816] = 118;
    obj[18]->lti->x[792] = 106;
    obj[18]->lti->x[551] = 117;
    obj[18]->lti->x[984] = 111;
    obj[18]->lti->y[920] = 99;
    obj[18]->lti->x[441] = 97;
    obj[18]->lti->x[213] = 111;
    obj[18]->lti->x[312] = 109;
    obj[18]->lti->x[96] = 104;
    obj[18]->lti->y[901] = 105;
    obj[18]->lti->x[150] = 111;
    obj[18]->lti->x[525] = 111;
    obj[18]->lti->y[756] = 97;
    obj[18]->lti->x[49] = 120;
    obj[18]->lti->x[570] = 107;
    obj[19]->lti->y[237] = 107;
    obj[19]->lti->y[524] = 106;
    obj[19]->lti->y[950] = 98;
    obj[19]->lti->x[343] = 100;
    obj[19]->lti->y[92] = 117;
    obj[19]->lti->x[300] = 105;
    obj[19]->lti->y[589] = 116;
    obj[19]->lti->x[72] = 99;
    obj[19]->lti->x[519] = 118;
    obj[19]->lti->x[527] = 105;
    obj[19]->lti->y[478] = 113;
    obj[19]->lti->y[814] = 120;
    obj[19]->lti->x[434] = 112;
    obj[19]->lti->y[889] = 110;
    obj[19]->lti->x[593] = 110;
    obj[19]->lti->x[241] = 120;
    obj[19]->lti->y[624] = 102;
    obj[19]->lti->y[601] = 114;
    obj[19]->lti->x[645] = 107;
    obj[19]->lti->y[825] = 116;
    obj[19]->lti->x[565] = 105;
    obj[19]->lti->y[230] = 112;
    obj[19]->lti->y[555] = 108;
    obj[19]->lti->y[433] = 114;
    obj[19]->lti->y[663] = 98;
    obj[19]->lti->x[17] = 105;
    obj[19]->lti->x[409] = 98;
    obj[19]->lti->y[904] = 100;
    obj[19]->lti->y[258] = 105;
    obj[19]->lti->x[118] = 98;
    obj[19]->lti->y[338] = 122;
    obj[19]->lti->y[745] = 109;
    obj[19]->lti->x[190] = 117;
    obj[19]->lti->x[694] = 108;
    obj[19]->lti->y[345] = 118;
    obj[19]->lti->x[7] = 119;
    obj[19]->lti->x[451] = 120;
    obj[19]->lti->y[823] = 104;
    obj[19]->lti->y[370] = 98;
    obj[19]->lti->y[568] = 108;
    obj[19]->lti->x[903] = 111;
    obj[19]->lti->x[263] = 112;
    obj[19]->lti->x[993] = 112;
    obj[19]->lti->y[233] = 117;
    obj[19]->lti->y[509] = 116;
    obj[19]->lti->y[478] = 110;
    obj[19]->lti->x[115] = 105;
    obj[19]->lti->y[615] = 108;
    obj[19]->lti->x[415] = 115;
    obj[19]->lti->y[563] = 106;
    obj[19]->lti->x[546] = 103;
    obj[19]->lti->y[81] = 104;
    obj[19]->lti->x[650] = 99;
    obj[19]->lti->y[448] = 121;
    obj[19]->lti->x[213] = 121;
    obj[19]->lti->x[68] = 100;
    obj[19]->lti->y[533] = 117;
    obj[19]->lti->x[102] = 106;
    obj[19]->lti->x[87] = 108;
    obj[19]->lti->y[320] = 105;
    obj[19]->lti->y[615] = 112;
    obj[19]->lti->x[435] = 110;
    obj[19]->lti->x[523] = 100;
    obj[19]->lti->x[591] = 116;
    obj[19]->lti->x[85] = 113;
    obj[19]->lti->x[571] = 111;
    obj[19]->lti->y[676] = 120;
    obj[19]->lti->y[767] = 114;
    obj[19]->lti->y[515] = 105;
    obj[19]->lti->y[801] = 104;
    obj[19]->lti->y[38] = 111;
    obj[19]->lti->x[960] = 122;
    obj[19]->lti->x[924] = 121;
    obj[19]->lti->y[682] = 103;
    obj[19]->lti->x[663] = 113;
    obj[19]->lti->x[278] = 103;
    obj[19]->lti->x[872] = 103;
    obj[19]->lti->x[222] = 118;
    obj[19]->lti->y[700] = 119;
    obj[19]->lti->y[825] = 102;
    obj[19]->lti->x[349] = 98;
    obj[19]->lti->y[818] = 121;
    obj[19]->lti->x[882] = 99;
    obj[19]->lti->x[848] = 110;
    obj[19]->lti->y[331] = 100;
    obj[19]->lti->y[616] = 105;
    obj[19]->lti->y[390] = 101;
    obj[19]->lti->y[279] = 106;
    obj[19]->lti->y[183] = 99;
    obj[19]->lti->y[898] = 102;
    obj[19]->lti->x[804] = 111;
    obj[19]->lti->y[440] = 115;
    obj[19]->lti->x[18] = 122;
    obj[19]->lti->x[652] = 114;
    obj[19]->lti->x[565] = 107;
    obj[19]->lti->x[943] = 98;
    obj[19]->lti->x[71] = 100;
    obj[19]->lti->x[628] = 108;
    obj[19]->lti->y[179] = 115;
    obj[19]->lti->x[362] = 107;
}
void branchPruned(struct HighType** obj) {
    if(obj[0] == NULL &&
    obj[1]->lti->y[19] == 102 &&
    obj[1]->lti->y[48] == 100 &&
    obj[1]->lti->y[63] == 120 &&
    obj[1]->lti->y[74] == 110 &&
    obj[1]->lti->y[86] == 114 &&
    obj[1]->lti->y[90] == 99 &&
    obj[1]->lti->y[103] == 119 &&
    obj[1]->lti->y[109] == 99 &&
    obj[1]->lti->y[128] == 112 &&
    obj[1]->lti->y[130] == 99 &&
    obj[1]->lti->y[139] == 103 &&
    obj[1]->lti->y[182] == 121 &&
    obj[1]->lti->y[201] == 97 &&
    obj[1]->lti->y[222] == 121 &&
    obj[1]->lti->y[223] == 119 &&
    obj[1]->lti->y[246] == 106 &&
    obj[1]->lti->y[312] == 106 &&
    obj[1]->lti->y[323] == 113 &&
    obj[1]->lti->y[354] == 102 &&
    obj[1]->lti->y[360] == 101 &&
    obj[1]->lti->y[377] == 110 &&
    obj[1]->lti->y[383] == 97 &&
    obj[1]->lti->y[386] == 103 &&
    obj[1]->lti->y[417] == 121 &&
    obj[1]->lti->y[525] == 110 &&
    obj[1]->lti->y[528] == 119 &&
    obj[1]->lti->y[586] == 109 &&
    obj[1]->lti->y[602] == 106 &&
    obj[1]->lti->y[625] == 122 &&
    obj[1]->lti->y[627] == 118 &&
    obj[1]->lti->y[628] == 122 &&
    obj[1]->lti->y[635] == 109 &&
    obj[1]->lti->y[645] == 99 &&
    obj[1]->lti->y[651] == 113 &&
    obj[1]->lti->y[685] == 112 &&
    obj[1]->lti->y[688] == 113 &&
    obj[1]->lti->y[710] == 111 &&
    obj[1]->lti->y[711] == 113 &&
    obj[1]->lti->y[730] == 121 &&
    obj[1]->lti->y[752] == 115 &&
    obj[1]->lti->y[787] == 122 &&
    obj[1]->lti->y[795] == 104 &&
    obj[1]->lti->y[812] == 110 &&
    obj[1]->lti->y[834] == 122 &&
    obj[1]->lti->y[836] == 120 &&
    obj[1]->lti->y[849] == 97 &&
    obj[1]->lti->y[852] == 101 &&
    obj[1]->lti->y[976] == 101 &&
    obj[1]->lti->y[983] == 101 &&
    obj[1]->lti->x[24] == 97 &&
    obj[1]->lti->x[46] == 107 &&
    obj[1]->lti->x[82] == 112 &&
    obj[1]->lti->x[91] == 107 &&
    obj[1]->lti->x[99] == 119 &&
    obj[1]->lti->x[136] == 109 &&
    obj[1]->lti->x[144] == 104 &&
    obj[1]->lti->x[212] == 104 &&
    obj[1]->lti->x[222] == 103 &&
    obj[1]->lti->x[248] == 118 &&
    obj[1]->lti->x[318] == 108 &&
    obj[1]->lti->x[323] == 109 &&
    obj[1]->lti->x[329] == 116 &&
    obj[1]->lti->x[348] == 113 &&
    obj[1]->lti->x[367] == 97 &&
    obj[1]->lti->x[379] == 120 &&
    obj[1]->lti->x[413] == 115 &&
    obj[1]->lti->x[422] == 121 &&
    obj[1]->lti->x[425] == 104 &&
    obj[1]->lti->x[446] == 107 &&
    obj[1]->lti->x[449] == 112 &&
    obj[1]->lti->x[453] == 102 &&
    obj[1]->lti->x[456] == 114 &&
    obj[1]->lti->x[464] == 121 &&
    obj[1]->lti->x[472] == 98 &&
    obj[1]->lti->x[483] == 111 &&
    obj[1]->lti->x[490] == 116 &&
    obj[1]->lti->x[510] == 107 &&
    obj[1]->lti->x[544] == 112 &&
    obj[1]->lti->x[562] == 116 &&
    obj[1]->lti->x[589] == 114 &&
    obj[1]->lti->x[599] == 116 &&
    obj[1]->lti->x[621] == 100 &&
    obj[1]->lti->x[637] == 109 &&
    obj[1]->lti->x[648] == 116 &&
    obj[1]->lti->x[665] == 117 &&
    obj[1]->lti->x[710] == 119 &&
    obj[1]->lti->x[714] == 119 &&
    obj[1]->lti->x[756] == 100 &&
    obj[1]->lti->x[780] == 122 &&
    obj[1]->lti->x[782] == 102 &&
    obj[1]->lti->x[789] == 101 &&
    obj[1]->lti->x[860] == 108 &&
    obj[1]->lti->x[873] == 112 &&
    obj[1]->lti->x[876] == 116 &&
    obj[1]->lti->x[878] == 106 &&
    obj[1]->lti->x[896] == 103 &&
    obj[1]->lti->x[942] == 106 &&
    obj[1]->lti->x[984] == 108 &&
    obj[1]->lti->x[987] == 108 &&
    obj[3]->lti->y[35] == 112 &&
    obj[3]->lti->y[45] == 107 &&
    obj[3]->lti->y[66] == 105 &&
    obj[3]->lti->y[74] == 100 &&
    obj[3]->lti->y[153] == 117 &&
    obj[3]->lti->y[160] == 113 &&
    obj[3]->lti->y[208] == 97 &&
    obj[3]->lti->y[220] == 98 &&
    obj[3]->lti->y[259] == 118 &&
    obj[3]->lti->y[263] == 104 &&
    obj[3]->lti->y[290] == 97 &&
    obj[3]->lti->y[313] == 97 &&
    obj[3]->lti->y[327] == 109 &&
    obj[3]->lti->y[374] == 103 &&
    obj[3]->lti->y[393] == 109 &&
    obj[3]->lti->y[398] == 121 &&
    obj[3]->lti->y[401] == 119 &&
    obj[3]->lti->y[433] == 102 &&
    obj[3]->lti->y[507] == 105 &&
    obj[3]->lti->y[515] == 116 &&
    obj[3]->lti->y[545] == 98 &&
    obj[3]->lti->y[603] == 121 &&
    obj[3]->lti->y[643] == 97 &&
    obj[3]->lti->y[662] == 114 &&
    obj[3]->lti->y[664] == 121 &&
    obj[3]->lti->y[712] == 116 &&
    obj[3]->lti->y[728] == 107 &&
    obj[3]->lti->y[750] == 97 &&
    obj[3]->lti->y[772] == 105 &&
    obj[3]->lti->y[778] == 104 &&
    obj[3]->lti->y[806] == 108 &&
    obj[3]->lti->y[808] == 102 &&
    obj[3]->lti->y[851] == 104 &&
    obj[3]->lti->y[853] == 105 &&
    obj[3]->lti->y[878] == 117 &&
    obj[3]->lti->y[880] == 121 &&
    obj[3]->lti->y[895] == 113 &&
    obj[3]->lti->y[899] == 115 &&
    obj[3]->lti->y[910] == 112 &&
    obj[3]->lti->y[913] == 113 &&
    obj[3]->lti->y[928] == 103 &&
    obj[3]->lti->y[938] == 114 &&
    obj[3]->lti->y[950] == 113 &&
    obj[3]->lti->y[957] == 97 &&
    obj[3]->lti->x[2] == 98 &&
    obj[3]->lti->x[28] == 119 &&
    obj[3]->lti->x[29] == 110 &&
    obj[3]->lti->x[30] == 97 &&
    obj[3]->lti->x[34] == 105 &&
    obj[3]->lti->x[38] == 118 &&
    obj[3]->lti->x[110] == 97 &&
    obj[3]->lti->x[119] == 106 &&
    obj[3]->lti->x[132] == 112 &&
    obj[3]->lti->x[187] == 106 &&
    obj[3]->lti->x[232] == 117 &&
    obj[3]->lti->x[239] == 109 &&
    obj[3]->lti->x[261] == 101 &&
    obj[3]->lti->x[263] == 113 &&
    obj[3]->lti->x[275] == 105 &&
    obj[3]->lti->x[283] == 120 &&
    obj[3]->lti->x[287] == 99 &&
    obj[3]->lti->x[318] == 104 &&
    obj[3]->lti->x[349] == 113 &&
    obj[3]->lti->x[365] == 102 &&
    obj[3]->lti->x[403] == 99 &&
    obj[3]->lti->x[408] == 98 &&
    obj[3]->lti->x[411] == 103 &&
    obj[3]->lti->x[419] == 108 &&
    obj[3]->lti->x[440] == 116 &&
    obj[3]->lti->x[456] == 102 &&
    obj[3]->lti->x[457] == 105 &&
    obj[3]->lti->x[468] == 111 &&
    obj[3]->lti->x[469] == 113 &&
    obj[3]->lti->x[536] == 107 &&
    obj[3]->lti->x[548] == 112 &&
    obj[3]->lti->x[585] == 118 &&
    obj[3]->lti->x[590] == 110 &&
    obj[3]->lti->x[598] == 106 &&
    obj[3]->lti->x[610] == 117 &&
    obj[3]->lti->x[625] == 100 &&
    obj[3]->lti->x[633] == 101 &&
    obj[3]->lti->x[645] == 98 &&
    obj[3]->lti->x[680] == 97 &&
    obj[3]->lti->x[712] == 121 &&
    obj[3]->lti->x[713] == 119 &&
    obj[3]->lti->x[728] == 108 &&
    obj[3]->lti->x[748] == 111 &&
    obj[3]->lti->x[752] == 107 &&
    obj[3]->lti->x[756] == 104 &&
    obj[3]->lti->x[797] == 101 &&
    obj[3]->lti->x[834] == 122 &&
    obj[3]->lti->x[861] == 102 &&
    obj[3]->lti->x[867] == 115 &&
    obj[3]->lti->x[889] == 116 &&
    obj[3]->lti->x[897] == 102 &&
    obj[3]->lti->x[907] == 115 &&
    obj[3]->lti->x[918] == 108 &&
    obj[5]->lti->y[36] == 121 &&
    obj[5]->lti->y[72] == 117 &&
    obj[5]->lti->y[106] == 106 &&
    obj[5]->lti->y[110] == 102 &&
    obj[5]->lti->y[112] == 102 &&
    obj[5]->lti->y[132] == 117 &&
    obj[5]->lti->y[172] == 104 &&
    obj[5]->lti->y[181] == 108 &&
    obj[5]->lti->y[190] == 105 &&
    obj[5]->lti->y[218] == 105 &&
    obj[5]->lti->y[219] == 115 &&
    obj[5]->lti->y[229] == 117 &&
    obj[5]->lti->y[294] == 103 &&
    obj[5]->lti->y[310] == 106 &&
    obj[5]->lti->y[318] == 107 &&
    obj[5]->lti->y[329] == 104 &&
    obj[5]->lti->y[376] == 102 &&
    obj[5]->lti->y[395] == 117 &&
    obj[5]->lti->y[406] == 108 &&
    obj[5]->lti->y[425] == 112 &&
    obj[5]->lti->y[439] == 122 &&
    obj[5]->lti->y[475] == 110 &&
    obj[5]->lti->y[506] == 115 &&
    obj[5]->lti->y[531] == 115 &&
    obj[5]->lti->y[542] == 115 &&
    obj[5]->lti->y[563] == 97 &&
    obj[5]->lti->y[588] == 109 &&
    obj[5]->lti->y[615] == 121 &&
    obj[5]->lti->y[663] == 97 &&
    obj[5]->lti->y[677] == 118 &&
    obj[5]->lti->y[694] == 97 &&
    obj[5]->lti->y[695] == 116 &&
    obj[5]->lti->y[721] == 120 &&
    obj[5]->lti->y[722] == 120 &&
    obj[5]->lti->y[747] == 107 &&
    obj[5]->lti->y[783] == 114 &&
    obj[5]->lti->y[787] == 118 &&
    obj[5]->lti->y[793] == 97 &&
    obj[5]->lti->y[847] == 117 &&
    obj[5]->lti->y[878] == 113 &&
    obj[5]->lti->y[964] == 100 &&
    obj[5]->lti->y[995] == 111 &&
    obj[5]->lti->x[15] == 109 &&
    obj[5]->lti->x[18] == 121 &&
    obj[5]->lti->x[67] == 117 &&
    obj[5]->lti->x[71] == 121 &&
    obj[5]->lti->x[96] == 112 &&
    obj[5]->lti->x[97] == 103 &&
    obj[5]->lti->x[121] == 122 &&
    obj[5]->lti->x[125] == 101 &&
    obj[5]->lti->x[127] == 101 &&
    obj[5]->lti->x[142] == 103 &&
    obj[5]->lti->x[144] == 108 &&
    obj[5]->lti->x[153] == 122 &&
    obj[5]->lti->x[163] == 122 &&
    obj[5]->lti->x[240] == 111 &&
    obj[5]->lti->x[262] == 104 &&
    obj[5]->lti->x[269] == 117 &&
    obj[5]->lti->x[310] == 109 &&
    obj[5]->lti->x[322] == 108 &&
    obj[5]->lti->x[333] == 103 &&
    obj[5]->lti->x[351] == 104 &&
    obj[5]->lti->x[364] == 101 &&
    obj[5]->lti->x[369] == 99 &&
    obj[5]->lti->x[382] == 122 &&
    obj[5]->lti->x[404] == 119 &&
    obj[5]->lti->x[413] == 106 &&
    obj[5]->lti->x[428] == 120 &&
    obj[5]->lti->x[503] == 116 &&
    obj[5]->lti->x[524] == 115 &&
    obj[5]->lti->x[534] == 106 &&
    obj[5]->lti->x[580] == 120 &&
    obj[5]->lti->x[614] == 102 &&
    obj[5]->lti->x[624] == 102 &&
    obj[5]->lti->x[649] == 105 &&
    obj[5]->lti->x[659] == 109 &&
    obj[5]->lti->x[663] == 97 &&
    obj[5]->lti->x[684] == 102 &&
    obj[5]->lti->x[693] == 114 &&
    obj[5]->lti->x[729] == 117 &&
    obj[5]->lti->x[735] == 122 &&
    obj[5]->lti->x[785] == 116 &&
    obj[5]->lti->x[792] == 97 &&
    obj[5]->lti->x[818] == 110 &&
    obj[5]->lti->x[820] == 106 &&
    obj[5]->lti->x[828] == 114 &&
    obj[5]->lti->x[843] == 105 &&
    obj[5]->lti->x[854] == 115 &&
    obj[5]->lti->x[866] == 101 &&
    obj[5]->lti->x[880] == 106 &&
    obj[5]->lti->x[920] == 113 &&
    obj[5]->lti->x[939] == 102 &&
    obj[5]->lti->x[947] == 109 &&
    obj[5]->lti->x[960] == 98 &&
    obj[5]->lti->x[970] == 98 &&
    obj[5]->lti->x[974] == 115 &&
    obj[5]->lti->x[975] == 114 &&
    obj[5]->lti->x[976] == 112 &&
    obj[5]->lti->x[979] == 112 &&
    obj[6]->lti->y[24] == 103 &&
    obj[6]->lti->y[39] == 121 &&
    obj[6]->lti->y[54] == 112 &&
    obj[6]->lti->y[91] == 103 &&
    obj[6]->lti->y[94] == 118 &&
    obj[6]->lti->y[98] == 100 &&
    obj[6]->lti->y[121] == 98 &&
    obj[6]->lti->y[124] == 113 &&
    obj[6]->lti->y[135] == 108 &&
    obj[6]->lti->y[136] == 111 &&
    obj[6]->lti->y[218] == 121 &&
    obj[6]->lti->y[234] == 103 &&
    obj[6]->lti->y[244] == 100 &&
    obj[6]->lti->y[260] == 106 &&
    obj[6]->lti->y[274] == 113 &&
    obj[6]->lti->y[292] == 100 &&
    obj[6]->lti->y[294] == 116 &&
    obj[6]->lti->y[313] == 109 &&
    obj[6]->lti->y[342] == 118 &&
    obj[6]->lti->y[356] == 114 &&
    obj[6]->lti->y[359] == 107 &&
    obj[6]->lti->y[414] == 117 &&
    obj[6]->lti->y[417] == 118 &&
    obj[6]->lti->y[430] == 107 &&
    obj[6]->lti->y[433] == 117 &&
    obj[6]->lti->y[459] == 109 &&
    obj[6]->lti->y[490] == 109 &&
    obj[6]->lti->y[555] == 109 &&
    obj[6]->lti->y[578] == 97 &&
    obj[6]->lti->y[598] == 119 &&
    obj[6]->lti->y[605] == 117 &&
    obj[6]->lti->y[612] == 111 &&
    obj[6]->lti->y[626] == 117 &&
    obj[6]->lti->y[639] == 113 &&
    obj[6]->lti->y[648] == 105 &&
    obj[6]->lti->y[650] == 114 &&
    obj[6]->lti->y[669] == 110 &&
    obj[6]->lti->y[733] == 113 &&
    obj[6]->lti->y[738] == 122 &&
    obj[6]->lti->y[761] == 111 &&
    obj[6]->lti->y[799] == 118 &&
    obj[6]->lti->y[834] == 119 &&
    obj[6]->lti->y[837] == 103 &&
    obj[6]->lti->y[866] == 104 &&
    obj[6]->lti->y[920] == 112 &&
    obj[6]->lti->y[956] == 114 &&
    obj[6]->lti->y[958] == 113 &&
    obj[6]->lti->y[969] == 98 &&
    obj[6]->lti->y[977] == 121 &&
    obj[6]->lti->y[983] == 120 &&
    obj[6]->lti->y[993] == 104 &&
    obj[6]->lti->x[23] == 111 &&
    obj[6]->lti->x[33] == 98 &&
    obj[6]->lti->x[53] == 120 &&
    obj[6]->lti->x[74] == 114 &&
    obj[6]->lti->x[81] == 115 &&
    obj[6]->lti->x[101] == 116 &&
    obj[6]->lti->x[110] == 110 &&
    obj[6]->lti->x[114] == 110 &&
    obj[6]->lti->x[130] == 119 &&
    obj[6]->lti->x[170] == 105 &&
    obj[6]->lti->x[192] == 113 &&
    obj[6]->lti->x[239] == 115 &&
    obj[6]->lti->x[302] == 114 &&
    obj[6]->lti->x[308] == 107 &&
    obj[6]->lti->x[317] == 114 &&
    obj[6]->lti->x[348] == 109 &&
    obj[6]->lti->x[393] == 120 &&
    obj[6]->lti->x[456] == 111 &&
    obj[6]->lti->x[480] == 106 &&
    obj[6]->lti->x[494] == 119 &&
    obj[6]->lti->x[528] == 109 &&
    obj[6]->lti->x[560] == 103 &&
    obj[6]->lti->x[574] == 117 &&
    obj[6]->lti->x[599] == 101 &&
    obj[6]->lti->x[629] == 99 &&
    obj[6]->lti->x[630] == 101 &&
    obj[6]->lti->x[639] == 106 &&
    obj[6]->lti->x[672] == 102 &&
    obj[6]->lti->x[679] == 98 &&
    obj[6]->lti->x[681] == 122 &&
    obj[6]->lti->x[703] == 101 &&
    obj[6]->lti->x[750] == 103 &&
    obj[6]->lti->x[782] == 119 &&
    obj[6]->lti->x[784] == 122 &&
    obj[6]->lti->x[789] == 120 &&
    obj[6]->lti->x[801] == 97 &&
    obj[6]->lti->x[807] == 104 &&
    obj[6]->lti->x[843] == 112 &&
    obj[6]->lti->x[847] == 107 &&
    obj[6]->lti->x[852] == 102 &&
    obj[6]->lti->x[869] == 112 &&
    obj[6]->lti->x[935] == 113 &&
    obj[6]->lti->x[969] == 116 &&
    obj[6]->lti->x[986] == 114 &&
    obj[7]->lti->y[18] == 100 &&
    obj[7]->lti->y[33] == 98 &&
    obj[7]->lti->y[44] == 113 &&
    obj[7]->lti->y[50] == 103 &&
    obj[7]->lti->y[128] == 116 &&
    obj[7]->lti->y[138] == 111 &&
    obj[7]->lti->y[148] == 106 &&
    obj[7]->lti->y[184] == 103 &&
    obj[7]->lti->y[219] == 99 &&
    obj[7]->lti->y[226] == 118 &&
    obj[7]->lti->y[245] == 113 &&
    obj[7]->lti->y[266] == 118 &&
    obj[7]->lti->y[289] == 101 &&
    obj[7]->lti->y[308] == 98 &&
    obj[7]->lti->y[334] == 106 &&
    obj[7]->lti->y[374] == 105 &&
    obj[7]->lti->y[375] == 119 &&
    obj[7]->lti->y[389] == 117 &&
    obj[7]->lti->y[404] == 107 &&
    obj[7]->lti->y[423] == 119 &&
    obj[7]->lti->y[431] == 102 &&
    obj[7]->lti->y[469] == 104 &&
    obj[7]->lti->y[474] == 110 &&
    obj[7]->lti->y[501] == 122 &&
    obj[7]->lti->y[507] == 122 &&
    obj[7]->lti->y[514] == 100 &&
    obj[7]->lti->y[521] == 106 &&
    obj[7]->lti->y[532] == 105 &&
    obj[7]->lti->y[534] == 98 &&
    obj[7]->lti->y[555] == 116 &&
    obj[7]->lti->y[572] == 108 &&
    obj[7]->lti->y[597] == 112 &&
    obj[7]->lti->y[608] == 109 &&
    obj[7]->lti->y[624] == 104 &&
    obj[7]->lti->y[648] == 117 &&
    obj[7]->lti->y[663] == 101 &&
    obj[7]->lti->y[743] == 103 &&
    obj[7]->lti->y[745] == 110 &&
    obj[7]->lti->y[747] == 119 &&
    obj[7]->lti->y[752] == 120 &&
    obj[7]->lti->y[786] == 112 &&
    obj[7]->lti->y[810] == 113 &&
    obj[7]->lti->y[856] == 108 &&
    obj[7]->lti->y[873] == 119 &&
    obj[7]->lti->y[890] == 120 &&
    obj[7]->lti->y[921] == 99 &&
    obj[7]->lti->y[942] == 97 &&
    obj[7]->lti->y[945] == 118 &&
    obj[7]->lti->y[959] == 122 &&
    obj[7]->lti->y[972] == 99 &&
    obj[7]->lti->y[980] == 105 &&
    obj[7]->lti->x[50] == 121 &&
    obj[7]->lti->x[56] == 110 &&
    obj[7]->lti->x[64] == 99 &&
    obj[7]->lti->x[102] == 111 &&
    obj[7]->lti->x[110] == 109 &&
    obj[7]->lti->x[115] == 120 &&
    obj[7]->lti->x[140] == 103 &&
    obj[7]->lti->x[184] == 116 &&
    obj[7]->lti->x[198] == 122 &&
    obj[7]->lti->x[209] == 117 &&
    obj[7]->lti->x[256] == 104 &&
    obj[7]->lti->x[262] == 119 &&
    obj[7]->lti->x[265] == 100 &&
    obj[7]->lti->x[272] == 108 &&
    obj[7]->lti->x[279] == 99 &&
    obj[7]->lti->x[294] == 112 &&
    obj[7]->lti->x[308] == 116 &&
    obj[7]->lti->x[343] == 115 &&
    obj[7]->lti->x[350] == 108 &&
    obj[7]->lti->x[373] == 106 &&
    obj[7]->lti->x[407] == 117 &&
    obj[7]->lti->x[436] == 110 &&
    obj[7]->lti->x[463] == 106 &&
    obj[7]->lti->x[466] == 98 &&
    obj[7]->lti->x[479] == 105 &&
    obj[7]->lti->x[522] == 111 &&
    obj[7]->lti->x[553] == 100 &&
    obj[7]->lti->x[560] == 117 &&
    obj[7]->lti->x[566] == 99 &&
    obj[7]->lti->x[592] == 111 &&
    obj[7]->lti->x[605] == 108 &&
    obj[7]->lti->x[627] == 101 &&
    obj[7]->lti->x[629] == 103 &&
    obj[7]->lti->x[688] == 112 &&
    obj[7]->lti->x[763] == 111 &&
    obj[7]->lti->x[781] == 97 &&
    obj[7]->lti->x[794] == 101 &&
    obj[7]->lti->x[865] == 108 &&
    obj[7]->lti->x[874] == 97 &&
    obj[7]->lti->x[879] == 104 &&
    obj[7]->lti->x[884] == 102 &&
    obj[7]->lti->x[904] == 97 &&
    obj[7]->lti->x[915] == 119 &&
    obj[7]->lti->x[927] == 110 &&
    obj[7]->lti->x[954] == 106 &&
    obj[7]->lti->x[961] == 106 &&
    obj[7]->lti->x[970] == 114 &&
    obj[7]->lti->x[986] == 102 &&
    obj[8]->lti->y[7] == 120 &&
    obj[8]->lti->y[107] == 118 &&
    obj[8]->lti->y[170] == 117 &&
    obj[8]->lti->y[174] == 122 &&
    obj[8]->lti->y[178] == 98 &&
    obj[8]->lti->y[202] == 114 &&
    obj[8]->lti->y[215] == 108 &&
    obj[8]->lti->y[235] == 106 &&
    obj[8]->lti->y[239] == 106 &&
    obj[8]->lti->y[240] == 122 &&
    obj[8]->lti->y[270] == 105 &&
    obj[8]->lti->y[287] == 121 &&
    obj[8]->lti->y[298] == 122 &&
    obj[8]->lti->y[320] == 113 &&
    obj[8]->lti->y[321] == 102 &&
    obj[8]->lti->y[332] == 114 &&
    obj[8]->lti->y[341] == 119 &&
    obj[8]->lti->y[397] == 108 &&
    obj[8]->lti->y[428] == 101 &&
    obj[8]->lti->y[524] == 103 &&
    obj[8]->lti->y[564] == 107 &&
    obj[8]->lti->y[570] == 114 &&
    obj[8]->lti->y[576] == 105 &&
    obj[8]->lti->y[608] == 116 &&
    obj[8]->lti->y[624] == 99 &&
    obj[8]->lti->y[640] == 103 &&
    obj[8]->lti->y[655] == 104 &&
    obj[8]->lti->y[678] == 112 &&
    obj[8]->lti->y[699] == 121 &&
    obj[8]->lti->y[701] == 106 &&
    obj[8]->lti->y[713] == 97 &&
    obj[8]->lti->y[719] == 117 &&
    obj[8]->lti->y[737] == 114 &&
    obj[8]->lti->y[741] == 109 &&
    obj[8]->lti->y[798] == 115 &&
    obj[8]->lti->y[810] == 97 &&
    obj[8]->lti->y[831] == 98 &&
    obj[8]->lti->y[898] == 120 &&
    obj[8]->lti->y[921] == 110 &&
    obj[8]->lti->y[927] == 97 &&
    obj[8]->lti->y[960] == 103 &&
    obj[8]->lti->x[31] == 101 &&
    obj[8]->lti->x[39] == 109 &&
    obj[8]->lti->x[43] == 113 &&
    obj[8]->lti->x[70] == 112 &&
    obj[8]->lti->x[92] == 104 &&
    obj[8]->lti->x[136] == 121 &&
    obj[8]->lti->x[181] == 113 &&
    obj[8]->lti->x[191] == 107 &&
    obj[8]->lti->x[203] == 120 &&
    obj[8]->lti->x[225] == 110 &&
    obj[8]->lti->x[256] == 117 &&
    obj[8]->lti->x[260] == 106 &&
    obj[8]->lti->x[268] == 108 &&
    obj[8]->lti->x[286] == 97 &&
    obj[8]->lti->x[288] == 100 &&
    obj[8]->lti->x[292] == 110 &&
    obj[8]->lti->x[299] == 108 &&
    obj[8]->lti->x[301] == 122 &&
    obj[8]->lti->x[377] == 97 &&
    obj[8]->lti->x[390] == 114 &&
    obj[8]->lti->x[397] == 113 &&
    obj[8]->lti->x[415] == 97 &&
    obj[8]->lti->x[428] == 116 &&
    obj[8]->lti->x[435] == 101 &&
    obj[8]->lti->x[448] == 106 &&
    obj[8]->lti->x[454] == 116 &&
    obj[8]->lti->x[455] == 119 &&
    obj[8]->lti->x[474] == 109 &&
    obj[8]->lti->x[505] == 101 &&
    obj[8]->lti->x[507] == 97 &&
    obj[8]->lti->x[511] == 113 &&
    obj[8]->lti->x[538] == 100 &&
    obj[8]->lti->x[549] == 121 &&
    obj[8]->lti->x[561] == 120 &&
    obj[8]->lti->x[563] == 112 &&
    obj[8]->lti->x[568] == 113 &&
    obj[8]->lti->x[579] == 122 &&
    obj[8]->lti->x[588] == 105 &&
    obj[8]->lti->x[595] == 117 &&
    obj[8]->lti->x[617] == 108 &&
    obj[8]->lti->x[648] == 107 &&
    obj[8]->lti->x[650] == 111 &&
    obj[8]->lti->x[667] == 108 &&
    obj[8]->lti->x[671] == 105 &&
    obj[8]->lti->x[678] == 100 &&
    obj[8]->lti->x[679] == 111 &&
    obj[8]->lti->x[708] == 112 &&
    obj[8]->lti->x[710] == 101 &&
    obj[8]->lti->x[741] == 113 &&
    obj[8]->lti->x[743] == 100 &&
    obj[8]->lti->x[771] == 111 &&
    obj[8]->lti->x[783] == 114 &&
    obj[8]->lti->x[797] == 110 &&
    obj[8]->lti->x[821] == 113 &&
    obj[8]->lti->x[851] == 111 &&
    obj[8]->lti->x[875] == 112 &&
    obj[8]->lti->x[888] == 98 &&
    obj[9] == NULL &&
    obj[10]->lti->y[25] == 117 &&
    obj[10]->lti->y[34] == 100 &&
    obj[10]->lti->y[43] == 104 &&
    obj[10]->lti->y[49] == 121 &&
    obj[10]->lti->y[68] == 98 &&
    obj[10]->lti->y[120] == 118 &&
    obj[10]->lti->y[131] == 120 &&
    obj[10]->lti->y[145] == 108 &&
    obj[10]->lti->y[168] == 106 &&
    obj[10]->lti->y[175] == 102 &&
    obj[10]->lti->y[182] == 103 &&
    obj[10]->lti->y[193] == 97 &&
    obj[10]->lti->y[207] == 115 &&
    obj[10]->lti->y[224] == 122 &&
    obj[10]->lti->y[226] == 100 &&
    obj[10]->lti->y[264] == 121 &&
    obj[10]->lti->y[295] == 109 &&
    obj[10]->lti->y[305] == 100 &&
    obj[10]->lti->y[325] == 112 &&
    obj[10]->lti->y[429] == 114 &&
    obj[10]->lti->y[431] == 99 &&
    obj[10]->lti->y[441] == 102 &&
    obj[10]->lti->y[452] == 120 &&
    obj[10]->lti->y[484] == 111 &&
    obj[10]->lti->y[485] == 110 &&
    obj[10]->lti->y[486] == 121 &&
    obj[10]->lti->y[515] == 103 &&
    obj[10]->lti->y[560] == 102 &&
    obj[10]->lti->y[564] == 108 &&
    obj[10]->lti->y[581] == 116 &&
    obj[10]->lti->y[590] == 118 &&
    obj[10]->lti->y[628] == 119 &&
    obj[10]->lti->y[650] == 122 &&
    obj[10]->lti->y[651] == 103 &&
    obj[10]->lti->y[684] == 117 &&
    obj[10]->lti->y[689] == 109 &&
    obj[10]->lti->y[727] == 100 &&
    obj[10]->lti->y[737] == 121 &&
    obj[10]->lti->y[774] == 118 &&
    obj[10]->lti->y[777] == 101 &&
    obj[10]->lti->y[791] == 106 &&
    obj[10]->lti->y[820] == 106 &&
    obj[10]->lti->y[823] == 121 &&
    obj[10]->lti->y[844] == 117 &&
    obj[10]->lti->y[869] == 110 &&
    obj[10]->lti->y[897] == 118 &&
    obj[10]->lti->y[908] == 99 &&
    obj[10]->lti->y[925] == 105 &&
    obj[10]->lti->y[940] == 116 &&
    obj[10]->lti->y[943] == 107 &&
    obj[10]->lti->y[974] == 105 &&
    obj[10]->lti->y[999] == 121 &&
    obj[10]->lti->x[4] == 100 &&
    obj[10]->lti->x[12] == 112 &&
    obj[10]->lti->x[34] == 119 &&
    obj[10]->lti->x[35] == 110 &&
    obj[10]->lti->x[79] == 116 &&
    obj[10]->lti->x[86] == 120 &&
    obj[10]->lti->x[103] == 100 &&
    obj[10]->lti->x[112] == 109 &&
    obj[10]->lti->x[123] == 105 &&
    obj[10]->lti->x[167] == 100 &&
    obj[10]->lti->x[198] == 97 &&
    obj[10]->lti->x[210] == 120 &&
    obj[10]->lti->x[282] == 122 &&
    obj[10]->lti->x[336] == 106 &&
    obj[10]->lti->x[338] == 98 &&
    obj[10]->lti->x[341] == 116 &&
    obj[10]->lti->x[415] == 105 &&
    obj[10]->lti->x[434] == 116 &&
    obj[10]->lti->x[436] == 122 &&
    obj[10]->lti->x[442] == 107 &&
    obj[10]->lti->x[448] == 103 &&
    obj[10]->lti->x[468] == 122 &&
    obj[10]->lti->x[483] == 117 &&
    obj[10]->lti->x[487] == 100 &&
    obj[10]->lti->x[522] == 100 &&
    obj[10]->lti->x[524] == 106 &&
    obj[10]->lti->x[557] == 98 &&
    obj[10]->lti->x[578] == 121 &&
    obj[10]->lti->x[614] == 103 &&
    obj[10]->lti->x[669] == 108 &&
    obj[10]->lti->x[683] == 111 &&
    obj[10]->lti->x[743] == 101 &&
    obj[10]->lti->x[752] == 116 &&
    obj[10]->lti->x[781] == 99 &&
    obj[10]->lti->x[785] == 99 &&
    obj[10]->lti->x[793] == 117 &&
    obj[10]->lti->x[800] == 105 &&
    obj[10]->lti->x[885] == 103 &&
    obj[10]->lti->x[907] == 97 &&
    obj[10]->lti->x[920] == 101 &&
    obj[10]->lti->x[928] == 106 &&
    obj[10]->lti->x[933] == 111 &&
    obj[10]->lti->x[935] == 119 &&
    obj[10]->lti->x[999] == 122 &&
    obj[11]->lti->y[5] == 108 &&
    obj[11]->lti->y[27] == 107 &&
    obj[11]->lti->y[44] == 117 &&
    obj[11]->lti->y[45] == 121 &&
    obj[11]->lti->y[49] == 111 &&
    obj[11]->lti->y[87] == 119 &&
    obj[11]->lti->y[93] == 108 &&
    obj[11]->lti->y[126] == 112 &&
    obj[11]->lti->y[156] == 108 &&
    obj[11]->lti->y[184] == 114 &&
    obj[11]->lti->y[186] == 119 &&
    obj[11]->lti->y[197] == 116 &&
    obj[11]->lti->y[200] == 104 &&
    obj[11]->lti->y[220] == 116 &&
    obj[11]->lti->y[245] == 114 &&
    obj[11]->lti->y[263] == 116 &&
    obj[11]->lti->y[289] == 107 &&
    obj[11]->lti->y[343] == 118 &&
    obj[11]->lti->y[380] == 113 &&
    obj[11]->lti->y[406] == 98 &&
    obj[11]->lti->y[418] == 102 &&
    obj[11]->lti->y[424] == 100 &&
    obj[11]->lti->y[485] == 108 &&
    obj[11]->lti->y[509] == 112 &&
    obj[11]->lti->y[523] == 115 &&
    obj[11]->lti->y[532] == 97 &&
    obj[11]->lti->y[546] == 117 &&
    obj[11]->lti->y[556] == 98 &&
    obj[11]->lti->y[628] == 115 &&
    obj[11]->lti->y[645] == 114 &&
    obj[11]->lti->y[670] == 97 &&
    obj[11]->lti->y[695] == 115 &&
    obj[11]->lti->y[773] == 108 &&
    obj[11]->lti->y[791] == 115 &&
    obj[11]->lti->y[814] == 107 &&
    obj[11]->lti->y[843] == 112 &&
    obj[11]->lti->y[858] == 100 &&
    obj[11]->lti->y[872] == 118 &&
    obj[11]->lti->y[902] == 105 &&
    obj[11]->lti->y[906] == 108 &&
    obj[11]->lti->y[915] == 119 &&
    obj[11]->lti->y[919] == 104 &&
    obj[11]->lti->y[931] == 112 &&
    obj[11]->lti->y[939] == 110 &&
    obj[11]->lti->y[942] == 102 &&
    obj[11]->lti->y[945] == 111 &&
    obj[11]->lti->y[950] == 113 &&
    obj[11]->lti->y[999] == 107 &&
    obj[11]->lti->x[45] == 119 &&
    obj[11]->lti->x[50] == 105 &&
    obj[11]->lti->x[63] == 105 &&
    obj[11]->lti->x[70] == 102 &&
    obj[11]->lti->x[72] == 99 &&
    obj[11]->lti->x[88] == 100 &&
    obj[11]->lti->x[91] == 122 &&
    obj[11]->lti->x[103] == 103 &&
    obj[11]->lti->x[113] == 113 &&
    obj[11]->lti->x[121] == 119 &&
    obj[11]->lti->x[138] == 121 &&
    obj[11]->lti->x[162] == 119 &&
    obj[11]->lti->x[166] == 108 &&
    obj[11]->lti->x[247] == 106 &&
    obj[11]->lti->x[249] == 101 &&
    obj[11]->lti->x[261] == 104 &&
    obj[11]->lti->x[272] == 101 &&
    obj[11]->lti->x[278] == 115 &&
    obj[11]->lti->x[287] == 115 &&
    obj[11]->lti->x[298] == 115 &&
    obj[11]->lti->x[305] == 103 &&
    obj[11]->lti->x[312] == 101 &&
    obj[11]->lti->x[394] == 122 &&
    obj[11]->lti->x[444] == 108 &&
    obj[11]->lti->x[491] == 120 &&
    obj[11]->lti->x[505] == 107 &&
    obj[11]->lti->x[509] == 117 &&
    obj[11]->lti->x[546] == 99 &&
    obj[11]->lti->x[550] == 120 &&
    obj[11]->lti->x[552] == 111 &&
    obj[11]->lti->x[585] == 117 &&
    obj[11]->lti->x[605] == 107 &&
    obj[11]->lti->x[656] == 118 &&
    obj[11]->lti->x[668] == 121 &&
    obj[11]->lti->x[682] == 106 &&
    obj[11]->lti->x[703] == 115 &&
    obj[11]->lti->x[715] == 97 &&
    obj[11]->lti->x[732] == 109 &&
    obj[11]->lti->x[736] == 121 &&
    obj[11]->lti->x[748] == 97 &&
    obj[11]->lti->x[755] == 111 &&
    obj[11]->lti->x[762] == 104 &&
    obj[11]->lti->x[795] == 97 &&
    obj[11]->lti->x[836] == 106 &&
    obj[11]->lti->x[850] == 101 &&
    obj[11]->lti->x[864] == 110 &&
    obj[11]->lti->x[872] == 114 &&
    obj[11]->lti->x[890] == 122 &&
    obj[11]->lti->x[992] == 112 &&
    obj[12]->lti->y[19] == 113 &&
    obj[12]->lti->y[33] == 103 &&
    obj[12]->lti->y[39] == 117 &&
    obj[12]->lti->y[60] == 99 &&
    obj[12]->lti->y[75] == 103 &&
    obj[12]->lti->y[94] == 105 &&
    obj[12]->lti->y[99] == 122 &&
    obj[12]->lti->y[108] == 100 &&
    obj[12]->lti->y[110] == 113 &&
    obj[12]->lti->y[154] == 115 &&
    obj[12]->lti->y[163] == 119 &&
    obj[12]->lti->y[179] == 117 &&
    obj[12]->lti->y[193] == 100 &&
    obj[12]->lti->y[210] == 118 &&
    obj[12]->lti->y[246] == 113 &&
    obj[12]->lti->y[269] == 103 &&
    obj[12]->lti->y[289] == 112 &&
    obj[12]->lti->y[290] == 105 &&
    obj[12]->lti->y[341] == 100 &&
    obj[12]->lti->y[369] == 120 &&
    obj[12]->lti->y[388] == 99 &&
    obj[12]->lti->y[398] == 106 &&
    obj[12]->lti->y[399] == 118 &&
    obj[12]->lti->y[432] == 99 &&
    obj[12]->lti->y[435] == 107 &&
    obj[12]->lti->y[438] == 106 &&
    obj[12]->lti->y[454] == 113 &&
    obj[12]->lti->y[473] == 106 &&
    obj[12]->lti->y[512] == 102 &&
    obj[12]->lti->y[513] == 122 &&
    obj[12]->lti->y[521] == 105 &&
    obj[12]->lti->y[538] == 100 &&
    obj[12]->lti->y[547] == 108 &&
    obj[12]->lti->y[564] == 101 &&
    obj[12]->lti->y[581] == 112 &&
    obj[12]->lti->y[604] == 104 &&
    obj[12]->lti->y[610] == 115 &&
    obj[12]->lti->y[628] == 108 &&
    obj[12]->lti->y[648] == 99 &&
    obj[12]->lti->y[671] == 100 &&
    obj[12]->lti->y[692] == 105 &&
    obj[12]->lti->y[713] == 99 &&
    obj[12]->lti->y[716] == 105 &&
    obj[12]->lti->y[721] == 106 &&
    obj[12]->lti->y[742] == 97 &&
    obj[12]->lti->y[772] == 114 &&
    obj[12]->lti->y[773] == 108 &&
    obj[12]->lti->y[792] == 108 &&
    obj[12]->lti->y[822] == 110 &&
    obj[12]->lti->y[867] == 106 &&
    obj[12]->lti->y[872] == 109 &&
    obj[12]->lti->y[881] == 104 &&
    obj[12]->lti->y[886] == 113 &&
    obj[12]->lti->y[900] == 110 &&
    obj[12]->lti->y[935] == 107 &&
    obj[12]->lti->y[944] == 97 &&
    obj[12]->lti->y[960] == 119 &&
    obj[12]->lti->y[985] == 102 &&
    obj[12]->lti->x[64] == 118 &&
    obj[12]->lti->x[68] == 105 &&
    obj[12]->lti->x[72] == 115 &&
    obj[12]->lti->x[81] == 119 &&
    obj[12]->lti->x[91] == 104 &&
    obj[12]->lti->x[92] == 103 &&
    obj[12]->lti->x[205] == 104 &&
    obj[12]->lti->x[206] == 100 &&
    obj[12]->lti->x[207] == 111 &&
    obj[12]->lti->x[232] == 120 &&
    obj[12]->lti->x[244] == 109 &&
    obj[12]->lti->x[280] == 110 &&
    obj[12]->lti->x[345] == 109 &&
    obj[12]->lti->x[358] == 97 &&
    obj[12]->lti->x[380] == 101 &&
    obj[12]->lti->x[403] == 106 &&
    obj[12]->lti->x[423] == 102 &&
    obj[12]->lti->x[428] == 116 &&
    obj[12]->lti->x[435] == 122 &&
    obj[12]->lti->x[465] == 117 &&
    obj[12]->lti->x[487] == 119 &&
    obj[12]->lti->x[522] == 112 &&
    obj[12]->lti->x[533] == 97 &&
    obj[12]->lti->x[534] == 97 &&
    obj[12]->lti->x[544] == 119 &&
    obj[12]->lti->x[566] == 103 &&
    obj[12]->lti->x[570] == 119 &&
    obj[12]->lti->x[670] == 99 &&
    obj[12]->lti->x[698] == 103 &&
    obj[12]->lti->x[713] == 102 &&
    obj[12]->lti->x[731] == 115 &&
    obj[12]->lti->x[770] == 111 &&
    obj[12]->lti->x[801] == 112 &&
    obj[12]->lti->x[821] == 122 &&
    obj[12]->lti->x[853] == 99 &&
    obj[12]->lti->x[923] == 100 &&
    obj[12]->lti->x[939] == 117 &&
    obj[12]->lti->x[945] == 115 &&
    obj[12]->lti->x[971] == 111 &&
    obj[12]->lti->x[972] == 101 &&
    obj[12]->lti->x[975] == 114 &&
    obj[12]->lti->x[992] == 110 &&
    obj[13]->lti->y[38] == 113 &&
    obj[13]->lti->y[76] == 118 &&
    obj[13]->lti->y[87] == 97 &&
    obj[13]->lti->y[108] == 102 &&
    obj[13]->lti->y[142] == 112 &&
    obj[13]->lti->y[175] == 104 &&
    obj[13]->lti->y[210] == 110 &&
    obj[13]->lti->y[216] == 112 &&
    obj[13]->lti->y[247] == 99 &&
    obj[13]->lti->y[259] == 121 &&
    obj[13]->lti->y[261] == 97 &&
    obj[13]->lti->y[308] == 108 &&
    obj[13]->lti->y[359] == 107 &&
    obj[13]->lti->y[388] == 111 &&
    obj[13]->lti->y[393] == 119 &&
    obj[13]->lti->y[418] == 102 &&
    obj[13]->lti->y[430] == 117 &&
    obj[13]->lti->y[452] == 119 &&
    obj[13]->lti->y[454] == 107 &&
    obj[13]->lti->y[463] == 97 &&
    obj[13]->lti->y[466] == 111 &&
    obj[13]->lti->y[510] == 106 &&
    obj[13]->lti->y[534] == 119 &&
    obj[13]->lti->y[604] == 98 &&
    obj[13]->lti->y[629] == 111 &&
    obj[13]->lti->y[631] == 118 &&
    obj[13]->lti->y[643] == 100 &&
    obj[13]->lti->y[659] == 110 &&
    obj[13]->lti->y[703] == 116 &&
    obj[13]->lti->y[708] == 116 &&
    obj[13]->lti->y[729] == 110 &&
    obj[13]->lti->y[761] == 97 &&
    obj[13]->lti->y[767] == 108 &&
    obj[13]->lti->y[803] == 111 &&
    obj[13]->lti->y[829] == 108 &&
    obj[13]->lti->y[842] == 116 &&
    obj[13]->lti->y[844] == 121 &&
    obj[13]->lti->y[873] == 122 &&
    obj[13]->lti->y[931] == 97 &&
    obj[13]->lti->y[998] == 102 &&
    obj[13]->lti->x[2] == 101 &&
    obj[13]->lti->x[36] == 102 &&
    obj[13]->lti->x[46] == 105 &&
    obj[13]->lti->x[48] == 113 &&
    obj[13]->lti->x[68] == 112 &&
    obj[13]->lti->x[84] == 107 &&
    obj[13]->lti->x[88] == 121 &&
    obj[13]->lti->x[100] == 119 &&
    obj[13]->lti->x[115] == 106 &&
    obj[13]->lti->x[133] == 97 &&
    obj[13]->lti->x[159] == 99 &&
    obj[13]->lti->x[182] == 117 &&
    obj[13]->lti->x[207] == 102 &&
    obj[13]->lti->x[235] == 107 &&
    obj[13]->lti->x[283] == 119 &&
    obj[13]->lti->x[307] == 102 &&
    obj[13]->lti->x[310] == 119 &&
    obj[13]->lti->x[311] == 120 &&
    obj[13]->lti->x[341] == 120 &&
    obj[13]->lti->x[363] == 108 &&
    obj[13]->lti->x[390] == 106 &&
    obj[13]->lti->x[394] == 103 &&
    obj[13]->lti->x[421] == 99 &&
    obj[13]->lti->x[446] == 117 &&
    obj[13]->lti->x[456] == 110 &&
    obj[13]->lti->x[471] == 99 &&
    obj[13]->lti->x[480] == 97 &&
    obj[13]->lti->x[483] == 113 &&
    obj[13]->lti->x[541] == 120 &&
    obj[13]->lti->x[551] == 112 &&
    obj[13]->lti->x[591] == 100 &&
    obj[13]->lti->x[599] == 103 &&
    obj[13]->lti->x[601] == 99 &&
    obj[13]->lti->x[605] == 112 &&
    obj[13]->lti->x[619] == 115 &&
    obj[13]->lti->x[669] == 97 &&
    obj[13]->lti->x[692] == 111 &&
    obj[13]->lti->x[697] == 111 &&
    obj[13]->lti->x[714] == 111 &&
    obj[13]->lti->x[718] == 102 &&
    obj[13]->lti->x[721] == 111 &&
    obj[13]->lti->x[742] == 115 &&
    obj[13]->lti->x[744] == 102 &&
    obj[13]->lti->x[758] == 99 &&
    obj[13]->lti->x[766] == 119 &&
    obj[13]->lti->x[792] == 117 &&
    obj[13]->lti->x[827] == 101 &&
    obj[13]->lti->x[853] == 116 &&
    obj[13]->lti->x[860] == 108 &&
    obj[13]->lti->x[872] == 105 &&
    obj[13]->lti->x[889] == 104 &&
    obj[13]->lti->x[894] == 106 &&
    obj[13]->lti->x[895] == 119 &&
    obj[13]->lti->x[899] == 114 &&
    obj[13]->lti->x[927] == 98 &&
    obj[13]->lti->x[960] == 97 &&
    obj[13]->lti->x[974] == 104 &&
    obj[14]->lti->y[20] == 106 &&
    obj[14]->lti->y[32] == 122 &&
    obj[14]->lti->y[44] == 98 &&
    obj[14]->lti->y[56] == 98 &&
    obj[14]->lti->y[95] == 119 &&
    obj[14]->lti->y[97] == 121 &&
    obj[14]->lti->y[100] == 105 &&
    obj[14]->lti->y[161] == 97 &&
    obj[14]->lti->y[170] == 117 &&
    obj[14]->lti->y[178] == 107 &&
    obj[14]->lti->y[186] == 114 &&
    obj[14]->lti->y[207] == 114 &&
    obj[14]->lti->y[209] == 108 &&
    obj[14]->lti->y[212] == 119 &&
    obj[14]->lti->y[240] == 111 &&
    obj[14]->lti->y[251] == 105 &&
    obj[14]->lti->y[253] == 102 &&
    obj[14]->lti->y[271] == 97 &&
    obj[14]->lti->y[283] == 112 &&
    obj[14]->lti->y[305] == 98 &&
    obj[14]->lti->y[409] == 111 &&
    obj[14]->lti->y[443] == 98 &&
    obj[14]->lti->y[473] == 114 &&
    obj[14]->lti->y[498] == 109 &&
    obj[14]->lti->y[533] == 103 &&
    obj[14]->lti->y[534] == 108 &&
    obj[14]->lti->y[547] == 106 &&
    obj[14]->lti->y[558] == 112 &&
    obj[14]->lti->y[577] == 117 &&
    obj[14]->lti->y[586] == 102 &&
    obj[14]->lti->y[587] == 122 &&
    obj[14]->lti->y[636] == 101 &&
    obj[14]->lti->y[649] == 109 &&
    obj[14]->lti->y[657] == 121 &&
    obj[14]->lti->y[659] == 116 &&
    obj[14]->lti->y[672] == 114 &&
    obj[14]->lti->y[675] == 105 &&
    obj[14]->lti->y[707] == 122 &&
    obj[14]->lti->y[731] == 104 &&
    obj[14]->lti->y[737] == 99 &&
    obj[14]->lti->y[750] == 98 &&
    obj[14]->lti->y[782] == 115 &&
    obj[14]->lti->y[795] == 101 &&
    obj[14]->lti->y[805] == 115 &&
    obj[14]->lti->y[810] == 99 &&
    obj[14]->lti->y[825] == 99 &&
    obj[14]->lti->y[862] == 112 &&
    obj[14]->lti->y[865] == 120 &&
    obj[14]->lti->y[874] == 103 &&
    obj[14]->lti->y[878] == 111 &&
    obj[14]->lti->y[939] == 119 &&
    obj[14]->lti->y[956] == 97 &&
    obj[14]->lti->y[959] == 117 &&
    obj[14]->lti->x[6] == 104 &&
    obj[14]->lti->x[10] == 115 &&
    obj[14]->lti->x[36] == 108 &&
    obj[14]->lti->x[110] == 113 &&
    obj[14]->lti->x[133] == 120 &&
    obj[14]->lti->x[189] == 116 &&
    obj[14]->lti->x[198] == 113 &&
    obj[14]->lti->x[221] == 116 &&
    obj[14]->lti->x[229] == 102 &&
    obj[14]->lti->x[231] == 117 &&
    obj[14]->lti->x[259] == 101 &&
    obj[14]->lti->x[305] == 97 &&
    obj[14]->lti->x[337] == 98 &&
    obj[14]->lti->x[345] == 117 &&
    obj[14]->lti->x[355] == 122 &&
    obj[14]->lti->x[375] == 113 &&
    obj[14]->lti->x[385] == 113 &&
    obj[14]->lti->x[411] == 106 &&
    obj[14]->lti->x[419] == 104 &&
    obj[14]->lti->x[421] == 101 &&
    obj[14]->lti->x[426] == 100 &&
    obj[14]->lti->x[447] == 116 &&
    obj[14]->lti->x[462] == 97 &&
    obj[14]->lti->x[483] == 112 &&
    obj[14]->lti->x[497] == 120 &&
    obj[14]->lti->x[554] == 115 &&
    obj[14]->lti->x[560] == 111 &&
    obj[14]->lti->x[636] == 111 &&
    obj[14]->lti->x[639] == 101 &&
    obj[14]->lti->x[667] == 109 &&
    obj[14]->lti->x[708] == 99 &&
    obj[14]->lti->x[722] == 97 &&
    obj[14]->lti->x[772] == 109 &&
    obj[14]->lti->x[775] == 101 &&
    obj[14]->lti->x[780] == 105 &&
    obj[14]->lti->x[802] == 112 &&
    obj[14]->lti->x[803] == 102 &&
    obj[14]->lti->x[824] == 111 &&
    obj[14]->lti->x[869] == 104 &&
    obj[14]->lti->x[880] == 113 &&
    obj[14]->lti->x[905] == 115 &&
    obj[14]->lti->x[927] == 120 &&
    obj[14]->lti->x[934] == 100 &&
    obj[14]->lti->x[935] == 111 &&
    obj[14]->lti->x[944] == 97 &&
    obj[16]->lti->y[8] == 118 &&
    obj[16]->lti->y[19] == 100 &&
    obj[16]->lti->y[91] == 114 &&
    obj[16]->lti->y[105] == 104 &&
    obj[16]->lti->y[126] == 104 &&
    obj[16]->lti->y[127] == 115 &&
    obj[16]->lti->y[169] == 104 &&
    obj[16]->lti->y[253] == 120 &&
    obj[16]->lti->y[262] == 120 &&
    obj[16]->lti->y[264] == 118 &&
    obj[16]->lti->y[272] == 109 &&
    obj[16]->lti->y[285] == 99 &&
    obj[16]->lti->y[327] == 110 &&
    obj[16]->lti->y[394] == 102 &&
    obj[16]->lti->y[412] == 97 &&
    obj[16]->lti->y[419] == 111 &&
    obj[16]->lti->y[425] == 100 &&
    obj[16]->lti->y[432] == 104 &&
    obj[16]->lti->y[447] == 102 &&
    obj[16]->lti->y[456] == 105 &&
    obj[16]->lti->y[458] == 102 &&
    obj[16]->lti->y[462] == 109 &&
    obj[16]->lti->y[491] == 116 &&
    obj[16]->lti->y[492] == 100 &&
    obj[16]->lti->y[506] == 122 &&
    obj[16]->lti->y[541] == 99 &&
    obj[16]->lti->y[565] == 104 &&
    obj[16]->lti->y[587] == 113 &&
    obj[16]->lti->y[590] == 115 &&
    obj[16]->lti->y[594] == 115 &&
    obj[16]->lti->y[632] == 105 &&
    obj[16]->lti->y[640] == 107 &&
    obj[16]->lti->y[651] == 117 &&
    obj[16]->lti->y[653] == 98 &&
    obj[16]->lti->y[673] == 111 &&
    obj[16]->lti->y[765] == 121 &&
    obj[16]->lti->y[798] == 111 &&
    obj[16]->lti->y[823] == 116 &&
    obj[16]->lti->y[832] == 97 &&
    obj[16]->lti->y[835] == 97 &&
    obj[16]->lti->y[903] == 99 &&
    obj[16]->lti->y[931] == 113 &&
    obj[16]->lti->y[936] == 107 &&
    obj[16]->lti->y[967] == 122 &&
    obj[16]->lti->x[22] == 122 &&
    obj[16]->lti->x[23] == 105 &&
    obj[16]->lti->x[48] == 104 &&
    obj[16]->lti->x[57] == 100 &&
    obj[16]->lti->x[58] == 111 &&
    obj[16]->lti->x[59] == 106 &&
    obj[16]->lti->x[71] == 103 &&
    obj[16]->lti->x[158] == 106 &&
    obj[16]->lti->x[170] == 120 &&
    obj[16]->lti->x[174] == 100 &&
    obj[16]->lti->x[230] == 120 &&
    obj[16]->lti->x[249] == 119 &&
    obj[16]->lti->x[278] == 106 &&
    obj[16]->lti->x[310] == 109 &&
    obj[16]->lti->x[334] == 104 &&
    obj[16]->lti->x[349] == 102 &&
    obj[16]->lti->x[353] == 107 &&
    obj[16]->lti->x[371] == 122 &&
    obj[16]->lti->x[378] == 122 &&
    obj[16]->lti->x[384] == 120 &&
    obj[16]->lti->x[396] == 107 &&
    obj[16]->lti->x[408] == 102 &&
    obj[16]->lti->x[413] == 109 &&
    obj[16]->lti->x[419] == 120 &&
    obj[16]->lti->x[423] == 97 &&
    obj[16]->lti->x[430] == 109 &&
    obj[16]->lti->x[444] == 113 &&
    obj[16]->lti->x[496] == 101 &&
    obj[16]->lti->x[509] == 117 &&
    obj[16]->lti->x[520] == 102 &&
    obj[16]->lti->x[523] == 107 &&
    obj[16]->lti->x[535] == 120 &&
    obj[16]->lti->x[544] == 99 &&
    obj[16]->lti->x[546] == 120 &&
    obj[16]->lti->x[558] == 119 &&
    obj[16]->lti->x[615] == 106 &&
    obj[16]->lti->x[624] == 121 &&
    obj[16]->lti->x[626] == 106 &&
    obj[16]->lti->x[635] == 105 &&
    obj[16]->lti->x[643] == 107 &&
    obj[16]->lti->x[657] == 119 &&
    obj[16]->lti->x[713] == 109 &&
    obj[16]->lti->x[737] == 99 &&
    obj[16]->lti->x[740] == 117 &&
    obj[16]->lti->x[784] == 107 &&
    obj[16]->lti->x[796] == 102 &&
    obj[16]->lti->x[797] == 109 &&
    obj[16]->lti->x[806] == 122 &&
    obj[16]->lti->x[818] == 115 &&
    obj[16]->lti->x[843] == 117 &&
    obj[16]->lti->x[850] == 104 &&
    obj[16]->lti->x[852] == 100 &&
    obj[16]->lti->x[906] == 119 &&
    obj[16]->lti->x[920] == 97 &&
    obj[17]->lti->y[24] == 112 &&
    obj[17]->lti->y[44] == 116 &&
    obj[17]->lti->y[47] == 110 &&
    obj[17]->lti->y[67] == 101 &&
    obj[17]->lti->y[88] == 118 &&
    obj[17]->lti->y[111] == 110 &&
    obj[17]->lti->y[155] == 113 &&
    obj[17]->lti->y[169] == 105 &&
    obj[17]->lti->y[170] == 118 &&
    obj[17]->lti->y[201] == 109 &&
    obj[17]->lti->y[219] == 121 &&
    obj[17]->lti->y[273] == 103 &&
    obj[17]->lti->y[304] == 99 &&
    obj[17]->lti->y[337] == 115 &&
    obj[17]->lti->y[347] == 107 &&
    obj[17]->lti->y[371] == 117 &&
    obj[17]->lti->y[376] == 111 &&
    obj[17]->lti->y[404] == 107 &&
    obj[17]->lti->y[423] == 106 &&
    obj[17]->lti->y[437] == 118 &&
    obj[17]->lti->y[439] == 98 &&
    obj[17]->lti->y[443] == 109 &&
    obj[17]->lti->y[450] == 103 &&
    obj[17]->lti->y[453] == 112 &&
    obj[17]->lti->y[462] == 120 &&
    obj[17]->lti->y[463] == 122 &&
    obj[17]->lti->y[482] == 97 &&
    obj[17]->lti->y[496] == 103 &&
    obj[17]->lti->y[541] == 100 &&
    obj[17]->lti->y[584] == 101 &&
    obj[17]->lti->y[588] == 108 &&
    obj[17]->lti->y[602] == 117 &&
    obj[17]->lti->y[614] == 119 &&
    obj[17]->lti->y[620] == 97 &&
    obj[17]->lti->y[687] == 119 &&
    obj[17]->lti->y[688] == 105 &&
    obj[17]->lti->y[694] == 106 &&
    obj[17]->lti->y[710] == 99 &&
    obj[17]->lti->y[715] == 98 &&
    obj[17]->lti->y[755] == 102 &&
    obj[17]->lti->y[775] == 106 &&
    obj[17]->lti->y[781] == 119 &&
    obj[17]->lti->y[900] == 115 &&
    obj[17]->lti->y[908] == 107 &&
    obj[17]->lti->y[934] == 109 &&
    obj[17]->lti->y[956] == 103 &&
    obj[17]->lti->y[973] == 105 &&
    obj[17]->lti->y[986] == 109 &&
    obj[17]->lti->x[10] == 112 &&
    obj[17]->lti->x[17] == 112 &&
    obj[17]->lti->x[27] == 121 &&
    obj[17]->lti->x[39] == 112 &&
    obj[17]->lti->x[100] == 114 &&
    obj[17]->lti->x[101] == 117 &&
    obj[17]->lti->x[112] == 122 &&
    obj[17]->lti->x[113] == 120 &&
    obj[17]->lti->x[125] == 112 &&
    obj[17]->lti->x[205] == 105 &&
    obj[17]->lti->x[235] == 110 &&
    obj[17]->lti->x[258] == 106 &&
    obj[17]->lti->x[270] == 112 &&
    obj[17]->lti->x[303] == 104 &&
    obj[17]->lti->x[313] == 118 &&
    obj[17]->lti->x[320] == 102 &&
    obj[17]->lti->x[368] == 102 &&
    obj[17]->lti->x[373] == 114 &&
    obj[17]->lti->x[382] == 120 &&
    obj[17]->lti->x[387] == 122 &&
    obj[17]->lti->x[414] == 109 &&
    obj[17]->lti->x[440] == 112 &&
    obj[17]->lti->x[448] == 113 &&
    obj[17]->lti->x[528] == 110 &&
    obj[17]->lti->x[558] == 112 &&
    obj[17]->lti->x[567] == 116 &&
    obj[17]->lti->x[570] == 107 &&
    obj[17]->lti->x[584] == 121 &&
    obj[17]->lti->x[587] == 106 &&
    obj[17]->lti->x[599] == 102 &&
    obj[17]->lti->x[609] == 101 &&
    obj[17]->lti->x[612] == 122 &&
    obj[17]->lti->x[633] == 118 &&
    obj[17]->lti->x[637] == 120 &&
    obj[17]->lti->x[639] == 100 &&
    obj[17]->lti->x[666] == 101 &&
    obj[17]->lti->x[670] == 121 &&
    obj[17]->lti->x[692] == 113 &&
    obj[17]->lti->x[739] == 110 &&
    obj[17]->lti->x[786] == 107 &&
    obj[17]->lti->x[820] == 122 &&
    obj[17]->lti->x[863] == 111 &&
    obj[17]->lti->x[880] == 103 &&
    obj[17]->lti->x[881] == 114 &&
    obj[17]->lti->x[892] == 98 &&
    obj[17]->lti->x[898] == 102 &&
    obj[17]->lti->x[940] == 117 &&
    obj[17]->lti->x[993] == 119 &&
    obj[17]->lti->x[996] == 100 &&
    obj[17]->lti->x[999] == 116 &&
    obj[19]->lti->y[38] == 111 &&
    obj[19]->lti->y[81] == 104 &&
    obj[19]->lti->y[92] == 117 &&
    obj[19]->lti->y[179] == 115 &&
    obj[19]->lti->y[183] == 99 &&
    obj[19]->lti->y[230] == 112 &&
    obj[19]->lti->y[233] == 117 &&
    obj[19]->lti->y[237] == 107 &&
    obj[19]->lti->y[258] == 105 &&
    obj[19]->lti->y[279] == 106 &&
    obj[19]->lti->y[320] == 105 &&
    obj[19]->lti->y[331] == 100 &&
    obj[19]->lti->y[338] == 122 &&
    obj[19]->lti->y[345] == 118 &&
    obj[19]->lti->y[370] == 98 &&
    obj[19]->lti->y[390] == 101 &&
    obj[19]->lti->y[433] == 114 &&
    obj[19]->lti->y[440] == 115 &&
    obj[19]->lti->y[448] == 121 &&
    obj[19]->lti->y[478] == 110 &&
    obj[19]->lti->y[509] == 116 &&
    obj[19]->lti->y[515] == 105 &&
    obj[19]->lti->y[524] == 106 &&
    obj[19]->lti->y[533] == 117 &&
    obj[19]->lti->y[555] == 108 &&
    obj[19]->lti->y[563] == 106 &&
    obj[19]->lti->y[568] == 108 &&
    obj[19]->lti->y[589] == 116 &&
    obj[19]->lti->y[601] == 114 &&
    obj[19]->lti->y[615] == 112 &&
    obj[19]->lti->y[616] == 105 &&
    obj[19]->lti->y[624] == 102 &&
    obj[19]->lti->y[663] == 98 &&
    obj[19]->lti->y[676] == 120 &&
    obj[19]->lti->y[682] == 103 &&
    obj[19]->lti->y[700] == 119 &&
    obj[19]->lti->y[745] == 109 &&
    obj[19]->lti->y[767] == 114 &&
    obj[19]->lti->y[801] == 104 &&
    obj[19]->lti->y[814] == 120 &&
    obj[19]->lti->y[818] == 121 &&
    obj[19]->lti->y[823] == 104 &&
    obj[19]->lti->y[825] == 102 &&
    obj[19]->lti->y[889] == 110 &&
    obj[19]->lti->y[898] == 102 &&
    obj[19]->lti->y[904] == 100 &&
    obj[19]->lti->y[950] == 98 &&
    obj[19]->lti->x[7] == 119 &&
    obj[19]->lti->x[17] == 105 &&
    obj[19]->lti->x[18] == 122 &&
    obj[19]->lti->x[68] == 100 &&
    obj[19]->lti->x[71] == 100 &&
    obj[19]->lti->x[72] == 99 &&
    obj[19]->lti->x[85] == 113 &&
    obj[19]->lti->x[87] == 108 &&
    obj[19]->lti->x[102] == 106 &&
    obj[19]->lti->x[115] == 105 &&
    obj[19]->lti->x[118] == 98 &&
    obj[19]->lti->x[190] == 117 &&
    obj[19]->lti->x[213] == 121 &&
    obj[19]->lti->x[222] == 118 &&
    obj[19]->lti->x[241] == 120 &&
    obj[19]->lti->x[263] == 112 &&
    obj[19]->lti->x[278] == 103 &&
    obj[19]->lti->x[300] == 105 &&
    obj[19]->lti->x[343] == 100 &&
    obj[19]->lti->x[349] == 98 &&
    obj[19]->lti->x[362] == 107 &&
    obj[19]->lti->x[409] == 98 &&
    obj[19]->lti->x[415] == 115 &&
    obj[19]->lti->x[434] == 112 &&
    obj[19]->lti->x[435] == 110 &&
    obj[19]->lti->x[451] == 120 &&
    obj[19]->lti->x[519] == 118 &&
    obj[19]->lti->x[523] == 100 &&
    obj[19]->lti->x[527] == 105 &&
    obj[19]->lti->x[546] == 103 &&
    obj[19]->lti->x[565] == 107 &&
    obj[19]->lti->x[571] == 111 &&
    obj[19]->lti->x[591] == 116 &&
    obj[19]->lti->x[593] == 110 &&
    obj[19]->lti->x[628] == 108 &&
    obj[19]->lti->x[645] == 107 &&
    obj[19]->lti->x[650] == 99 &&
    obj[19]->lti->x[652] == 114 &&
    obj[19]->lti->x[663] == 113 &&
    obj[19]->lti->x[694] == 108 &&
    obj[19]->lti->x[804] == 111 &&
    obj[19]->lti->x[848] == 110 &&
    obj[19]->lti->x[872] == 103 &&
    obj[19]->lti->x[882] == 99 &&
    obj[19]->lti->x[903] == 111 &&
    obj[19]->lti->x[924] == 121 &&
    obj[19]->lti->x[943] == 98 &&
    obj[19]->lti->x[960] == 122 &&
    obj[19]->lti->x[993] == 112)
        printf("*** pruned branch taken");
}

void branchNotPruned(struct HighType** obj) {
    if(obj[2]->lti->y[6] == 109 ||
    obj[2]->lti->y[31] == 119 ||
    obj[2]->lti->y[63] == 99 ||
    obj[2]->lti->y[72] == 100 ||
    obj[2]->lti->y[76] == 109 ||
    obj[2]->lti->y[109] == 108 ||
    obj[2]->lti->y[147] == 122 ||
    obj[2]->lti->y[189] == 103 ||
    obj[2]->lti->y[198] == 108 ||
    obj[2]->lti->y[212] == 120 ||
    obj[2]->lti->y[237] == 110 ||
    obj[2]->lti->y[249] == 113 ||
    obj[2]->lti->y[279] == 109 ||
    obj[2]->lti->y[280] == 99 ||
    obj[2]->lti->y[330] == 107 ||
    obj[2]->lti->y[337] == 99 ||
    obj[2]->lti->y[341] == 120 ||
    obj[2]->lti->y[375] == 110 ||
    obj[2]->lti->y[378] == 109 ||
    obj[2]->lti->y[387] == 116 ||
    obj[2]->lti->y[410] == 119 ||
    obj[2]->lti->y[437] == 104 ||
    obj[2]->lti->y[515] == 100 ||
    obj[2]->lti->y[520] == 108 ||
    obj[2]->lti->y[540] == 121 ||
    obj[2]->lti->y[577] == 106 ||
    obj[2]->lti->y[670] == 118 ||
    obj[2]->lti->y[683] == 101 ||
    obj[2]->lti->y[695] == 100 ||
    obj[2]->lti->y[698] == 108 ||
    obj[2]->lti->y[739] == 110 ||
    obj[2]->lti->y[752] == 110 ||
    obj[2]->lti->y[758] == 104 ||
    obj[2]->lti->y[784] == 118 ||
    obj[2]->lti->y[800] == 103 ||
    obj[2]->lti->y[805] == 100 ||
    obj[2]->lti->y[841] == 100 ||
    obj[2]->lti->y[843] == 107 ||
    obj[2]->lti->y[847] == 107 ||
    obj[2]->lti->y[869] == 115 ||
    obj[2]->lti->y[870] == 103 ||
    obj[2]->lti->y[876] == 108 ||
    obj[2]->lti->y[879] == 111 ||
    obj[2]->lti->y[910] == 97 ||
    obj[2]->lti->y[927] == 119 ||
    obj[2]->lti->y[945] == 99 ||
    obj[2]->lti->x[10] == 106 ||
    obj[2]->lti->x[23] == 110 ||
    obj[2]->lti->x[29] == 104 ||
    obj[2]->lti->x[38] == 101 ||
    obj[2]->lti->x[42] == 107 ||
    obj[2]->lti->x[91] == 106 ||
    obj[2]->lti->x[93] == 100 ||
    obj[2]->lti->x[126] == 122 ||
    obj[2]->lti->x[130] == 108 ||
    obj[2]->lti->x[133] == 112 ||
    obj[2]->lti->x[137] == 108 ||
    obj[2]->lti->x[165] == 116 ||
    obj[2]->lti->x[172] == 105 ||
    obj[2]->lti->x[214] == 119 ||
    obj[2]->lti->x[216] == 113 ||
    obj[2]->lti->x[323] == 121 ||
    obj[2]->lti->x[332] == 108 ||
    obj[2]->lti->x[378] == 116 ||
    obj[2]->lti->x[392] == 108 ||
    obj[2]->lti->x[393] == 108 ||
    obj[2]->lti->x[445] == 119 ||
    obj[2]->lti->x[452] == 112 ||
    obj[2]->lti->x[453] == 113 ||
    obj[2]->lti->x[488] == 108 ||
    obj[2]->lti->x[495] == 98 ||
    obj[2]->lti->x[550] == 112 ||
    obj[2]->lti->x[551] == 100 ||
    obj[2]->lti->x[571] == 112 ||
    obj[2]->lti->x[577] == 106 ||
    obj[2]->lti->x[590] == 108 ||
    obj[2]->lti->x[604] == 113 ||
    obj[2]->lti->x[607] == 115 ||
    obj[2]->lti->x[609] == 105 ||
    obj[2]->lti->x[672] == 104 ||
    obj[2]->lti->x[713] == 113 ||
    obj[2]->lti->x[735] == 115 ||
    obj[2]->lti->x[748] == 107 ||
    obj[2]->lti->x[771] == 121 ||
    obj[2]->lti->x[806] == 115 ||
    obj[2]->lti->x[807] == 97 ||
    obj[2]->lti->x[855] == 116 ||
    obj[2]->lti->x[881] == 114 ||
    obj[2]->lti->x[897] == 105 ||
    obj[2]->lti->x[920] == 110 ||
    obj[2]->lti->x[939] == 118 ||
    obj[2]->lti->x[959] == 122 ||
    obj[2]->lti->x[960] == 109 ||
    obj[2]->lti->x[968] == 105 ||
    obj[2]->lti->x[975] == 116 ||
    obj[2]->lti->x[986] == 111 ||
    obj[4]->lti->y[38] == 109 ||
    obj[4]->lti->y[63] == 104 ||
    obj[4]->lti->y[67] == 113 ||
    obj[4]->lti->y[72] == 106 ||
    obj[4]->lti->y[87] == 118 ||
    obj[4]->lti->y[106] == 116 ||
    obj[4]->lti->y[121] == 118 ||
    obj[4]->lti->y[129] == 107 ||
    obj[4]->lti->y[135] == 100 ||
    obj[4]->lti->y[157] == 97 ||
    obj[4]->lti->y[172] == 106 ||
    obj[4]->lti->y[188] == 117 ||
    obj[4]->lti->y[235] == 120 ||
    obj[4]->lti->y[236] == 122 ||
    obj[4]->lti->y[264] == 106 ||
    obj[4]->lti->y[267] == 114 ||
    obj[4]->lti->y[272] == 99 ||
    obj[4]->lti->y[320] == 109 ||
    obj[4]->lti->y[332] == 111 ||
    obj[4]->lti->y[416] == 97 ||
    obj[4]->lti->y[419] == 98 ||
    obj[4]->lti->y[428] == 119 ||
    obj[4]->lti->y[438] == 116 ||
    obj[4]->lti->y[495] == 113 ||
    obj[4]->lti->y[497] == 118 ||
    obj[4]->lti->y[529] == 98 ||
    obj[4]->lti->y[542] == 116 ||
    obj[4]->lti->y[551] == 112 ||
    obj[4]->lti->y[600] == 103 ||
    obj[4]->lti->y[604] == 107 ||
    obj[4]->lti->y[612] == 118 ||
    obj[4]->lti->y[643] == 121 ||
    obj[4]->lti->y[648] == 120 ||
    obj[4]->lti->y[655] == 105 ||
    obj[4]->lti->y[683] == 113 ||
    obj[4]->lti->y[689] == 102 ||
    obj[4]->lti->y[729] == 113 ||
    obj[4]->lti->y[741] == 122 ||
    obj[4]->lti->y[747] == 118 ||
    obj[4]->lti->y[763] == 110 ||
    obj[4]->lti->y[771] == 105 ||
    obj[4]->lti->y[787] == 107 ||
    obj[4]->lti->y[812] == 105 ||
    obj[4]->lti->y[822] == 108 ||
    obj[4]->lti->y[877] == 121 ||
    obj[4]->lti->y[884] == 107 ||
    obj[4]->lti->y[895] == 98 ||
    obj[4]->lti->y[913] == 110 ||
    obj[4]->lti->y[933] == 106 ||
    obj[4]->lti->y[935] == 106 ||
    obj[4]->lti->y[943] == 113 ||
    obj[4]->lti->y[951] == 104 ||
    obj[4]->lti->y[974] == 117 ||
    obj[4]->lti->x[20] == 110 ||
    obj[4]->lti->x[59] == 112 ||
    obj[4]->lti->x[63] == 108 ||
    obj[4]->lti->x[113] == 102 ||
    obj[4]->lti->x[121] == 101 ||
    obj[4]->lti->x[141] == 120 ||
    obj[4]->lti->x[164] == 121 ||
    obj[4]->lti->x[177] == 104 ||
    obj[4]->lti->x[181] == 112 ||
    obj[4]->lti->x[193] == 116 ||
    obj[4]->lti->x[230] == 119 ||
    obj[4]->lti->x[300] == 119 ||
    obj[4]->lti->x[301] == 113 ||
    obj[4]->lti->x[313] == 110 ||
    obj[4]->lti->x[321] == 104 ||
    obj[4]->lti->x[332] == 110 ||
    obj[4]->lti->x[347] == 120 ||
    obj[4]->lti->x[352] == 113 ||
    obj[4]->lti->x[360] == 107 ||
    obj[4]->lti->x[371] == 98 ||
    obj[4]->lti->x[393] == 101 ||
    obj[4]->lti->x[398] == 106 ||
    obj[4]->lti->x[422] == 110 ||
    obj[4]->lti->x[441] == 100 ||
    obj[4]->lti->x[455] == 116 ||
    obj[4]->lti->x[457] == 114 ||
    obj[4]->lti->x[468] == 99 ||
    obj[4]->lti->x[472] == 113 ||
    obj[4]->lti->x[536] == 120 ||
    obj[4]->lti->x[584] == 100 ||
    obj[4]->lti->x[599] == 106 ||
    obj[4]->lti->x[617] == 110 ||
    obj[4]->lti->x[709] == 110 ||
    obj[4]->lti->x[724] == 100 ||
    obj[4]->lti->x[770] == 100 ||
    obj[4]->lti->x[799] == 109 ||
    obj[4]->lti->x[801] == 114 ||
    obj[4]->lti->x[836] == 103 ||
    obj[4]->lti->x[854] == 104 ||
    obj[4]->lti->x[862] == 122 ||
    obj[4]->lti->x[868] == 112 ||
    obj[4]->lti->x[878] == 120 ||
    obj[4]->lti->x[896] == 100 ||
    obj[4]->lti->x[913] == 106 ||
    obj[4]->lti->x[941] == 101 ||
    obj[15]->lti->y[18] == 121 ||
    obj[15]->lti->y[31] == 114 ||
    obj[15]->lti->y[43] == 110 ||
    obj[15]->lti->y[140] == 119 ||
    obj[15]->lti->y[213] == 108 ||
    obj[15]->lti->y[217] == 111 ||
    obj[15]->lti->y[224] == 98 ||
    obj[15]->lti->y[241] == 113 ||
    obj[15]->lti->y[247] == 98 ||
    obj[15]->lti->y[257] == 122 ||
    obj[15]->lti->y[278] == 118 ||
    obj[15]->lti->y[281] == 108 ||
    obj[15]->lti->y[290] == 98 ||
    obj[15]->lti->y[312] == 114 ||
    obj[15]->lti->y[318] == 106 ||
    obj[15]->lti->y[321] == 115 ||
    obj[15]->lti->y[347] == 121 ||
    obj[15]->lti->y[373] == 105 ||
    obj[15]->lti->y[383] == 117 ||
    obj[15]->lti->y[395] == 116 ||
    obj[15]->lti->y[400] == 112 ||
    obj[15]->lti->y[414] == 115 ||
    obj[15]->lti->y[420] == 117 ||
    obj[15]->lti->y[435] == 118 ||
    obj[15]->lti->y[506] == 115 ||
    obj[15]->lti->y[522] == 112 ||
    obj[15]->lti->y[527] == 111 ||
    obj[15]->lti->y[540] == 119 ||
    obj[15]->lti->y[543] == 110 ||
    obj[15]->lti->y[572] == 100 ||
    obj[15]->lti->y[586] == 110 ||
    obj[15]->lti->y[614] == 97 ||
    obj[15]->lti->y[639] == 115 ||
    obj[15]->lti->y[660] == 121 ||
    obj[15]->lti->y[665] == 114 ||
    obj[15]->lti->y[674] == 97 ||
    obj[15]->lti->y[707] == 102 ||
    obj[15]->lti->y[727] == 112 ||
    obj[15]->lti->y[740] == 109 ||
    obj[15]->lti->y[747] == 109 ||
    obj[15]->lti->y[755] == 98 ||
    obj[15]->lti->y[764] == 122 ||
    obj[15]->lti->y[823] == 100 ||
    obj[15]->lti->y[826] == 117 ||
    obj[15]->lti->y[828] == 109 ||
    obj[15]->lti->y[838] == 121 ||
    obj[15]->lti->y[842] == 116 ||
    obj[15]->lti->y[870] == 105 ||
    obj[15]->lti->y[877] == 112 ||
    obj[15]->lti->y[935] == 106 ||
    obj[15]->lti->y[946] == 105 ||
    obj[15]->lti->x[46] == 105 ||
    obj[15]->lti->x[98] == 113 ||
    obj[15]->lti->x[100] == 106 ||
    obj[15]->lti->x[118] == 113 ||
    obj[15]->lti->x[129] == 117 ||
    obj[15]->lti->x[144] == 116 ||
    obj[15]->lti->x[173] == 116 ||
    obj[15]->lti->x[179] == 116 ||
    obj[15]->lti->x[236] == 117 ||
    obj[15]->lti->x[247] == 108 ||
    obj[15]->lti->x[302] == 121 ||
    obj[15]->lti->x[324] == 112 ||
    obj[15]->lti->x[338] == 103 ||
    obj[15]->lti->x[356] == 113 ||
    obj[15]->lti->x[369] == 117 ||
    obj[15]->lti->x[372] == 111 ||
    obj[15]->lti->x[379] == 100 ||
    obj[15]->lti->x[386] == 105 ||
    obj[15]->lti->x[421] == 106 ||
    obj[15]->lti->x[432] == 121 ||
    obj[15]->lti->x[437] == 111 ||
    obj[15]->lti->x[477] == 113 ||
    obj[15]->lti->x[512] == 97 ||
    obj[15]->lti->x[516] == 106 ||
    obj[15]->lti->x[555] == 104 ||
    obj[15]->lti->x[559] == 121 ||
    obj[15]->lti->x[607] == 105 ||
    obj[15]->lti->x[661] == 106 ||
    obj[15]->lti->x[665] == 109 ||
    obj[15]->lti->x[691] == 97 ||
    obj[15]->lti->x[704] == 112 ||
    obj[15]->lti->x[705] == 122 ||
    obj[15]->lti->x[714] == 107 ||
    obj[15]->lti->x[725] == 97 ||
    obj[15]->lti->x[749] == 101 ||
    obj[15]->lti->x[765] == 116 ||
    obj[15]->lti->x[773] == 115 ||
    obj[15]->lti->x[777] == 106 ||
    obj[15]->lti->x[836] == 100 ||
    obj[15]->lti->x[885] == 119 ||
    obj[15]->lti->x[907] == 100 ||
    obj[15]->lti->x[927] == 102 ||
    obj[15]->lti->x[945] == 119 ||
    obj[15]->lti->x[978] == 120 ||
    obj[18]->lti->y[31] == 109 ||
    obj[18]->lti->y[46] == 102 ||
    obj[18]->lti->y[79] == 120 ||
    obj[18]->lti->y[97] == 108 ||
    obj[18]->lti->y[129] == 115 ||
    obj[18]->lti->y[133] == 98 ||
    obj[18]->lti->y[146] == 122 ||
    obj[18]->lti->y[148] == 114 ||
    obj[18]->lti->y[179] == 117 ||
    obj[18]->lti->y[197] == 104 ||
    obj[18]->lti->y[224] == 103 ||
    obj[18]->lti->y[225] == 105 ||
    obj[18]->lti->y[253] == 111 ||
    obj[18]->lti->y[309] == 110 ||
    obj[18]->lti->y[439] == 108 ||
    obj[18]->lti->y[460] == 108 ||
    obj[18]->lti->y[471] == 112 ||
    obj[18]->lti->y[522] == 110 ||
    obj[18]->lti->y[549] == 121 ||
    obj[18]->lti->y[568] == 106 ||
    obj[18]->lti->y[610] == 111 ||
    obj[18]->lti->y[627] == 108 ||
    obj[18]->lti->y[657] == 106 ||
    obj[18]->lti->y[673] == 109 ||
    obj[18]->lti->y[731] == 113 ||
    obj[18]->lti->y[756] == 97 ||
    obj[18]->lti->y[777] == 117 ||
    obj[18]->lti->y[798] == 116 ||
    obj[18]->lti->y[816] == 118 ||
    obj[18]->lti->y[824] == 105 ||
    obj[18]->lti->y[837] == 104 ||
    obj[18]->lti->y[841] == 119 ||
    obj[18]->lti->y[901] == 105 ||
    obj[18]->lti->y[920] == 99 ||
    obj[18]->lti->y[952] == 107 ||
    obj[18]->lti->y[960] == 106 ||
    obj[18]->lti->y[963] == 120 ||
    obj[18]->lti->y[968] == 99 ||
    obj[18]->lti->y[991] == 111 ||
    obj[18]->lti->x[5] == 100 ||
    obj[18]->lti->x[15] == 114 ||
    obj[18]->lti->x[16] == 119 ||
    obj[18]->lti->x[46] == 103 ||
    obj[18]->lti->x[49] == 120 ||
    obj[18]->lti->x[58] == 111 ||
    obj[18]->lti->x[73] == 118 ||
    obj[18]->lti->x[79] == 113 ||
    obj[18]->lti->x[96] == 104 ||
    obj[18]->lti->x[99] == 98 ||
    obj[18]->lti->x[114] == 111 ||
    obj[18]->lti->x[119] == 97 ||
    obj[18]->lti->x[139] == 97 ||
    obj[18]->lti->x[150] == 111 ||
    obj[18]->lti->x[165] == 102 ||
    obj[18]->lti->x[174] == 111 ||
    obj[18]->lti->x[198] == 116 ||
    obj[18]->lti->x[213] == 111 ||
    obj[18]->lti->x[228] == 115 ||
    obj[18]->lti->x[255] == 117 ||
    obj[18]->lti->x[305] == 104 ||
    obj[18]->lti->x[312] == 109 ||
    obj[18]->lti->x[341] == 111 ||
    obj[18]->lti->x[373] == 103 ||
    obj[18]->lti->x[378] == 105 ||
    obj[18]->lti->x[399] == 102 ||
    obj[18]->lti->x[406] == 122 ||
    obj[18]->lti->x[413] == 111 ||
    obj[18]->lti->x[432] == 100 ||
    obj[18]->lti->x[441] == 97 ||
    obj[18]->lti->x[444] == 101 ||
    obj[18]->lti->x[486] == 121 ||
    obj[18]->lti->x[503] == 97 ||
    obj[18]->lti->x[524] == 113 ||
    obj[18]->lti->x[525] == 111 ||
    obj[18]->lti->x[537] == 120 ||
    obj[18]->lti->x[546] == 120 ||
    obj[18]->lti->x[551] == 117 ||
    obj[18]->lti->x[554] == 117 ||
    obj[18]->lti->x[570] == 107 ||
    obj[18]->lti->x[600] == 119 ||
    obj[18]->lti->x[627] == 114 ||
    obj[18]->lti->x[631] == 103 ||
    obj[18]->lti->x[681] == 98 ||
    obj[18]->lti->x[684] == 120 ||
    obj[18]->lti->x[706] == 110 ||
    obj[18]->lti->x[713] == 117 ||
    obj[18]->lti->x[732] == 110 ||
    obj[18]->lti->x[735] == 110 ||
    obj[18]->lti->x[746] == 114 ||
    obj[18]->lti->x[792] == 106 ||
    obj[18]->lti->x[846] == 101 ||
    obj[18]->lti->x[862] == 113 ||
    obj[18]->lti->x[900] == 111 ||
    obj[18]->lti->x[922] == 104 ||
    obj[18]->lti->x[959] == 116 ||
    obj[18]->lti->x[984] == 111)
        printf("*** unpruned branch taken");
}

int main() {
	struct HighType** ht = malloc(20 * sizeof(struct HighType*));
	doMallocs(ht);
	initialize(ht);
	branchPruned(ht);
	branchNotPruned(ht);
}
