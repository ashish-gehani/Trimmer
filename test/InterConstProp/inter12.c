
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

extern void externalFunc(struct HighType * ht);

void doMallocs(struct HighType** obj) {
    obj[1] = malloc(sizeof(struct HighType));
    obj[2] = malloc(sizeof(struct HighType));
    obj[3] = malloc(sizeof(struct HighType));
    obj[4] = malloc(sizeof(struct HighType));
    obj[5] = malloc(sizeof(struct HighType));
    obj[6] = malloc(sizeof(struct HighType));
    obj[7] = malloc(sizeof(struct HighType));
    obj[8] = malloc(sizeof(struct HighType));
}
void initialize(struct HighType** obj) {
    obj[1]->lti.y[321] = 113;
    memcpy(&obj[1]->lts.x[902], "cdzafwiklhzyzdgzxawjtggqtomhqmeajswfyoqmopjlpj", 46);
    obj[1]->lti.x[398] = 122;
    memcpy(&obj[1]->lts.y[505], "chdmmnjzleppuhscopjbieaazzvnwpqrfysdsq", 38);
    obj[1]->lti.y[485] = 109;
    obj[2]->lti.y[580] = 98;
    obj[2]->lti.y[195] = 114;
    memcpy(&obj[2]->lts.y[329], "jqmaotagfqdmaxqveksfaiabcpicedhmezuzquenkufbwlmt", 48);
    memcpy(&obj[2]->lts.y[730], "wbdhpwwatwrpmtfdbkojwsyqsbmode", 30);
    memcpy(&obj[2]->lts.y[401], "fufsliimculjqncxjajbunntulswdw", 30);
    obj[3]->lti.y[53] = 103;
    memcpy(&obj[3]->lts.x[57], "wzepsotsdsxrpnzggvbjjlfwcffgjvdopp", 34);
    memcpy(&obj[3]->lts.x[852], "jujfwlcuzalgkskft", 17);
    memcpy(&obj[3]->lts.y[59], "ccuatdczmzijwhsrqumclknlkjalxj", 30);
    memcpy(&obj[3]->lts.x[424], "kgaakueekzbxynziqipaprcthxgtepfwhmtsq", 37);
    memcpy(&obj[4]->lts.y[361], "kwjmtubzc", 9);
    obj[4]->lti.x[260] = 105;
    obj[4]->lti.x[188] = 119;
    obj[4]->lti.x[312] = 105;
    memcpy(&obj[4]->lts.y[442], "pbbugjczcjxhsoqzvudfhzlncryegkykracwbzdmbmmq", 44);
    memcpy(&obj[5]->lts.y[80], "qzocuvzecazlcbiptaisdpwasjncgtwevfweyebpzeooidznzh", 50);
    memcpy(&obj[5]->lts.y[437], "cjqjepiocqbchzsl", 16);
    memcpy(&obj[5]->lts.x[574], "thktikerxixopklqipbiycogfqsrfajtpvdzafjwrmm", 43);
    obj[5]->lti.y[478] = 109;
    obj[5]->lti.x[577] = 107;
    obj[6]->lti.y[194] = 108;
    memcpy(&obj[6]->lts.y[468], "wamsjyjnlkgpsradzoqleillvt", 26);
    memcpy(&obj[6]->lts.y[461], "fwpzssl", 7);
    memcpy(&obj[6]->lts.y[73], "tnqgqoy", 7);
    memcpy(&obj[6]->lts.x[693], "gztdeambpdjcdggpflvlricyksuvhjlrhltpywxor", 41);
    obj[7]->lti.y[458] = 100;
    memcpy(&obj[7]->lts.x[146], "jtfkdyzahqclrdntnfi", 19);
    memcpy(&obj[7]->lts.y[328], "mmlyumyvybjtcvvgwtyqpxannmdlwtikl", 33);
    obj[7]->lti.x[898] = 105;
    obj[7]->lti.x[714] = 113;
    obj[8]->lti.y[516] = 100;
    memcpy(&obj[8]->lts.x[808], "a", 1);
    obj[8]->lti.y[579] = 97;
    memcpy(&obj[8]->lts.y[507], "dhdpwwwwgviqwlvpkbebhpwsicgtsxhbuy", 34);
    memcpy(&obj[8]->lts.y[411], "puwbmosfbkuxpjmeyxhmkvpreieeetblktkhykymttbe", 44);
}
void branchPruned(struct HighType** obj) {
    if(obj[0] == NULL &&
    obj[1]->lts.y[505] == 'c' &&
    obj[1]->lts.y[506] == 'h' &&
    obj[1]->lts.y[507] == 'd' &&
    obj[1]->lts.y[508] == 'm' &&
    obj[1]->lts.y[509] == 'm' &&
    obj[1]->lts.y[510] == 'n' &&
    obj[1]->lts.y[511] == 'j' &&
    obj[1]->lts.y[512] == 'z' &&
    obj[1]->lts.y[513] == 'l' &&
    obj[1]->lts.y[514] == 'e' &&
    obj[1]->lts.y[515] == 'p' &&
    obj[1]->lts.y[516] == 'p' &&
    obj[1]->lts.y[517] == 'u' &&
    obj[1]->lts.y[518] == 'h' &&
    obj[1]->lts.y[519] == 's' &&
    obj[1]->lts.y[520] == 'c' &&
    obj[1]->lts.y[521] == 'o' &&
    obj[1]->lts.y[522] == 'p' &&
    obj[1]->lts.y[523] == 'j' &&
    obj[1]->lts.y[524] == 'b' &&
    obj[1]->lts.y[525] == 'i' &&
    obj[1]->lts.y[526] == 'e' &&
    obj[1]->lts.y[527] == 'a' &&
    obj[1]->lts.y[528] == 'a' &&
    obj[1]->lts.y[529] == 'z' &&
    obj[1]->lts.y[530] == 'z' &&
    obj[1]->lts.y[531] == 'v' &&
    obj[1]->lts.y[532] == 'n' &&
    obj[1]->lts.y[533] == 'w' &&
    obj[1]->lts.y[534] == 'p' &&
    obj[1]->lts.y[535] == 'q' &&
    obj[1]->lts.y[536] == 'r' &&
    obj[1]->lts.y[537] == 'f' &&
    obj[1]->lts.y[538] == 'y' &&
    obj[1]->lts.y[539] == 's' &&
    obj[1]->lts.y[540] == 'd' &&
    obj[1]->lts.y[541] == 's' &&
    obj[1]->lts.y[542] == 'q' &&
    obj[1]->lts.x[902] == 'c' &&
    obj[1]->lts.x[903] == 'd' &&
    obj[1]->lts.x[904] == 'z' &&
    obj[1]->lts.x[905] == 'a' &&
    obj[1]->lts.x[906] == 'f' &&
    obj[1]->lts.x[907] == 'w' &&
    obj[1]->lts.x[908] == 'i' &&
    obj[1]->lts.x[909] == 'k' &&
    obj[1]->lts.x[910] == 'l' &&
    obj[1]->lts.x[911] == 'h' &&
    obj[1]->lts.x[912] == 'z' &&
    obj[1]->lts.x[913] == 'y' &&
    obj[1]->lts.x[914] == 'z' &&
    obj[1]->lts.x[915] == 'd' &&
    obj[1]->lts.x[916] == 'g' &&
    obj[1]->lts.x[917] == 'z' &&
    obj[1]->lts.x[918] == 'x' &&
    obj[1]->lts.x[919] == 'a' &&
    obj[1]->lts.x[920] == 'w' &&
    obj[1]->lts.x[921] == 'j' &&
    obj[1]->lts.x[922] == 't' &&
    obj[1]->lts.x[923] == 'g' &&
    obj[1]->lts.x[924] == 'g' &&
    obj[1]->lts.x[925] == 'q' &&
    obj[1]->lts.x[926] == 't' &&
    obj[1]->lts.x[927] == 'o' &&
    obj[1]->lts.x[928] == 'm' &&
    obj[1]->lts.x[929] == 'h' &&
    obj[1]->lts.x[930] == 'q' &&
    obj[1]->lts.x[931] == 'm' &&
    obj[1]->lts.x[932] == 'e' &&
    obj[1]->lts.x[933] == 'a' &&
    obj[1]->lts.x[934] == 'j' &&
    obj[1]->lts.x[935] == 's' &&
    obj[1]->lts.x[936] == 'w' &&
    obj[1]->lts.x[937] == 'f' &&
    obj[1]->lts.x[938] == 'y' &&
    obj[1]->lts.x[939] == 'o' &&
    obj[1]->lts.x[940] == 'q' &&
    obj[1]->lts.x[941] == 'm' &&
    obj[1]->lts.x[942] == 'o' &&
    obj[1]->lts.x[943] == 'p' &&
    obj[1]->lts.x[944] == 'j' &&
    obj[1]->lts.x[945] == 'l' &&
    obj[1]->lts.x[946] == 'p' &&
    obj[1]->lts.x[947] == 'j' &&
    obj[1]->lti.y[321] == 113 &&
    obj[1]->lti.y[485] == 109 &&
    obj[1]->lti.x[398] == 122 &&
    !strcmp(&obj[1]->lts.y[505], "chdmmnjzleppuhscopjbieaazzvnwpqrfysdsq") &&
    !strcmp(&obj[1]->lts.x[902], "cdzafwiklhzyzdgzxawjtggqtomhqmeajswfyoqmopjlpj") &&
    obj[2]->lts.y[329] == 'j' &&
    obj[2]->lts.y[330] == 'q' &&
    obj[2]->lts.y[331] == 'm' &&
    obj[2]->lts.y[332] == 'a' &&
    obj[2]->lts.y[333] == 'o' &&
    obj[2]->lts.y[334] == 't' &&
    obj[2]->lts.y[335] == 'a' &&
    obj[2]->lts.y[336] == 'g' &&
    obj[2]->lts.y[337] == 'f' &&
    obj[2]->lts.y[338] == 'q' &&
    obj[2]->lts.y[339] == 'd' &&
    obj[2]->lts.y[340] == 'm' &&
    obj[2]->lts.y[341] == 'a' &&
    obj[2]->lts.y[342] == 'x' &&
    obj[2]->lts.y[343] == 'q' &&
    obj[2]->lts.y[344] == 'v' &&
    obj[2]->lts.y[345] == 'e' &&
    obj[2]->lts.y[346] == 'k' &&
    obj[2]->lts.y[347] == 's' &&
    obj[2]->lts.y[348] == 'f' &&
    obj[2]->lts.y[349] == 'a' &&
    obj[2]->lts.y[350] == 'i' &&
    obj[2]->lts.y[351] == 'a' &&
    obj[2]->lts.y[352] == 'b' &&
    obj[2]->lts.y[353] == 'c' &&
    obj[2]->lts.y[354] == 'p' &&
    obj[2]->lts.y[355] == 'i' &&
    obj[2]->lts.y[356] == 'c' &&
    obj[2]->lts.y[357] == 'e' &&
    obj[2]->lts.y[358] == 'd' &&
    obj[2]->lts.y[359] == 'h' &&
    obj[2]->lts.y[360] == 'm' &&
    obj[2]->lts.y[361] == 'e' &&
    obj[2]->lts.y[362] == 'z' &&
    obj[2]->lts.y[363] == 'u' &&
    obj[2]->lts.y[364] == 'z' &&
    obj[2]->lts.y[365] == 'q' &&
    obj[2]->lts.y[366] == 'u' &&
    obj[2]->lts.y[367] == 'e' &&
    obj[2]->lts.y[368] == 'n' &&
    obj[2]->lts.y[369] == 'k' &&
    obj[2]->lts.y[370] == 'u' &&
    obj[2]->lts.y[371] == 'f' &&
    obj[2]->lts.y[372] == 'b' &&
    obj[2]->lts.y[373] == 'w' &&
    obj[2]->lts.y[374] == 'l' &&
    obj[2]->lts.y[375] == 'm' &&
    obj[2]->lts.y[376] == 't' &&
    obj[2]->lts.y[401] == 'f' &&
    obj[2]->lts.y[402] == 'u' &&
    obj[2]->lts.y[403] == 'f' &&
    obj[2]->lts.y[404] == 's' &&
    obj[2]->lts.y[405] == 'l' &&
    obj[2]->lts.y[406] == 'i' &&
    obj[2]->lts.y[407] == 'i' &&
    obj[2]->lts.y[408] == 'm' &&
    obj[2]->lts.y[409] == 'c' &&
    obj[2]->lts.y[410] == 'u' &&
    obj[2]->lts.y[411] == 'l' &&
    obj[2]->lts.y[412] == 'j' &&
    obj[2]->lts.y[413] == 'q' &&
    obj[2]->lts.y[414] == 'n' &&
    obj[2]->lts.y[415] == 'c' &&
    obj[2]->lts.y[416] == 'x' &&
    obj[2]->lts.y[417] == 'j' &&
    obj[2]->lts.y[418] == 'a' &&
    obj[2]->lts.y[419] == 'j' &&
    obj[2]->lts.y[420] == 'b' &&
    obj[2]->lts.y[421] == 'u' &&
    obj[2]->lts.y[422] == 'n' &&
    obj[2]->lts.y[423] == 'n' &&
    obj[2]->lts.y[424] == 't' &&
    obj[2]->lts.y[425] == 'u' &&
    obj[2]->lts.y[426] == 'l' &&
    obj[2]->lts.y[427] == 's' &&
    obj[2]->lts.y[428] == 'w' &&
    obj[2]->lts.y[429] == 'd' &&
    obj[2]->lts.y[430] == 'w' &&
    obj[2]->lts.y[730] == 'w' &&
    obj[2]->lts.y[731] == 'b' &&
    obj[2]->lts.y[732] == 'd' &&
    obj[2]->lts.y[733] == 'h' &&
    obj[2]->lts.y[734] == 'p' &&
    obj[2]->lts.y[735] == 'w' &&
    obj[2]->lts.y[736] == 'w' &&
    obj[2]->lts.y[737] == 'a' &&
    obj[2]->lts.y[738] == 't' &&
    obj[2]->lts.y[739] == 'w' &&
    obj[2]->lts.y[740] == 'r' &&
    obj[2]->lts.y[741] == 'p' &&
    obj[2]->lts.y[742] == 'm' &&
    obj[2]->lts.y[743] == 't' &&
    obj[2]->lts.y[744] == 'f' &&
    obj[2]->lts.y[745] == 'd' &&
    obj[2]->lts.y[746] == 'b' &&
    obj[2]->lts.y[747] == 'k' &&
    obj[2]->lts.y[748] == 'o' &&
    obj[2]->lts.y[749] == 'j' &&
    obj[2]->lts.y[750] == 'w' &&
    obj[2]->lts.y[751] == 's' &&
    obj[2]->lts.y[752] == 'y' &&
    obj[2]->lts.y[753] == 'q' &&
    obj[2]->lts.y[754] == 's' &&
    obj[2]->lts.y[755] == 'b' &&
    obj[2]->lts.y[756] == 'm' &&
    obj[2]->lts.y[757] == 'o' &&
    obj[2]->lts.y[758] == 'd' &&
    obj[2]->lts.y[759] == 'e' &&
    obj[2]->lti.y[195] == 114 &&
    obj[2]->lti.y[580] == 98 &&
    !strcmp(&obj[2]->lts.y[329], "jqmaotagfqdmaxqveksfaiabcpicedhmezuzquenkufbwlmt") &&
    !strcmp(&obj[2]->lts.y[730], "wbdhpwwatwrpmtfdbkojwsyqsbmode") &&
    !strcmp(&obj[2]->lts.y[401], "fufsliimculjqncxjajbunntulswdw") &&
    obj[3]->lts.y[59] == 'c' &&
    obj[3]->lts.y[60] == 'c' &&
    obj[3]->lts.y[61] == 'u' &&
    obj[3]->lts.y[62] == 'a' &&
    obj[3]->lts.y[63] == 't' &&
    obj[3]->lts.y[64] == 'd' &&
    obj[3]->lts.y[65] == 'c' &&
    obj[3]->lts.y[66] == 'z' &&
    obj[3]->lts.y[67] == 'm' &&
    obj[3]->lts.y[68] == 'z' &&
    obj[3]->lts.y[69] == 'i' &&
    obj[3]->lts.y[70] == 'j' &&
    obj[3]->lts.y[71] == 'w' &&
    obj[3]->lts.y[72] == 'h' &&
    obj[3]->lts.y[73] == 's' &&
    obj[3]->lts.y[74] == 'r' &&
    obj[3]->lts.y[75] == 'q' &&
    obj[3]->lts.y[76] == 'u' &&
    obj[3]->lts.y[77] == 'm' &&
    obj[3]->lts.y[78] == 'c' &&
    obj[3]->lts.y[79] == 'l' &&
    obj[3]->lts.y[80] == 'k' &&
    obj[3]->lts.y[81] == 'n' &&
    obj[3]->lts.y[82] == 'l' &&
    obj[3]->lts.y[83] == 'k' &&
    obj[3]->lts.y[84] == 'j' &&
    obj[3]->lts.y[85] == 'a' &&
    obj[3]->lts.y[86] == 'l' &&
    obj[3]->lts.y[87] == 'x' &&
    obj[3]->lts.y[88] == 'j' &&
    obj[3]->lts.x[57] == 'w' &&
    obj[3]->lts.x[58] == 'z' &&
    obj[3]->lts.x[59] == 'e' &&
    obj[3]->lts.x[60] == 'p' &&
    obj[3]->lts.x[61] == 's' &&
    obj[3]->lts.x[62] == 'o' &&
    obj[3]->lts.x[63] == 't' &&
    obj[3]->lts.x[64] == 's' &&
    obj[3]->lts.x[65] == 'd' &&
    obj[3]->lts.x[66] == 's' &&
    obj[3]->lts.x[67] == 'x' &&
    obj[3]->lts.x[68] == 'r' &&
    obj[3]->lts.x[69] == 'p' &&
    obj[3]->lts.x[70] == 'n' &&
    obj[3]->lts.x[71] == 'z' &&
    obj[3]->lts.x[72] == 'g' &&
    obj[3]->lts.x[73] == 'g' &&
    obj[3]->lts.x[74] == 'v' &&
    obj[3]->lts.x[75] == 'b' &&
    obj[3]->lts.x[76] == 'j' &&
    obj[3]->lts.x[77] == 'j' &&
    obj[3]->lts.x[78] == 'l' &&
    obj[3]->lts.x[79] == 'f' &&
    obj[3]->lts.x[80] == 'w' &&
    obj[3]->lts.x[81] == 'c' &&
    obj[3]->lts.x[82] == 'f' &&
    obj[3]->lts.x[83] == 'f' &&
    obj[3]->lts.x[84] == 'g' &&
    obj[3]->lts.x[85] == 'j' &&
    obj[3]->lts.x[86] == 'v' &&
    obj[3]->lts.x[87] == 'd' &&
    obj[3]->lts.x[88] == 'o' &&
    obj[3]->lts.x[89] == 'p' &&
    obj[3]->lts.x[90] == 'p' &&
    obj[3]->lts.x[424] == 'k' &&
    obj[3]->lts.x[425] == 'g' &&
    obj[3]->lts.x[426] == 'a' &&
    obj[3]->lts.x[427] == 'a' &&
    obj[3]->lts.x[428] == 'k' &&
    obj[3]->lts.x[429] == 'u' &&
    obj[3]->lts.x[430] == 'e' &&
    obj[3]->lts.x[431] == 'e' &&
    obj[3]->lts.x[432] == 'k' &&
    obj[3]->lts.x[433] == 'z' &&
    obj[3]->lts.x[434] == 'b' &&
    obj[3]->lts.x[435] == 'x' &&
    obj[3]->lts.x[436] == 'y' &&
    obj[3]->lts.x[437] == 'n' &&
    obj[3]->lts.x[438] == 'z' &&
    obj[3]->lts.x[439] == 'i' &&
    obj[3]->lts.x[440] == 'q' &&
    obj[3]->lts.x[441] == 'i' &&
    obj[3]->lts.x[442] == 'p' &&
    obj[3]->lts.x[443] == 'a' &&
    obj[3]->lts.x[444] == 'p' &&
    obj[3]->lts.x[445] == 'r' &&
    obj[3]->lts.x[446] == 'c' &&
    obj[3]->lts.x[447] == 't' &&
    obj[3]->lts.x[448] == 'h' &&
    obj[3]->lts.x[449] == 'x' &&
    obj[3]->lts.x[450] == 'g' &&
    obj[3]->lts.x[451] == 't' &&
    obj[3]->lts.x[452] == 'e' &&
    obj[3]->lts.x[453] == 'p' &&
    obj[3]->lts.x[454] == 'f' &&
    obj[3]->lts.x[455] == 'w' &&
    obj[3]->lts.x[456] == 'h' &&
    obj[3]->lts.x[457] == 'm' &&
    obj[3]->lts.x[458] == 't' &&
    obj[3]->lts.x[459] == 's' &&
    obj[3]->lts.x[460] == 'q' &&
    obj[3]->lts.x[852] == 'j' &&
    obj[3]->lts.x[853] == 'u' &&
    obj[3]->lts.x[854] == 'j' &&
    obj[3]->lts.x[855] == 'f' &&
    obj[3]->lts.x[856] == 'w' &&
    obj[3]->lts.x[857] == 'l' &&
    obj[3]->lts.x[858] == 'c' &&
    obj[3]->lts.x[859] == 'u' &&
    obj[3]->lts.x[860] == 'z' &&
    obj[3]->lts.x[861] == 'a' &&
    obj[3]->lts.x[862] == 'l' &&
    obj[3]->lts.x[863] == 'g' &&
    obj[3]->lts.x[864] == 'k' &&
    obj[3]->lts.x[865] == 's' &&
    obj[3]->lts.x[866] == 'k' &&
    obj[3]->lts.x[867] == 'f' &&
    obj[3]->lts.x[868] == 't' &&
    obj[3]->lti.y[53] == 103 &&
    !strcmp(&obj[3]->lts.y[59], "ccuatdczmzijwhsrqumclknlkjalxj") &&
    !strcmp(&obj[3]->lts.x[57], "wzepsotsdsxrpnzggvbjjlfwcffgjvdopp") &&
    !strcmp(&obj[3]->lts.x[852], "jujfwlcuzalgkskft") &&
    !strcmp(&obj[3]->lts.x[424], "kgaakueekzbxynziqipaprcthxgtepfwhmtsq") &&
    obj[4]->lts.y[361] == 'k' &&
    obj[4]->lts.y[362] == 'w' &&
    obj[4]->lts.y[363] == 'j' &&
    obj[4]->lts.y[364] == 'm' &&
    obj[4]->lts.y[365] == 't' &&
    obj[4]->lts.y[366] == 'u' &&
    obj[4]->lts.y[367] == 'b' &&
    obj[4]->lts.y[368] == 'z' &&
    obj[4]->lts.y[369] == 'c' &&
    obj[4]->lts.y[442] == 'p' &&
    obj[4]->lts.y[443] == 'b' &&
    obj[4]->lts.y[444] == 'b' &&
    obj[4]->lts.y[445] == 'u' &&
    obj[4]->lts.y[446] == 'g' &&
    obj[4]->lts.y[447] == 'j' &&
    obj[4]->lts.y[448] == 'c' &&
    obj[4]->lts.y[449] == 'z' &&
    obj[4]->lts.y[450] == 'c' &&
    obj[4]->lts.y[451] == 'j' &&
    obj[4]->lts.y[452] == 'x' &&
    obj[4]->lts.y[453] == 'h' &&
    obj[4]->lts.y[454] == 's' &&
    obj[4]->lts.y[455] == 'o' &&
    obj[4]->lts.y[456] == 'q' &&
    obj[4]->lts.y[457] == 'z' &&
    obj[4]->lts.y[458] == 'v' &&
    obj[4]->lts.y[459] == 'u' &&
    obj[4]->lts.y[460] == 'd' &&
    obj[4]->lts.y[461] == 'f' &&
    obj[4]->lts.y[462] == 'h' &&
    obj[4]->lts.y[463] == 'z' &&
    obj[4]->lts.y[464] == 'l' &&
    obj[4]->lts.y[465] == 'n' &&
    obj[4]->lts.y[466] == 'c' &&
    obj[4]->lts.y[467] == 'r' &&
    obj[4]->lts.y[468] == 'y' &&
    obj[4]->lts.y[469] == 'e' &&
    obj[4]->lts.y[470] == 'g' &&
    obj[4]->lts.y[471] == 'k' &&
    obj[4]->lts.y[472] == 'y' &&
    obj[4]->lts.y[473] == 'k' &&
    obj[4]->lts.y[474] == 'r' &&
    obj[4]->lts.y[475] == 'a' &&
    obj[4]->lts.y[476] == 'c' &&
    obj[4]->lts.y[477] == 'w' &&
    obj[4]->lts.y[478] == 'b' &&
    obj[4]->lts.y[479] == 'z' &&
    obj[4]->lts.y[480] == 'd' &&
    obj[4]->lts.y[481] == 'm' &&
    obj[4]->lts.y[482] == 'b' &&
    obj[4]->lts.y[483] == 'm' &&
    obj[4]->lts.y[484] == 'm' &&
    obj[4]->lts.y[485] == 'q' &&
    obj[4]->lti.x[188] == 119 &&
    obj[4]->lti.x[260] == 105 &&
    obj[4]->lti.x[312] == 105 &&
    !strcmp(&obj[4]->lts.y[361], "kwjmtubzc") &&
    !strcmp(&obj[4]->lts.y[442], "pbbugjczcjxhsoqzvudfhzlncryegkykracwbzdmbmmq") &&
    obj[5]->lts.y[80] == 'q' &&
    obj[5]->lts.y[81] == 'z' &&
    obj[5]->lts.y[82] == 'o' &&
    obj[5]->lts.y[83] == 'c' &&
    obj[5]->lts.y[84] == 'u' &&
    obj[5]->lts.y[85] == 'v' &&
    obj[5]->lts.y[86] == 'z' &&
    obj[5]->lts.y[87] == 'e' &&
    obj[5]->lts.y[88] == 'c' &&
    obj[5]->lts.y[89] == 'a' &&
    obj[5]->lts.y[90] == 'z' &&
    obj[5]->lts.y[91] == 'l' &&
    obj[5]->lts.y[92] == 'c' &&
    obj[5]->lts.y[93] == 'b' &&
    obj[5]->lts.y[94] == 'i' &&
    obj[5]->lts.y[95] == 'p' &&
    obj[5]->lts.y[96] == 't' &&
    obj[5]->lts.y[97] == 'a' &&
    obj[5]->lts.y[98] == 'i' &&
    obj[5]->lts.y[99] == 's' &&
    obj[5]->lts.y[100] == 'd' &&
    obj[5]->lts.y[101] == 'p' &&
    obj[5]->lts.y[102] == 'w' &&
    obj[5]->lts.y[103] == 'a' &&
    obj[5]->lts.y[104] == 's' &&
    obj[5]->lts.y[105] == 'j' &&
    obj[5]->lts.y[106] == 'n' &&
    obj[5]->lts.y[107] == 'c' &&
    obj[5]->lts.y[108] == 'g' &&
    obj[5]->lts.y[109] == 't' &&
    obj[5]->lts.y[110] == 'w' &&
    obj[5]->lts.y[111] == 'e' &&
    obj[5]->lts.y[112] == 'v' &&
    obj[5]->lts.y[113] == 'f' &&
    obj[5]->lts.y[114] == 'w' &&
    obj[5]->lts.y[115] == 'e' &&
    obj[5]->lts.y[116] == 'y' &&
    obj[5]->lts.y[117] == 'e' &&
    obj[5]->lts.y[118] == 'b' &&
    obj[5]->lts.y[119] == 'p' &&
    obj[5]->lts.y[120] == 'z' &&
    obj[5]->lts.y[121] == 'e' &&
    obj[5]->lts.y[122] == 'o' &&
    obj[5]->lts.y[123] == 'o' &&
    obj[5]->lts.y[124] == 'i' &&
    obj[5]->lts.y[125] == 'd' &&
    obj[5]->lts.y[126] == 'z' &&
    obj[5]->lts.y[127] == 'n' &&
    obj[5]->lts.y[128] == 'z' &&
    obj[5]->lts.y[129] == 'h' &&
    obj[5]->lts.y[437] == 'c' &&
    obj[5]->lts.y[438] == 'j' &&
    obj[5]->lts.y[439] == 'q' &&
    obj[5]->lts.y[440] == 'j' &&
    obj[5]->lts.y[441] == 'e' &&
    obj[5]->lts.y[442] == 'p' &&
    obj[5]->lts.y[443] == 'i' &&
    obj[5]->lts.y[444] == 'o' &&
    obj[5]->lts.y[445] == 'c' &&
    obj[5]->lts.y[446] == 'q' &&
    obj[5]->lts.y[447] == 'b' &&
    obj[5]->lts.y[448] == 'c' &&
    obj[5]->lts.y[449] == 'h' &&
    obj[5]->lts.y[450] == 'z' &&
    obj[5]->lts.y[451] == 's' &&
    obj[5]->lts.y[452] == 'l' &&
    obj[5]->lts.x[574] == 't' &&
    obj[5]->lts.x[575] == 'h' &&
    obj[5]->lts.x[576] == 'k' &&
    obj[5]->lts.x[577] == 't' &&
    obj[5]->lts.x[578] == 'i' &&
    obj[5]->lts.x[579] == 'k' &&
    obj[5]->lts.x[580] == 'e' &&
    obj[5]->lts.x[581] == 'r' &&
    obj[5]->lts.x[582] == 'x' &&
    obj[5]->lts.x[583] == 'i' &&
    obj[5]->lts.x[584] == 'x' &&
    obj[5]->lts.x[585] == 'o' &&
    obj[5]->lts.x[586] == 'p' &&
    obj[5]->lts.x[587] == 'k' &&
    obj[5]->lts.x[588] == 'l' &&
    obj[5]->lts.x[589] == 'q' &&
    obj[5]->lts.x[590] == 'i' &&
    obj[5]->lts.x[591] == 'p' &&
    obj[5]->lts.x[592] == 'b' &&
    obj[5]->lts.x[593] == 'i' &&
    obj[5]->lts.x[594] == 'y' &&
    obj[5]->lts.x[595] == 'c' &&
    obj[5]->lts.x[596] == 'o' &&
    obj[5]->lts.x[597] == 'g' &&
    obj[5]->lts.x[598] == 'f' &&
    obj[5]->lts.x[599] == 'q' &&
    obj[5]->lts.x[600] == 's' &&
    obj[5]->lts.x[601] == 'r' &&
    obj[5]->lts.x[602] == 'f' &&
    obj[5]->lts.x[603] == 'a' &&
    obj[5]->lts.x[604] == 'j' &&
    obj[5]->lts.x[605] == 't' &&
    obj[5]->lts.x[606] == 'p' &&
    obj[5]->lts.x[607] == 'v' &&
    obj[5]->lts.x[608] == 'd' &&
    obj[5]->lts.x[609] == 'z' &&
    obj[5]->lts.x[610] == 'a' &&
    obj[5]->lts.x[611] == 'f' &&
    obj[5]->lts.x[612] == 'j' &&
    obj[5]->lts.x[613] == 'w' &&
    obj[5]->lts.x[614] == 'r' &&
    obj[5]->lts.x[615] == 'm' &&
    obj[5]->lts.x[616] == 'm' &&
    obj[5]->lti.y[478] == 109 &&
    obj[5]->lti.x[577] == 107 &&
    !strcmp(&obj[5]->lts.y[80], "qzocuvzecazlcbiptaisdpwasjncgtwevfweyebpzeooidznzh") &&
    !strcmp(&obj[5]->lts.y[437], "cjqjepiocqbchzsl") &&
    !strcmp(&obj[5]->lts.x[574], "thktikerxixopklqipbiycogfqsrfajtpvdzafjwrmm") &&
    obj[6]->lts.y[73] == 't' &&
    obj[6]->lts.y[74] == 'n' &&
    obj[6]->lts.y[75] == 'q' &&
    obj[6]->lts.y[76] == 'g' &&
    obj[6]->lts.y[77] == 'q' &&
    obj[6]->lts.y[78] == 'o' &&
    obj[6]->lts.y[79] == 'y' &&
    obj[6]->lts.y[461] == 'f' &&
    obj[6]->lts.y[462] == 'w' &&
    obj[6]->lts.y[463] == 'p' &&
    obj[6]->lts.y[464] == 'z' &&
    obj[6]->lts.y[465] == 's' &&
    obj[6]->lts.y[466] == 's' &&
    obj[6]->lts.y[467] == 'l' &&
    obj[6]->lts.y[468] == 'w' &&
    obj[6]->lts.y[469] == 'a' &&
    obj[6]->lts.y[470] == 'm' &&
    obj[6]->lts.y[471] == 's' &&
    obj[6]->lts.y[472] == 'j' &&
    obj[6]->lts.y[473] == 'y' &&
    obj[6]->lts.y[474] == 'j' &&
    obj[6]->lts.y[475] == 'n' &&
    obj[6]->lts.y[476] == 'l' &&
    obj[6]->lts.y[477] == 'k' &&
    obj[6]->lts.y[478] == 'g' &&
    obj[6]->lts.y[479] == 'p' &&
    obj[6]->lts.y[480] == 's' &&
    obj[6]->lts.y[481] == 'r' &&
    obj[6]->lts.y[482] == 'a' &&
    obj[6]->lts.y[483] == 'd' &&
    obj[6]->lts.y[484] == 'z' &&
    obj[6]->lts.y[485] == 'o' &&
    obj[6]->lts.y[486] == 'q' &&
    obj[6]->lts.y[487] == 'l' &&
    obj[6]->lts.y[488] == 'e' &&
    obj[6]->lts.y[489] == 'i' &&
    obj[6]->lts.y[490] == 'l' &&
    obj[6]->lts.y[491] == 'l' &&
    obj[6]->lts.y[492] == 'v' &&
    obj[6]->lts.y[493] == 't' &&
    obj[6]->lts.x[693] == 'g' &&
    obj[6]->lts.x[694] == 'z' &&
    obj[6]->lts.x[695] == 't' &&
    obj[6]->lts.x[696] == 'd' &&
    obj[6]->lts.x[697] == 'e' &&
    obj[6]->lts.x[698] == 'a' &&
    obj[6]->lts.x[699] == 'm' &&
    obj[6]->lts.x[700] == 'b' &&
    obj[6]->lts.x[701] == 'p' &&
    obj[6]->lts.x[702] == 'd' &&
    obj[6]->lts.x[703] == 'j' &&
    obj[6]->lts.x[704] == 'c' &&
    obj[6]->lts.x[705] == 'd' &&
    obj[6]->lts.x[706] == 'g' &&
    obj[6]->lts.x[707] == 'g' &&
    obj[6]->lts.x[708] == 'p' &&
    obj[6]->lts.x[709] == 'f' &&
    obj[6]->lts.x[710] == 'l' &&
    obj[6]->lts.x[711] == 'v' &&
    obj[6]->lts.x[712] == 'l' &&
    obj[6]->lts.x[713] == 'r' &&
    obj[6]->lts.x[714] == 'i' &&
    obj[6]->lts.x[715] == 'c' &&
    obj[6]->lts.x[716] == 'y' &&
    obj[6]->lts.x[717] == 'k' &&
    obj[6]->lts.x[718] == 's' &&
    obj[6]->lts.x[719] == 'u' &&
    obj[6]->lts.x[720] == 'v' &&
    obj[6]->lts.x[721] == 'h' &&
    obj[6]->lts.x[722] == 'j' &&
    obj[6]->lts.x[723] == 'l' &&
    obj[6]->lts.x[724] == 'r' &&
    obj[6]->lts.x[725] == 'h' &&
    obj[6]->lts.x[726] == 'l' &&
    obj[6]->lts.x[727] == 't' &&
    obj[6]->lts.x[728] == 'p' &&
    obj[6]->lts.x[729] == 'y' &&
    obj[6]->lts.x[730] == 'w' &&
    obj[6]->lts.x[731] == 'x' &&
    obj[6]->lts.x[732] == 'o' &&
    obj[6]->lts.x[733] == 'r' &&
    obj[6]->lti.y[194] == 108 &&
    !strcmp(&obj[6]->lts.y[73], "tnqgqoy") &&
    !strcmp(&obj[6]->lts.y[461], "fwpzsslwamsjyjnlkgpsradzoqleillvt") &&
    !strcmp(&obj[6]->lts.x[693], "gztdeambpdjcdggpflvlricyksuvhjlrhltpywxor") &&
    obj[7]->lts.y[328] == 'm' &&
    obj[7]->lts.y[329] == 'm' &&
    obj[7]->lts.y[330] == 'l' &&
    obj[7]->lts.y[331] == 'y' &&
    obj[7]->lts.y[332] == 'u' &&
    obj[7]->lts.y[333] == 'm' &&
    obj[7]->lts.y[334] == 'y' &&
    obj[7]->lts.y[335] == 'v' &&
    obj[7]->lts.y[336] == 'y' &&
    obj[7]->lts.y[337] == 'b' &&
    obj[7]->lts.y[338] == 'j' &&
    obj[7]->lts.y[339] == 't' &&
    obj[7]->lts.y[340] == 'c' &&
    obj[7]->lts.y[341] == 'v' &&
    obj[7]->lts.y[342] == 'v' &&
    obj[7]->lts.y[343] == 'g' &&
    obj[7]->lts.y[344] == 'w' &&
    obj[7]->lts.y[345] == 't' &&
    obj[7]->lts.y[346] == 'y' &&
    obj[7]->lts.y[347] == 'q' &&
    obj[7]->lts.y[348] == 'p' &&
    obj[7]->lts.y[349] == 'x' &&
    obj[7]->lts.y[350] == 'a' &&
    obj[7]->lts.y[351] == 'n' &&
    obj[7]->lts.y[352] == 'n' &&
    obj[7]->lts.y[353] == 'm' &&
    obj[7]->lts.y[354] == 'd' &&
    obj[7]->lts.y[355] == 'l' &&
    obj[7]->lts.y[356] == 'w' &&
    obj[7]->lts.y[357] == 't' &&
    obj[7]->lts.y[358] == 'i' &&
    obj[7]->lts.y[359] == 'k' &&
    obj[7]->lts.y[360] == 'l' &&
    obj[7]->lts.x[146] == 'j' &&
    obj[7]->lts.x[147] == 't' &&
    obj[7]->lts.x[148] == 'f' &&
    obj[7]->lts.x[149] == 'k' &&
    obj[7]->lts.x[150] == 'd' &&
    obj[7]->lts.x[151] == 'y' &&
    obj[7]->lts.x[152] == 'z' &&
    obj[7]->lts.x[153] == 'a' &&
    obj[7]->lts.x[154] == 'h' &&
    obj[7]->lts.x[155] == 'q' &&
    obj[7]->lts.x[156] == 'c' &&
    obj[7]->lts.x[157] == 'l' &&
    obj[7]->lts.x[158] == 'r' &&
    obj[7]->lts.x[159] == 'd' &&
    obj[7]->lts.x[160] == 'n' &&
    obj[7]->lts.x[161] == 't' &&
    obj[7]->lts.x[162] == 'n' &&
    obj[7]->lts.x[163] == 'f' &&
    obj[7]->lts.x[164] == 'i' &&
    obj[7]->lti.y[458] == 100 &&
    obj[7]->lti.x[714] == 113 &&
    obj[7]->lti.x[898] == 105 &&
    !strcmp(&obj[7]->lts.y[328], "mmlyumyvybjtcvvgwtyqpxannmdlwtikl") &&
    !strcmp(&obj[7]->lts.x[146], "jtfkdyzahqclrdntnfi") &&
    obj[8]->lts.y[411] == 'p' &&
    obj[8]->lts.y[412] == 'u' &&
    obj[8]->lts.y[413] == 'w' &&
    obj[8]->lts.y[414] == 'b' &&
    obj[8]->lts.y[415] == 'm' &&
    obj[8]->lts.y[416] == 'o' &&
    obj[8]->lts.y[417] == 's' &&
    obj[8]->lts.y[418] == 'f' &&
    obj[8]->lts.y[419] == 'b' &&
    obj[8]->lts.y[420] == 'k' &&
    obj[8]->lts.y[421] == 'u' &&
    obj[8]->lts.y[422] == 'x' &&
    obj[8]->lts.y[423] == 'p' &&
    obj[8]->lts.y[424] == 'j' &&
    obj[8]->lts.y[425] == 'm' &&
    obj[8]->lts.y[426] == 'e' &&
    obj[8]->lts.y[427] == 'y' &&
    obj[8]->lts.y[428] == 'x' &&
    obj[8]->lts.y[429] == 'h' &&
    obj[8]->lts.y[430] == 'm' &&
    obj[8]->lts.y[431] == 'k' &&
    obj[8]->lts.y[432] == 'v' &&
    obj[8]->lts.y[433] == 'p' &&
    obj[8]->lts.y[434] == 'r' &&
    obj[8]->lts.y[435] == 'e' &&
    obj[8]->lts.y[436] == 'i' &&
    obj[8]->lts.y[437] == 'e' &&
    obj[8]->lts.y[438] == 'e' &&
    obj[8]->lts.y[439] == 'e' &&
    obj[8]->lts.y[440] == 't' &&
    obj[8]->lts.y[441] == 'b' &&
    obj[8]->lts.y[442] == 'l' &&
    obj[8]->lts.y[443] == 'k' &&
    obj[8]->lts.y[444] == 't' &&
    obj[8]->lts.y[445] == 'k' &&
    obj[8]->lts.y[446] == 'h' &&
    obj[8]->lts.y[447] == 'y' &&
    obj[8]->lts.y[448] == 'k' &&
    obj[8]->lts.y[449] == 'y' &&
    obj[8]->lts.y[450] == 'm' &&
    obj[8]->lts.y[451] == 't' &&
    obj[8]->lts.y[452] == 't' &&
    obj[8]->lts.y[453] == 'b' &&
    obj[8]->lts.y[454] == 'e' &&
    obj[8]->lts.y[507] == 'd' &&
    obj[8]->lts.y[508] == 'h' &&
    obj[8]->lts.y[509] == 'd' &&
    obj[8]->lts.y[510] == 'p' &&
    obj[8]->lts.y[511] == 'w' &&
    obj[8]->lts.y[512] == 'w' &&
    obj[8]->lts.y[513] == 'w' &&
    obj[8]->lts.y[514] == 'w' &&
    obj[8]->lts.y[515] == 'g' &&
    obj[8]->lts.y[516] == 'v' &&
    obj[8]->lts.y[517] == 'i' &&
    obj[8]->lts.y[518] == 'q' &&
    obj[8]->lts.y[519] == 'w' &&
    obj[8]->lts.y[520] == 'l' &&
    obj[8]->lts.y[521] == 'v' &&
    obj[8]->lts.y[522] == 'p' &&
    obj[8]->lts.y[523] == 'k' &&
    obj[8]->lts.y[524] == 'b' &&
    obj[8]->lts.y[525] == 'e' &&
    obj[8]->lts.y[526] == 'b' &&
    obj[8]->lts.y[527] == 'h' &&
    obj[8]->lts.y[528] == 'p' &&
    obj[8]->lts.y[529] == 'w' &&
    obj[8]->lts.y[530] == 's' &&
    obj[8]->lts.y[531] == 'i' &&
    obj[8]->lts.y[532] == 'c' &&
    obj[8]->lts.y[533] == 'g' &&
    obj[8]->lts.y[534] == 't' &&
    obj[8]->lts.y[535] == 's' &&
    obj[8]->lts.y[536] == 'x' &&
    obj[8]->lts.y[537] == 'h' &&
    obj[8]->lts.y[538] == 'b' &&
    obj[8]->lts.y[539] == 'u' &&
    obj[8]->lts.y[540] == 'y' &&
    obj[8]->lts.x[808] == 'a' &&
    obj[8]->lti.y[516] == 100 &&
    obj[8]->lti.y[579] == 97 &&
    !strcmp(&obj[8]->lts.y[507], "dhdpwwwwgviqwlvpkbebhpwsicgtsxhbuy") &&
    !strcmp(&obj[8]->lts.y[411], "puwbmosfbkuxpjmeyxhmkvpreieeetblktkhykymttbe") &&
    !strcmp(&obj[8]->lts.x[808], "a") &&
    obj[9] == NULL)
        printf("*** pruned branch taken");
}

int main() {
	struct HighType** ht = malloc(10 * sizeof(struct HighType*));
	doMallocs(ht);
	initialize(ht);
	branchPruned(ht);
	// branchNotPruned(ht);
}
