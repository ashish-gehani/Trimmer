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

struct HighType * createHighType() {
	struct HighType * ht = malloc(sizeof(struct HighType));
	ht->lts = malloc(sizeof(struct LowTypeString));
	ht->lti = malloc(sizeof(struct LowTypeInt));
	ht->lti->x = malloc(1000 * sizeof(int));
	ht->lti->y = malloc(1000 * sizeof(int));
	ht->lts->x = malloc(1000 * sizeof(char));
	ht->lts->y = malloc(1000 * sizeof(char));
	return ht;
}

extern void externalFunc(struct HighType * ht);

void doMallocs(struct HighType** obj) {
    obj[0] = createHighType();
    obj[1] = createHighType();
    obj[2] = createHighType();
    obj[6] = createHighType();
    obj[7] = createHighType();
}
void initialize(struct HighType** obj) {
    memcpy(&obj[0]->lts->y[565], "kamselhwtp", 10);
    obj[0]->lti->y[643] = 118;
    memcpy(&obj[0]->lts->x[555], "dafcdkpdejuojwkxwxcfeqetcxxtuurbawudidaigrgaaxm", 47);
    memcpy(&obj[0]->lts->y[926], "lurompjzjbdyahmvgcbkruvdfhvkugyi", 32);
    obj[0]->lti->y[386] = 105;
    obj[0]->lti->x[164] = 103;
    obj[0]->lti->y[584] = 102;
    memcpy(&obj[0]->lts->x[531], "kdejtioukhe", 11);
    obj[0]->lti->x[238] = 104;
    memcpy(&obj[0]->lts->y[72], "hspfhexgzgbzwibzmqzxkrnnodevcyxmuxqrsgmcuqnemdtm", 48);
    memcpy(&obj[1]->lts->y[109], "a", 1);
    obj[1]->lti->y[813] = 121;
    memcpy(&obj[1]->lts->x[77], "fvzzuqwxfjkdtshhpjmvrfabyyvnamnfrazatptnyyudcqbdy", 49);
    obj[1]->lti->x[765] = 107;
    obj[1]->lti->y[712] = 102;
    memcpy(&obj[1]->lts->x[738], "sdaobydzkcwsyfkebetsdqlovhggaslnfihbezjywbzuj", 45);
    obj[1]->lti->x[200] = 109;
    memcpy(&obj[1]->lts->x[383], "omfoxqjibdtrvrpdsayqxunlcmhouankfa", 34);
    obj[1]->lti->y[613] = 107;
    obj[1]->lti->x[298] = 122;
    memcpy(&obj[2]->lts->y[327], "wmsiedwjettbvuqadnjphkunegghtdpowcg", 35);
    memcpy(&obj[2]->lts->y[304], "rkrlgawfofksiflhbtitntewlkibdfyqzahvc", 37);
    externalFunc(obj[2]);
    memcpy(&obj[2]->lts->x[172], "mlfboffrolnuhpmq", 16);
    memcpy(&obj[2]->lts->y[308], "oxkwrcocmmyjjbscaxpxe", 21);
    obj[2]->lti->x[217] = 111;
    obj[2]->lti->y[271] = 111;
    obj[2]->lti->x[106] = 101;
    memcpy(&obj[2]->lts->x[618], "onqfpwrqbckvavpvkxgfz", 21);
    memcpy(&obj[2]->lts->x[855], "phkyvkkgjodnnsfuczrzovjemcqbz", 29);
    memcpy(&obj[6]->lts->x[648], "bkvylzbsra", 10);
    memcpy(&obj[6]->lts->x[624], "ncberwwrpzbvozqqhfyunnl", 23);
    obj[6]->lti->y[450] = 120;
    obj[6]->lti->y[542] = 97;
    obj[6]->lti->x[522] = 105;
    memcpy(&obj[6]->lts->x[5], "rrmimkqgz", 9);
    obj[6]->lti->x[999] = 117;
    memcpy(&obj[6]->lts->x[727], "xmvqzmlx", 8);
    memcpy(&obj[6]->lts->y[331], "nywvdzb", 7);
    obj[6]->lti->y[466] = 101;
    memcpy(&obj[7]->lts->y[521], "kmjwnerjixncjmkacndmufaam", 25);
    memcpy(&obj[7]->lts->y[387], "vtkccrhlgyuxlcgzibytdccvhbgndfgxxakyjcvivljrcnum", 48);
    obj[7]->lti->y[644] = 120;
    memcpy(&obj[7]->lts->x[453], "piofqnekzjskgtlrgk", 18);
    obj[7]->lti->x[28] = 110;
    memcpy(&obj[7]->lts->x[230], "ppm", 3);
    memcpy(&obj[7]->lts->x[267], "bwoyokzoakhxykbrnfswloddo", 25);
    memcpy(&obj[7]->lts->x[609], "telzmbevqvpwbsokflukpokjrjngg", 29);
    memcpy(&obj[7]->lts->y[451], "tiqhexiyyfivjqisavbhu", 21);
    memcpy(&obj[7]->lts->x[532], "owgboycjlpddojpizxndabqpcshneuondsutlkondkccezdaz", 49);
}
void branchPruned(struct HighType** obj) {
    if(obj[0]->lts->y[72] == 'h' &&
    obj[0]->lts->y[73] == 's' &&
    obj[0]->lts->y[74] == 'p' &&
    obj[0]->lts->y[75] == 'f' &&
    obj[0]->lts->y[76] == 'h' &&
    obj[0]->lts->y[77] == 'e' &&
    obj[0]->lts->y[78] == 'x' &&
    obj[0]->lts->y[79] == 'g' &&
    obj[0]->lts->y[80] == 'z' &&
    obj[0]->lts->y[81] == 'g' &&
    obj[0]->lts->y[82] == 'b' &&
    obj[0]->lts->y[83] == 'z' &&
    obj[0]->lts->y[84] == 'w' &&
    obj[0]->lts->y[85] == 'i' &&
    obj[0]->lts->y[86] == 'b' &&
    obj[0]->lts->y[87] == 'z' &&
    obj[0]->lts->y[88] == 'm' &&
    obj[0]->lts->y[89] == 'q' &&
    obj[0]->lts->y[90] == 'z' &&
    obj[0]->lts->y[91] == 'x' &&
    obj[0]->lts->y[92] == 'k' &&
    obj[0]->lts->y[93] == 'r' &&
    obj[0]->lts->y[94] == 'n' &&
    obj[0]->lts->y[95] == 'n' &&
    obj[0]->lts->y[96] == 'o' &&
    obj[0]->lts->y[97] == 'd' &&
    obj[0]->lts->y[98] == 'e' &&
    obj[0]->lts->y[99] == 'v' &&
    obj[0]->lts->y[100] == 'c' &&
    obj[0]->lts->y[101] == 'y' &&
    obj[0]->lts->y[102] == 'x' &&
    obj[0]->lts->y[103] == 'm' &&
    obj[0]->lts->y[104] == 'u' &&
    obj[0]->lts->y[105] == 'x' &&
    obj[0]->lts->y[106] == 'q' &&
    obj[0]->lts->y[107] == 'r' &&
    obj[0]->lts->y[108] == 's' &&
    obj[0]->lts->y[109] == 'g' &&
    obj[0]->lts->y[110] == 'm' &&
    obj[0]->lts->y[111] == 'c' &&
    obj[0]->lts->y[112] == 'u' &&
    obj[0]->lts->y[113] == 'q' &&
    obj[0]->lts->y[114] == 'n' &&
    obj[0]->lts->y[115] == 'e' &&
    obj[0]->lts->y[116] == 'm' &&
    obj[0]->lts->y[117] == 'd' &&
    obj[0]->lts->y[118] == 't' &&
    obj[0]->lts->y[119] == 'm' &&
    obj[0]->lts->y[565] == 'k' &&
    obj[0]->lts->y[566] == 'a' &&
    obj[0]->lts->y[567] == 'm' &&
    obj[0]->lts->y[568] == 's' &&
    obj[0]->lts->y[569] == 'e' &&
    obj[0]->lts->y[570] == 'l' &&
    obj[0]->lts->y[571] == 'h' &&
    obj[0]->lts->y[572] == 'w' &&
    obj[0]->lts->y[573] == 't' &&
    obj[0]->lts->y[574] == 'p' &&
    obj[0]->lts->y[926] == 'l' &&
    obj[0]->lts->y[927] == 'u' &&
    obj[0]->lts->y[928] == 'r' &&
    obj[0]->lts->y[929] == 'o' &&
    obj[0]->lts->y[930] == 'm' &&
    obj[0]->lts->y[931] == 'p' &&
    obj[0]->lts->y[932] == 'j' &&
    obj[0]->lts->y[933] == 'z' &&
    obj[0]->lts->y[934] == 'j' &&
    obj[0]->lts->y[935] == 'b' &&
    obj[0]->lts->y[936] == 'd' &&
    obj[0]->lts->y[937] == 'y' &&
    obj[0]->lts->y[938] == 'a' &&
    obj[0]->lts->y[939] == 'h' &&
    obj[0]->lts->y[940] == 'm' &&
    obj[0]->lts->y[941] == 'v' &&
    obj[0]->lts->y[942] == 'g' &&
    obj[0]->lts->y[943] == 'c' &&
    obj[0]->lts->y[944] == 'b' &&
    obj[0]->lts->y[945] == 'k' &&
    obj[0]->lts->y[946] == 'r' &&
    obj[0]->lts->y[947] == 'u' &&
    obj[0]->lts->y[948] == 'v' &&
    obj[0]->lts->y[949] == 'd' &&
    obj[0]->lts->y[950] == 'f' &&
    obj[0]->lts->y[951] == 'h' &&
    obj[0]->lts->y[952] == 'v' &&
    obj[0]->lts->y[953] == 'k' &&
    obj[0]->lts->y[954] == 'u' &&
    obj[0]->lts->y[955] == 'g' &&
    obj[0]->lts->y[956] == 'y' &&
    obj[0]->lts->y[957] == 'i' &&
    obj[0]->lts->x[531] == 'k' &&
    obj[0]->lts->x[532] == 'd' &&
    obj[0]->lts->x[533] == 'e' &&
    obj[0]->lts->x[534] == 'j' &&
    obj[0]->lts->x[535] == 't' &&
    obj[0]->lts->x[536] == 'i' &&
    obj[0]->lts->x[537] == 'o' &&
    obj[0]->lts->x[538] == 'u' &&
    obj[0]->lts->x[539] == 'k' &&
    obj[0]->lts->x[540] == 'h' &&
    obj[0]->lts->x[541] == 'e' &&
    obj[0]->lts->x[555] == 'd' &&
    obj[0]->lts->x[556] == 'a' &&
    obj[0]->lts->x[557] == 'f' &&
    obj[0]->lts->x[558] == 'c' &&
    obj[0]->lts->x[559] == 'd' &&
    obj[0]->lts->x[560] == 'k' &&
    obj[0]->lts->x[561] == 'p' &&
    obj[0]->lts->x[562] == 'd' &&
    obj[0]->lts->x[563] == 'e' &&
    obj[0]->lts->x[564] == 'j' &&
    obj[0]->lts->x[565] == 'u' &&
    obj[0]->lts->x[566] == 'o' &&
    obj[0]->lts->x[567] == 'j' &&
    obj[0]->lts->x[568] == 'w' &&
    obj[0]->lts->x[569] == 'k' &&
    obj[0]->lts->x[570] == 'x' &&
    obj[0]->lts->x[571] == 'w' &&
    obj[0]->lts->x[572] == 'x' &&
    obj[0]->lts->x[573] == 'c' &&
    obj[0]->lts->x[574] == 'f' &&
    obj[0]->lts->x[575] == 'e' &&
    obj[0]->lts->x[576] == 'q' &&
    obj[0]->lts->x[577] == 'e' &&
    obj[0]->lts->x[578] == 't' &&
    obj[0]->lts->x[579] == 'c' &&
    obj[0]->lts->x[580] == 'x' &&
    obj[0]->lts->x[581] == 'x' &&
    obj[0]->lts->x[582] == 't' &&
    obj[0]->lts->x[583] == 'u' &&
    obj[0]->lts->x[584] == 'u' &&
    obj[0]->lts->x[585] == 'r' &&
    obj[0]->lts->x[586] == 'b' &&
    obj[0]->lts->x[587] == 'a' &&
    obj[0]->lts->x[588] == 'w' &&
    obj[0]->lts->x[589] == 'u' &&
    obj[0]->lts->x[590] == 'd' &&
    obj[0]->lts->x[591] == 'i' &&
    obj[0]->lts->x[592] == 'd' &&
    obj[0]->lts->x[593] == 'a' &&
    obj[0]->lts->x[594] == 'i' &&
    obj[0]->lts->x[595] == 'g' &&
    obj[0]->lts->x[596] == 'r' &&
    obj[0]->lts->x[597] == 'g' &&
    obj[0]->lts->x[598] == 'a' &&
    obj[0]->lts->x[599] == 'a' &&
    obj[0]->lts->x[600] == 'x' &&
    obj[0]->lts->x[601] == 'm' &&
    obj[0]->lti->y[386] == 105 &&
    obj[0]->lti->y[584] == 102 &&
    obj[0]->lti->y[643] == 118 &&
    obj[0]->lti->x[164] == 103 &&
    obj[0]->lti->x[238] == 104 &&
    !strcmp(&obj[0]->lts->y[565], "kamselhwtp") &&
    !strcmp(&obj[0]->lts->y[926], "lurompjzjbdyahmvgcbkruvdfhvkugyi") &&
    !strcmp(&obj[0]->lts->y[72], "hspfhexgzgbzwibzmqzxkrnnodevcyxmuxqrsgmcuqnemdtm") &&
    !strcmp(&obj[0]->lts->x[555], "dafcdkpdejuojwkxwxcfeqetcxxtuurbawudidaigrgaaxm") &&
    !strcmp(&obj[0]->lts->x[531], "kdejtioukhe") &&
    obj[1]->lts->y[109] == 'a' &&
    obj[1]->lts->x[77] == 'f' &&
    obj[1]->lts->x[78] == 'v' &&
    obj[1]->lts->x[79] == 'z' &&
    obj[1]->lts->x[80] == 'z' &&
    obj[1]->lts->x[81] == 'u' &&
    obj[1]->lts->x[82] == 'q' &&
    obj[1]->lts->x[83] == 'w' &&
    obj[1]->lts->x[84] == 'x' &&
    obj[1]->lts->x[85] == 'f' &&
    obj[1]->lts->x[86] == 'j' &&
    obj[1]->lts->x[87] == 'k' &&
    obj[1]->lts->x[88] == 'd' &&
    obj[1]->lts->x[89] == 't' &&
    obj[1]->lts->x[90] == 's' &&
    obj[1]->lts->x[91] == 'h' &&
    obj[1]->lts->x[92] == 'h' &&
    obj[1]->lts->x[93] == 'p' &&
    obj[1]->lts->x[94] == 'j' &&
    obj[1]->lts->x[95] == 'm' &&
    obj[1]->lts->x[96] == 'v' &&
    obj[1]->lts->x[97] == 'r' &&
    obj[1]->lts->x[98] == 'f' &&
    obj[1]->lts->x[99] == 'a' &&
    obj[1]->lts->x[100] == 'b' &&
    obj[1]->lts->x[101] == 'y' &&
    obj[1]->lts->x[102] == 'y' &&
    obj[1]->lts->x[103] == 'v' &&
    obj[1]->lts->x[104] == 'n' &&
    obj[1]->lts->x[105] == 'a' &&
    obj[1]->lts->x[106] == 'm' &&
    obj[1]->lts->x[107] == 'n' &&
    obj[1]->lts->x[108] == 'f' &&
    obj[1]->lts->x[109] == 'r' &&
    obj[1]->lts->x[110] == 'a' &&
    obj[1]->lts->x[111] == 'z' &&
    obj[1]->lts->x[112] == 'a' &&
    obj[1]->lts->x[113] == 't' &&
    obj[1]->lts->x[114] == 'p' &&
    obj[1]->lts->x[115] == 't' &&
    obj[1]->lts->x[116] == 'n' &&
    obj[1]->lts->x[117] == 'y' &&
    obj[1]->lts->x[118] == 'y' &&
    obj[1]->lts->x[119] == 'u' &&
    obj[1]->lts->x[120] == 'd' &&
    obj[1]->lts->x[121] == 'c' &&
    obj[1]->lts->x[122] == 'q' &&
    obj[1]->lts->x[123] == 'b' &&
    obj[1]->lts->x[124] == 'd' &&
    obj[1]->lts->x[125] == 'y' &&
    obj[1]->lts->x[383] == 'o' &&
    obj[1]->lts->x[384] == 'm' &&
    obj[1]->lts->x[385] == 'f' &&
    obj[1]->lts->x[386] == 'o' &&
    obj[1]->lts->x[387] == 'x' &&
    obj[1]->lts->x[388] == 'q' &&
    obj[1]->lts->x[389] == 'j' &&
    obj[1]->lts->x[390] == 'i' &&
    obj[1]->lts->x[391] == 'b' &&
    obj[1]->lts->x[392] == 'd' &&
    obj[1]->lts->x[393] == 't' &&
    obj[1]->lts->x[394] == 'r' &&
    obj[1]->lts->x[395] == 'v' &&
    obj[1]->lts->x[396] == 'r' &&
    obj[1]->lts->x[397] == 'p' &&
    obj[1]->lts->x[398] == 'd' &&
    obj[1]->lts->x[399] == 's' &&
    obj[1]->lts->x[400] == 'a' &&
    obj[1]->lts->x[401] == 'y' &&
    obj[1]->lts->x[402] == 'q' &&
    obj[1]->lts->x[403] == 'x' &&
    obj[1]->lts->x[404] == 'u' &&
    obj[1]->lts->x[405] == 'n' &&
    obj[1]->lts->x[406] == 'l' &&
    obj[1]->lts->x[407] == 'c' &&
    obj[1]->lts->x[408] == 'm' &&
    obj[1]->lts->x[409] == 'h' &&
    obj[1]->lts->x[410] == 'o' &&
    obj[1]->lts->x[411] == 'u' &&
    obj[1]->lts->x[412] == 'a' &&
    obj[1]->lts->x[413] == 'n' &&
    obj[1]->lts->x[414] == 'k' &&
    obj[1]->lts->x[415] == 'f' &&
    obj[1]->lts->x[416] == 'a' &&
    obj[1]->lts->x[738] == 's' &&
    obj[1]->lts->x[739] == 'd' &&
    obj[1]->lts->x[740] == 'a' &&
    obj[1]->lts->x[741] == 'o' &&
    obj[1]->lts->x[742] == 'b' &&
    obj[1]->lts->x[743] == 'y' &&
    obj[1]->lts->x[744] == 'd' &&
    obj[1]->lts->x[745] == 'z' &&
    obj[1]->lts->x[746] == 'k' &&
    obj[1]->lts->x[747] == 'c' &&
    obj[1]->lts->x[748] == 'w' &&
    obj[1]->lts->x[749] == 's' &&
    obj[1]->lts->x[750] == 'y' &&
    obj[1]->lts->x[751] == 'f' &&
    obj[1]->lts->x[752] == 'k' &&
    obj[1]->lts->x[753] == 'e' &&
    obj[1]->lts->x[754] == 'b' &&
    obj[1]->lts->x[755] == 'e' &&
    obj[1]->lts->x[756] == 't' &&
    obj[1]->lts->x[757] == 's' &&
    obj[1]->lts->x[758] == 'd' &&
    obj[1]->lts->x[759] == 'q' &&
    obj[1]->lts->x[760] == 'l' &&
    obj[1]->lts->x[761] == 'o' &&
    obj[1]->lts->x[762] == 'v' &&
    obj[1]->lts->x[763] == 'h' &&
    obj[1]->lts->x[764] == 'g' &&
    obj[1]->lts->x[765] == 'g' &&
    obj[1]->lts->x[766] == 'a' &&
    obj[1]->lts->x[767] == 's' &&
    obj[1]->lts->x[768] == 'l' &&
    obj[1]->lts->x[769] == 'n' &&
    obj[1]->lts->x[770] == 'f' &&
    obj[1]->lts->x[771] == 'i' &&
    obj[1]->lts->x[772] == 'h' &&
    obj[1]->lts->x[773] == 'b' &&
    obj[1]->lts->x[774] == 'e' &&
    obj[1]->lts->x[775] == 'z' &&
    obj[1]->lts->x[776] == 'j' &&
    obj[1]->lts->x[777] == 'y' &&
    obj[1]->lts->x[778] == 'w' &&
    obj[1]->lts->x[779] == 'b' &&
    obj[1]->lts->x[780] == 'z' &&
    obj[1]->lts->x[781] == 'u' &&
    obj[1]->lts->x[782] == 'j' &&
    obj[1]->lti->y[613] == 107 &&
    obj[1]->lti->y[712] == 102 &&
    obj[1]->lti->y[813] == 121 &&
    obj[1]->lti->x[200] == 109 &&
    obj[1]->lti->x[298] == 122 &&
    obj[1]->lti->x[765] == 107 &&
    !strcmp(&obj[1]->lts->y[109], "a") &&
    !strcmp(&obj[1]->lts->x[77], "fvzzuqwxfjkdtshhpjmvrfabyyvnamnfrazatptnyyudcqbdy") &&
    !strcmp(&obj[1]->lts->x[738], "sdaobydzkcwsyfkebetsdqlovhggaslnfihbezjywbzuj") &&
    !strcmp(&obj[1]->lts->x[383], "omfoxqjibdtrvrpdsayqxunlcmhouankfa") &&
    obj[3] == NULL &&
    obj[4] == NULL &&
    obj[5] == NULL &&
    obj[6]->lts->y[331] == 'n' &&
    obj[6]->lts->y[332] == 'y' &&
    obj[6]->lts->y[333] == 'w' &&
    obj[6]->lts->y[334] == 'v' &&
    obj[6]->lts->y[335] == 'd' &&
    obj[6]->lts->y[336] == 'z' &&
    obj[6]->lts->y[337] == 'b' &&
    obj[6]->lts->x[5] == 'r' &&
    obj[6]->lts->x[6] == 'r' &&
    obj[6]->lts->x[7] == 'm' &&
    obj[6]->lts->x[8] == 'i' &&
    obj[6]->lts->x[9] == 'm' &&
    obj[6]->lts->x[10] == 'k' &&
    obj[6]->lts->x[11] == 'q' &&
    obj[6]->lts->x[12] == 'g' &&
    obj[6]->lts->x[13] == 'z' &&
    obj[6]->lts->x[624] == 'n' &&
    obj[6]->lts->x[625] == 'c' &&
    obj[6]->lts->x[626] == 'b' &&
    obj[6]->lts->x[627] == 'e' &&
    obj[6]->lts->x[628] == 'r' &&
    obj[6]->lts->x[629] == 'w' &&
    obj[6]->lts->x[630] == 'w' &&
    obj[6]->lts->x[631] == 'r' &&
    obj[6]->lts->x[632] == 'p' &&
    obj[6]->lts->x[633] == 'z' &&
    obj[6]->lts->x[634] == 'b' &&
    obj[6]->lts->x[635] == 'v' &&
    obj[6]->lts->x[636] == 'o' &&
    obj[6]->lts->x[637] == 'z' &&
    obj[6]->lts->x[638] == 'q' &&
    obj[6]->lts->x[639] == 'q' &&
    obj[6]->lts->x[640] == 'h' &&
    obj[6]->lts->x[641] == 'f' &&
    obj[6]->lts->x[642] == 'y' &&
    obj[6]->lts->x[643] == 'u' &&
    obj[6]->lts->x[644] == 'n' &&
    obj[6]->lts->x[645] == 'n' &&
    obj[6]->lts->x[646] == 'l' &&
    obj[6]->lts->x[648] == 'b' &&
    obj[6]->lts->x[649] == 'k' &&
    obj[6]->lts->x[650] == 'v' &&
    obj[6]->lts->x[651] == 'y' &&
    obj[6]->lts->x[652] == 'l' &&
    obj[6]->lts->x[653] == 'z' &&
    obj[6]->lts->x[654] == 'b' &&
    obj[6]->lts->x[655] == 's' &&
    obj[6]->lts->x[656] == 'r' &&
    obj[6]->lts->x[657] == 'a' &&
    obj[6]->lts->x[727] == 'x' &&
    obj[6]->lts->x[728] == 'm' &&
    obj[6]->lts->x[729] == 'v' &&
    obj[6]->lts->x[730] == 'q' &&
    obj[6]->lts->x[731] == 'z' &&
    obj[6]->lts->x[732] == 'm' &&
    obj[6]->lts->x[733] == 'l' &&
    obj[6]->lts->x[734] == 'x' &&
    obj[6]->lti->y[450] == 120 &&
    obj[6]->lti->y[466] == 101 &&
    obj[6]->lti->y[542] == 97 &&
    obj[6]->lti->x[522] == 105 &&
    obj[6]->lti->x[999] == 117 &&
    !strcmp(&obj[6]->lts->y[331], "nywvdzb") &&
    !strcmp(&obj[6]->lts->x[648], "bkvylzbsra") &&
    !strcmp(&obj[6]->lts->x[624], "ncberwwrpzbvozqqhfyunnl") &&
    !strcmp(&obj[6]->lts->x[5], "rrmimkqgz") &&
    !strcmp(&obj[6]->lts->x[727], "xmvqzmlx") &&
    obj[7]->lts->y[387] == 'v' &&
    obj[7]->lts->y[388] == 't' &&
    obj[7]->lts->y[389] == 'k' &&
    obj[7]->lts->y[390] == 'c' &&
    obj[7]->lts->y[391] == 'c' &&
    obj[7]->lts->y[392] == 'r' &&
    obj[7]->lts->y[393] == 'h' &&
    obj[7]->lts->y[394] == 'l' &&
    obj[7]->lts->y[395] == 'g' &&
    obj[7]->lts->y[396] == 'y' &&
    obj[7]->lts->y[397] == 'u' &&
    obj[7]->lts->y[398] == 'x' &&
    obj[7]->lts->y[399] == 'l' &&
    obj[7]->lts->y[400] == 'c' &&
    obj[7]->lts->y[401] == 'g' &&
    obj[7]->lts->y[402] == 'z' &&
    obj[7]->lts->y[403] == 'i' &&
    obj[7]->lts->y[404] == 'b' &&
    obj[7]->lts->y[405] == 'y' &&
    obj[7]->lts->y[406] == 't' &&
    obj[7]->lts->y[407] == 'd' &&
    obj[7]->lts->y[408] == 'c' &&
    obj[7]->lts->y[409] == 'c' &&
    obj[7]->lts->y[410] == 'v' &&
    obj[7]->lts->y[411] == 'h' &&
    obj[7]->lts->y[412] == 'b' &&
    obj[7]->lts->y[413] == 'g' &&
    obj[7]->lts->y[414] == 'n' &&
    obj[7]->lts->y[415] == 'd' &&
    obj[7]->lts->y[416] == 'f' &&
    obj[7]->lts->y[417] == 'g' &&
    obj[7]->lts->y[418] == 'x' &&
    obj[7]->lts->y[419] == 'x' &&
    obj[7]->lts->y[420] == 'a' &&
    obj[7]->lts->y[421] == 'k' &&
    obj[7]->lts->y[422] == 'y' &&
    obj[7]->lts->y[423] == 'j' &&
    obj[7]->lts->y[424] == 'c' &&
    obj[7]->lts->y[425] == 'v' &&
    obj[7]->lts->y[426] == 'i' &&
    obj[7]->lts->y[427] == 'v' &&
    obj[7]->lts->y[428] == 'l' &&
    obj[7]->lts->y[429] == 'j' &&
    obj[7]->lts->y[430] == 'r' &&
    obj[7]->lts->y[431] == 'c' &&
    obj[7]->lts->y[432] == 'n' &&
    obj[7]->lts->y[433] == 'u' &&
    obj[7]->lts->y[434] == 'm' &&
    obj[7]->lts->y[451] == 't' &&
    obj[7]->lts->y[452] == 'i' &&
    obj[7]->lts->y[453] == 'q' &&
    obj[7]->lts->y[454] == 'h' &&
    obj[7]->lts->y[455] == 'e' &&
    obj[7]->lts->y[456] == 'x' &&
    obj[7]->lts->y[457] == 'i' &&
    obj[7]->lts->y[458] == 'y' &&
    obj[7]->lts->y[459] == 'y' &&
    obj[7]->lts->y[460] == 'f' &&
    obj[7]->lts->y[461] == 'i' &&
    obj[7]->lts->y[462] == 'v' &&
    obj[7]->lts->y[463] == 'j' &&
    obj[7]->lts->y[464] == 'q' &&
    obj[7]->lts->y[465] == 'i' &&
    obj[7]->lts->y[466] == 's' &&
    obj[7]->lts->y[467] == 'a' &&
    obj[7]->lts->y[468] == 'v' &&
    obj[7]->lts->y[469] == 'b' &&
    obj[7]->lts->y[470] == 'h' &&
    obj[7]->lts->y[471] == 'u' &&
    obj[7]->lts->y[521] == 'k' &&
    obj[7]->lts->y[522] == 'm' &&
    obj[7]->lts->y[523] == 'j' &&
    obj[7]->lts->y[524] == 'w' &&
    obj[7]->lts->y[525] == 'n' &&
    obj[7]->lts->y[526] == 'e' &&
    obj[7]->lts->y[527] == 'r' &&
    obj[7]->lts->y[528] == 'j' &&
    obj[7]->lts->y[529] == 'i' &&
    obj[7]->lts->y[530] == 'x' &&
    obj[7]->lts->y[531] == 'n' &&
    obj[7]->lts->y[532] == 'c' &&
    obj[7]->lts->y[533] == 'j' &&
    obj[7]->lts->y[534] == 'm' &&
    obj[7]->lts->y[535] == 'k' &&
    obj[7]->lts->y[536] == 'a' &&
    obj[7]->lts->y[537] == 'c' &&
    obj[7]->lts->y[538] == 'n' &&
    obj[7]->lts->y[539] == 'd' &&
    obj[7]->lts->y[540] == 'm' &&
    obj[7]->lts->y[541] == 'u' &&
    obj[7]->lts->y[542] == 'f' &&
    obj[7]->lts->y[543] == 'a' &&
    obj[7]->lts->y[544] == 'a' &&
    obj[7]->lts->y[545] == 'm' &&
    obj[7]->lts->x[230] == 'p' &&
    obj[7]->lts->x[231] == 'p' &&
    obj[7]->lts->x[232] == 'm' &&
    obj[7]->lts->x[267] == 'b' &&
    obj[7]->lts->x[268] == 'w' &&
    obj[7]->lts->x[269] == 'o' &&
    obj[7]->lts->x[270] == 'y' &&
    obj[7]->lts->x[271] == 'o' &&
    obj[7]->lts->x[272] == 'k' &&
    obj[7]->lts->x[273] == 'z' &&
    obj[7]->lts->x[274] == 'o' &&
    obj[7]->lts->x[275] == 'a' &&
    obj[7]->lts->x[276] == 'k' &&
    obj[7]->lts->x[277] == 'h' &&
    obj[7]->lts->x[278] == 'x' &&
    obj[7]->lts->x[279] == 'y' &&
    obj[7]->lts->x[280] == 'k' &&
    obj[7]->lts->x[281] == 'b' &&
    obj[7]->lts->x[282] == 'r' &&
    obj[7]->lts->x[283] == 'n' &&
    obj[7]->lts->x[284] == 'f' &&
    obj[7]->lts->x[285] == 's' &&
    obj[7]->lts->x[286] == 'w' &&
    obj[7]->lts->x[287] == 'l' &&
    obj[7]->lts->x[288] == 'o' &&
    obj[7]->lts->x[289] == 'd' &&
    obj[7]->lts->x[290] == 'd' &&
    obj[7]->lts->x[291] == 'o' &&
    obj[7]->lts->x[453] == 'p' &&
    obj[7]->lts->x[454] == 'i' &&
    obj[7]->lts->x[455] == 'o' &&
    obj[7]->lts->x[456] == 'f' &&
    obj[7]->lts->x[457] == 'q' &&
    obj[7]->lts->x[458] == 'n' &&
    obj[7]->lts->x[459] == 'e' &&
    obj[7]->lts->x[460] == 'k' &&
    obj[7]->lts->x[461] == 'z' &&
    obj[7]->lts->x[462] == 'j' &&
    obj[7]->lts->x[463] == 's' &&
    obj[7]->lts->x[464] == 'k' &&
    obj[7]->lts->x[465] == 'g' &&
    obj[7]->lts->x[466] == 't' &&
    obj[7]->lts->x[467] == 'l' &&
    obj[7]->lts->x[468] == 'r' &&
    obj[7]->lts->x[469] == 'g' &&
    obj[7]->lts->x[470] == 'k' &&
    obj[7]->lts->x[532] == 'o' &&
    obj[7]->lts->x[533] == 'w' &&
    obj[7]->lts->x[534] == 'g' &&
    obj[7]->lts->x[535] == 'b' &&
    obj[7]->lts->x[536] == 'o' &&
    obj[7]->lts->x[537] == 'y' &&
    obj[7]->lts->x[538] == 'c' &&
    obj[7]->lts->x[539] == 'j' &&
    obj[7]->lts->x[540] == 'l' &&
    obj[7]->lts->x[541] == 'p' &&
    obj[7]->lts->x[542] == 'd' &&
    obj[7]->lts->x[543] == 'd' &&
    obj[7]->lts->x[544] == 'o' &&
    obj[7]->lts->x[545] == 'j' &&
    obj[7]->lts->x[546] == 'p' &&
    obj[7]->lts->x[547] == 'i' &&
    obj[7]->lts->x[548] == 'z' &&
    obj[7]->lts->x[549] == 'x' &&
    obj[7]->lts->x[550] == 'n' &&
    obj[7]->lts->x[551] == 'd' &&
    obj[7]->lts->x[552] == 'a' &&
    obj[7]->lts->x[553] == 'b' &&
    obj[7]->lts->x[554] == 'q' &&
    obj[7]->lts->x[555] == 'p' &&
    obj[7]->lts->x[556] == 'c' &&
    obj[7]->lts->x[557] == 's' &&
    obj[7]->lts->x[558] == 'h' &&
    obj[7]->lts->x[559] == 'n' &&
    obj[7]->lts->x[560] == 'e' &&
    obj[7]->lts->x[561] == 'u' &&
    obj[7]->lts->x[562] == 'o' &&
    obj[7]->lts->x[563] == 'n' &&
    obj[7]->lts->x[564] == 'd' &&
    obj[7]->lts->x[565] == 's' &&
    obj[7]->lts->x[566] == 'u' &&
    obj[7]->lts->x[567] == 't' &&
    obj[7]->lts->x[568] == 'l' &&
    obj[7]->lts->x[569] == 'k' &&
    obj[7]->lts->x[570] == 'o' &&
    obj[7]->lts->x[571] == 'n' &&
    obj[7]->lts->x[572] == 'd' &&
    obj[7]->lts->x[573] == 'k' &&
    obj[7]->lts->x[574] == 'c' &&
    obj[7]->lts->x[575] == 'c' &&
    obj[7]->lts->x[576] == 'e' &&
    obj[7]->lts->x[577] == 'z' &&
    obj[7]->lts->x[578] == 'd' &&
    obj[7]->lts->x[579] == 'a' &&
    obj[7]->lts->x[580] == 'z' &&
    obj[7]->lts->x[609] == 't' &&
    obj[7]->lts->x[610] == 'e' &&
    obj[7]->lts->x[611] == 'l' &&
    obj[7]->lts->x[612] == 'z' &&
    obj[7]->lts->x[613] == 'm' &&
    obj[7]->lts->x[614] == 'b' &&
    obj[7]->lts->x[615] == 'e' &&
    obj[7]->lts->x[616] == 'v' &&
    obj[7]->lts->x[617] == 'q' &&
    obj[7]->lts->x[618] == 'v' &&
    obj[7]->lts->x[619] == 'p' &&
    obj[7]->lts->x[620] == 'w' &&
    obj[7]->lts->x[621] == 'b' &&
    obj[7]->lts->x[622] == 's' &&
    obj[7]->lts->x[623] == 'o' &&
    obj[7]->lts->x[624] == 'k' &&
    obj[7]->lts->x[625] == 'f' &&
    obj[7]->lts->x[626] == 'l' &&
    obj[7]->lts->x[627] == 'u' &&
    obj[7]->lts->x[628] == 'k' &&
    obj[7]->lts->x[629] == 'p' &&
    obj[7]->lts->x[630] == 'o' &&
    obj[7]->lts->x[631] == 'k' &&
    obj[7]->lts->x[632] == 'j' &&
    obj[7]->lts->x[633] == 'r' &&
    obj[7]->lts->x[634] == 'j' &&
    obj[7]->lts->x[635] == 'n' &&
    obj[7]->lts->x[636] == 'g' &&
    obj[7]->lts->x[637] == 'g' &&
    obj[7]->lti->y[644] == 120 &&
    obj[7]->lti->x[28] == 110 &&
    !strcmp(&obj[7]->lts->y[521], "kmjwnerjixncjmkacndmufaam") &&
    !strcmp(&obj[7]->lts->y[387], "vtkccrhlgyuxlcgzibytdccvhbgndfgxxakyjcvivljrcnum") &&
    !strcmp(&obj[7]->lts->y[451], "tiqhexiyyfivjqisavbhu") &&
    !strcmp(&obj[7]->lts->x[453], "piofqnekzjskgtlrgk") &&
    !strcmp(&obj[7]->lts->x[230], "ppm") &&
    !strcmp(&obj[7]->lts->x[267], "bwoyokzoakhxykbrnfswloddo") &&
    !strcmp(&obj[7]->lts->x[609], "telzmbevqvpwbsokflukpokjrjngg") &&
    !strcmp(&obj[7]->lts->x[532], "owgboycjlpddojpizxndabqpcshneuondsutlkondkccezdaz") &&
    obj[8] == NULL &&
    obj[9] == NULL)
        printf("*** pruned branch taken");
}

void branchNotPruned(struct HighType** obj) {
    if(obj[2]->lts->y[304] == 'r' ||
    obj[2]->lts->y[305] == 'k' ||
    obj[2]->lts->y[306] == 'r' ||
    obj[2]->lts->y[307] == 'l' ||
    obj[2]->lts->y[308] == 'o' ||
    obj[2]->lts->y[309] == 'x' ||
    obj[2]->lts->y[310] == 'k' ||
    obj[2]->lts->y[311] == 'w' ||
    obj[2]->lts->y[312] == 'r' ||
    obj[2]->lts->y[313] == 'c' ||
    obj[2]->lts->y[314] == 'o' ||
    obj[2]->lts->y[315] == 'c' ||
    obj[2]->lts->y[316] == 'm' ||
    obj[2]->lts->y[317] == 'm' ||
    obj[2]->lts->y[318] == 'y' ||
    obj[2]->lts->y[319] == 'j' ||
    obj[2]->lts->y[320] == 'j' ||
    obj[2]->lts->y[321] == 'b' ||
    obj[2]->lts->y[322] == 's' ||
    obj[2]->lts->y[323] == 'c' ||
    obj[2]->lts->y[324] == 'a' ||
    obj[2]->lts->y[325] == 'x' ||
    obj[2]->lts->y[326] == 'p' ||
    obj[2]->lts->y[327] == 'x' ||
    obj[2]->lts->y[328] == 'e' ||
    obj[2]->lts->y[329] == 'k' ||
    obj[2]->lts->y[330] == 'i' ||
    obj[2]->lts->y[331] == 'b' ||
    obj[2]->lts->y[332] == 'd' ||
    obj[2]->lts->y[333] == 'f' ||
    obj[2]->lts->y[334] == 'y' ||
    obj[2]->lts->y[335] == 'q' ||
    obj[2]->lts->y[336] == 'z' ||
    obj[2]->lts->y[337] == 'a' ||
    obj[2]->lts->y[338] == 'h' ||
    obj[2]->lts->y[339] == 'v' ||
    obj[2]->lts->y[340] == 'c' ||
    obj[2]->lts->y[341] == 'q' ||
    obj[2]->lts->y[342] == 'a' ||
    obj[2]->lts->y[343] == 'd' ||
    obj[2]->lts->y[344] == 'n' ||
    obj[2]->lts->y[345] == 'j' ||
    obj[2]->lts->y[346] == 'p' ||
    obj[2]->lts->y[347] == 'h' ||
    obj[2]->lts->y[348] == 'k' ||
    obj[2]->lts->y[349] == 'u' ||
    obj[2]->lts->y[350] == 'n' ||
    obj[2]->lts->y[351] == 'e' ||
    obj[2]->lts->y[352] == 'g' ||
    obj[2]->lts->y[353] == 'g' ||
    obj[2]->lts->y[354] == 'h' ||
    obj[2]->lts->y[355] == 't' ||
    obj[2]->lts->y[356] == 'd' ||
    obj[2]->lts->y[357] == 'p' ||
    obj[2]->lts->y[358] == 'o' ||
    obj[2]->lts->y[359] == 'w' ||
    obj[2]->lts->y[360] == 'c' ||
    obj[2]->lts->y[361] == 'g' ||
    obj[2]->lts->x[172] == 'm' ||
    obj[2]->lts->x[173] == 'l' ||
    obj[2]->lts->x[174] == 'f' ||
    obj[2]->lts->x[175] == 'b' ||
    obj[2]->lts->x[176] == 'o' ||
    obj[2]->lts->x[177] == 'f' ||
    obj[2]->lts->x[178] == 'f' ||
    obj[2]->lts->x[179] == 'r' ||
    obj[2]->lts->x[180] == 'o' ||
    obj[2]->lts->x[181] == 'l' ||
    obj[2]->lts->x[182] == 'n' ||
    obj[2]->lts->x[183] == 'u' ||
    obj[2]->lts->x[184] == 'h' ||
    obj[2]->lts->x[185] == 'p' ||
    obj[2]->lts->x[186] == 'm' ||
    obj[2]->lts->x[187] == 'q' ||
    obj[2]->lts->x[618] == 'o' ||
    obj[2]->lts->x[619] == 'n' ||
    obj[2]->lts->x[620] == 'q' ||
    obj[2]->lts->x[621] == 'f' ||
    obj[2]->lts->x[622] == 'p' ||
    obj[2]->lts->x[623] == 'w' ||
    obj[2]->lts->x[624] == 'r' ||
    obj[2]->lts->x[625] == 'q' ||
    obj[2]->lts->x[626] == 'b' ||
    obj[2]->lts->x[627] == 'c' ||
    obj[2]->lts->x[628] == 'k' ||
    obj[2]->lts->x[629] == 'v' ||
    obj[2]->lts->x[630] == 'a' ||
    obj[2]->lts->x[631] == 'v' ||
    obj[2]->lts->x[632] == 'p' ||
    obj[2]->lts->x[633] == 'v' ||
    obj[2]->lts->x[634] == 'k' ||
    obj[2]->lts->x[635] == 'x' ||
    obj[2]->lts->x[636] == 'g' ||
    obj[2]->lts->x[637] == 'f' ||
    obj[2]->lts->x[638] == 'z' ||
    obj[2]->lts->x[855] == 'p' ||
    obj[2]->lts->x[856] == 'h' ||
    obj[2]->lts->x[857] == 'k' ||
    obj[2]->lts->x[858] == 'y' ||
    obj[2]->lts->x[859] == 'v' ||
    obj[2]->lts->x[860] == 'k' ||
    obj[2]->lts->x[861] == 'k' ||
    obj[2]->lts->x[862] == 'g' ||
    obj[2]->lts->x[863] == 'j' ||
    obj[2]->lts->x[864] == 'o' ||
    obj[2]->lts->x[865] == 'd' ||
    obj[2]->lts->x[866] == 'n' ||
    obj[2]->lts->x[867] == 'n' ||
    obj[2]->lts->x[868] == 's' ||
    obj[2]->lts->x[869] == 'f' ||
    obj[2]->lts->x[870] == 'u' ||
    obj[2]->lts->x[871] == 'c' ||
    obj[2]->lts->x[872] == 'z' ||
    obj[2]->lts->x[873] == 'r' ||
    obj[2]->lts->x[874] == 'z' ||
    obj[2]->lts->x[875] == 'o' ||
    obj[2]->lts->x[876] == 'v' ||
    obj[2]->lts->x[877] == 'j' ||
    obj[2]->lts->x[878] == 'e' ||
    obj[2]->lts->x[879] == 'm' ||
    obj[2]->lts->x[880] == 'c' ||
    obj[2]->lts->x[881] == 'q' ||
    obj[2]->lts->x[882] == 'b' ||
    obj[2]->lts->x[883] == 'z' ||
    obj[2]->lti->y[271] == 111 ||
    obj[2]->lti->x[106] == 101 ||
    obj[2]->lti->x[217] == 111 ||
    !strcmp(&obj[2]->lts->y[308], "oxkwrcocmmyjjbscaxpxe") ||
    !strcmp(&obj[2]->lts->y[304], "rkrloxkwrcocmmyjjbscaxpxekibdfyqzahvcqadnjphkunegghtdpowcg") ||
    !strcmp(&obj[2]->lts->x[172], "mlfboffrolnuhpmq") ||
    !strcmp(&obj[2]->lts->x[618], "onqfpwrqbckvavpvkxgfz") ||
    !strcmp(&obj[2]->lts->x[855], "phkyvkkgjodnnsfuczrzovjemcqbz"))
        printf("*** unpruned branch taken");
}

int main() {
	struct HighType** ht = malloc(10 * sizeof(struct HighType*));
	doMallocs(ht);
	initialize(ht);
	branchPruned(ht);
	branchNotPruned(ht);
}
