/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

//ht points to an array of pointers to struct type of size 20. ht[11] and ht[13] are passed as an argument to an external function in function initialize. Therefore ht[11] and ht[13] become non-constant and branch in branchNotPruned function is not pruned. Rest of the array is constant so the branch in branchPruned function is pruned.

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
    obj[1]->lti->y[20] = 102;
    obj[1]->lti->x[426] = 104;
    memcpy(&obj[1]->lts->y[140], "zxawjtggqtomh", 13);
    obj[1]->lti->x[16] = 106;
    memcpy(&obj[1]->lts->x[946], "qmopjlpjfbckzeuvntchdmmnjzle", 28);
    memcpy(&obj[1]->lts->y[291], "copjbieaazzvnwpqrfysdsqcgxmmyarpbnau", 36);
    memcpy(&obj[1]->lts->y[794], "iyjqmaotagfqdmaxqveksfaiabcpicedhm", 34);
    memcpy(&obj[1]->lts->y[987], "uenkufbwl", 9);
    memcpy(&obj[1]->lts->x[877], "spwbdhpwwatwrpmtfdbkojwsyqsbmodersokpfu", 39);
    memcpy(&obj[1]->lts->x[314], "mculjqncxjajbunnt", 17);
    obj[2]->lti->y[883] = 100;
    memcpy(&obj[2]->lts->x[954], "ght", 3);
    obj[2]->lti->y[855] = 122;
    memcpy(&obj[2]->lts->y[556], "sdsxrpnzggvbjjlfwcffgjvdoppgycwijujfwl", 38);
    memcpy(&obj[2]->lts->y[7], "gkskftqqqbpccuatdczmzij", 23);
    obj[2]->lti->y[689] = 113;
    obj[2]->lti->x[447] = 107;
    obj[2]->lti->x[368] = 97;
    memcpy(&obj[2]->lts->x[457], "bltkgaakueekzbxynziqipaprcthxgtepf", 34);
    obj[2]->lti->x[764] = 115;
    memcpy(&obj[3]->lts->y[995], "ek", 2);
    obj[3]->lti->x[756] = 117;
    memcpy(&obj[3]->lts->x[114], "ggitc", 5);
    obj[3]->lti->y[425] = 99;
    obj[3]->lti->x[439] = 121;
    obj[3]->lti->y[614] = 98;
    memcpy(&obj[3]->lts->x[366], "zcjxh", 5);
    memcpy(&obj[3]->lts->y[996], "udfh", 4);
    obj[3]->lti->y[87] = 114;
    obj[3]->lti->x[423] = 121;
    memcpy(&obj[4]->lts->x[100], "bzdmbmmqvxoczqzocuvzecazlcbiptaisdpwasjncgt", 43);
    obj[4]->lti->y[214] = 119;
    memcpy(&obj[4]->lts->x[41], "zeooidznzhlpslhcjqjepiocqbchzsl", 31);
    memcpy(&obj[4]->lts->x[574], "thktikerxixopklqipbiycogfqsrfajtpvdzafjwrmm", 43);
    obj[4]->lti->y[478] = 109;
    obj[4]->lti->x[577] = 107;
    obj[4]->lti->y[194] = 108;
    memcpy(&obj[4]->lts->y[468], "wamsjyjnlkgpsradzoqleillvt", 26);
    memcpy(&obj[4]->lts->y[461], "fwpzssl", 7);
    memcpy(&obj[4]->lts->y[73], "tnqgqoy", 7);
    memcpy(&obj[5]->lts->x[693], "gztdeambpdjcdggpflvlricyksuvhjlrhltpywxor", 41);
    obj[5]->lti->y[458] = 100;
    memcpy(&obj[5]->lts->x[146], "jtfkdyzahqclrdntnfi", 19);
    memcpy(&obj[5]->lts->y[328], "mmlyumyvybjtcvvgwtyqpxannmdlwtikl", 33);
    obj[5]->lti->x[898] = 105;
    obj[5]->lti->x[714] = 113;
    obj[5]->lti->y[516] = 100;
    memcpy(&obj[5]->lts->x[808], "a", 1);
    obj[5]->lti->y[579] = 97;
    memcpy(&obj[5]->lts->y[507], "dhdpwwwwgviqwlvpkbebhpwsicgtsxhbuy", 34);
    memcpy(&obj[6]->lts->y[411], "puwbmosfbkuxpjmeyxhmkvpreieeetblktkhykymttbe", 44);
    obj[6]->lti->x[350] = 112;
    memcpy(&obj[6]->lts->y[179], "luyuvdvjtgnsxnuderyn", 20);
    obj[6]->lti->y[537] = 104;
    obj[6]->lti->x[597] = 121;
    memcpy(&obj[6]->lts->x[34], "nb", 2);
    obj[6]->lti->y[431] = 109;
    obj[6]->lti->y[590] = 110;
    memcpy(&obj[6]->lts->x[254], "opsdoiqvkucuwkpdkpjqbofxgomx", 28);
    obj[6]->lti->x[810] = 97;
    obj[7]->lti->x[263] = 99;
    obj[7]->lti->x[91] = 118;
    obj[7]->lti->x[874] = 112;
    obj[7]->lti->x[145] = 105;
    obj[7]->lti->x[356] = 107;
    obj[7]->lti->y[526] = 109;
    memcpy(&obj[7]->lts->y[627], "mofiepja", 8);
    memcpy(&obj[7]->lts->y[326], "cgswjcf", 7);
    obj[7]->lti->x[636] = 97;
    obj[7]->lti->x[494] = 115;
    memcpy(&obj[8]->lts->x[228], "mqlfywjjaixfwyap", 16);
    obj[8]->lti->y[327] = 119;
    obj[8]->lti->x[606] = 111;
    memcpy(&obj[8]->lts->x[796], "ykbxbiatixtriqbdaqqkycrapvkiwxpujcihforwuyyej", 45);
    obj[8]->lti->x[148] = 108;
    memcpy(&obj[8]->lts->x[458], "zvhhkgabiwsgbulyznbhxtmywhiibgmnbeueztqwiy", 42);
    memcpy(&obj[8]->lts->y[276], "cfklctmtkm", 10);
    memcpy(&obj[8]->lts->y[105], "gedptirrrvkvvfzrhanauixlhtoiaknfdjhkblt", 39);
    memcpy(&obj[8]->lts->x[288], "wzofb", 5);
    obj[8]->lti->x[626] = 100;
    obj[10]->lti->x[366] = 102;
    memcpy(&obj[10]->lts->y[375], "lphbvexqqacuxg", 14);
    memcpy(&obj[10]->lts->x[53], "qiuzyqpxgqeahd", 14);
    obj[10]->lti->y[610] = 106;
    obj[10]->lti->x[413] = 117;
    obj[10]->lti->x[377] = 117;
    memcpy(&obj[10]->lts->y[260], "syngztabseaaisvstne", 19);
    obj[10]->lti->y[633] = 109;
    memcpy(&obj[10]->lts->y[336], "rlfzcsxqctaopcgoeqpbzygcfjsldixul", 33);
    obj[10]->lti->x[29] = 119;
    memcpy(&obj[11]->lts->x[908], "amqskfkkcaaudkbrjdainrsxsnpsaprlknkc", 36);
    obj[11]->lti->y[301] = 102;
    memcpy(&obj[11]->lts->x[26], "zzkmxqukwngkkcsvqxqapohadttgh", 29);
    memcpy(&obj[11]->lts->y[508], "zxnbkcboyazwarapwe", 18);
    externalFunc(obj[11]);
    memcpy(&obj[11]->lts->x[402], "nyligultfqbuyqyrspaehsvpqxmmtu", 30);
    obj[11]->lti->y[810] = 105;
    obj[11]->lti->x[412] = 105;
    obj[11]->lti->y[696] = 98;
    memcpy(&obj[11]->lts->x[446], "jopzbhvatyqefxtzebutnsqjwhehqx", 30);
    obj[12]->lti->x[309] = 109;
    memcpy(&obj[12]->lts->y[801], "ywipkbhtminiuxqyruvwkqogsnzcmyesacdrmlabltes", 44);
    memcpy(&obj[12]->lts->y[671], "wxpgkwpfsdu", 11);
    memcpy(&obj[12]->lts->y[133], "naotumqmyjnxuycp", 16);
    memcpy(&obj[12]->lts->x[134], "focopk", 6);
    memcpy(&obj[12]->lts->x[361], "blfjqktoejchgkeqmian", 20);
    obj[12]->lti->y[73] = 106;
    obj[12]->lti->x[458] = 114;
    memcpy(&obj[12]->lts->x[473], "urljxzfldenlpimwcfxjnarpvucaumwdw", 33);
    memcpy(&obj[12]->lts->y[11], "lwhanyjmfxpgvtmldpdbqndgewzztzltwjpyhhswvlusp", 45);
    memcpy(&obj[13]->lts->x[412], "ricgonbwootvkmudkvjogrditsqlxpxnnkuyjqjrhcnkzrfwhs", 50);
    memcpy(&obj[13]->lts->y[575], "cvijtuiaavbmlhxzutdbxdayehqxqhepp", 33);
    obj[13]->lti->x[959] = 108;
    obj[13]->lti->x[73] = 102;
    obj[13]->lti->x[741] = 99;
    obj[13]->lti->x[596] = 104;
    obj[13]->lti->x[358] = 121;
    memcpy(&obj[13]->lts->x[24], "xkftcfpctxwdknbwrrq", 19);
    externalFunc(obj[13]);
    obj[13]->lti->x[909] = 120;
    memcpy(&obj[14]->lts->x[145], "moeaamgvgwbugjvezdvkargzvudurjimsdvi", 36);
    obj[14]->lti->y[663] = 101;
    obj[14]->lti->y[994] = 114;
    memcpy(&obj[14]->lts->x[420], "khwzfi", 6);
    memcpy(&obj[14]->lts->y[173], "jfgvscjbeskuzexelbuopmcvknskyazbmvfqfngdghxpfsrqkz", 50);
    memcpy(&obj[14]->lts->x[150], "gowywoaqierfwcxtkkxi", 20);
    memcpy(&obj[14]->lts->x[852], "uaoosrvcseymqbgraahlxqagbpxli", 29);
    obj[14]->lti->x[444] = 116;
    memcpy(&obj[14]->lts->y[991], "hwehrfcp", 8);
    obj[14]->lti->x[535] = 106;
    obj[15]->lti->x[829] = 114;
    memcpy(&obj[15]->lts->x[405], "htxurilqnsljvwupvneiefvcfomufilsofsgahdlabi", 43);
    memcpy(&obj[15]->lts->y[45], "wqkmpsxbvbvibeqmnxgajzlxtfuprmamuwuayfibzpx", 43);
    obj[15]->lti->x[267] = 101;
    memcpy(&obj[15]->lts->y[902], "yxossqvrakazuvqzjjcbhddeedailhjqnsygpdugpt", 42);
    obj[15]->lti->x[57] = 105;
    obj[15]->lti->x[655] = 117;
    obj[15]->lti->x[757] = 100;
    obj[15]->lti->x[961] = 103;
    memcpy(&obj[15]->lts->y[787], "byhedvj", 7);
    obj[16]->lti->x[650] = 105;
    memcpy(&obj[16]->lts->x[68], "yedyflgepfdnwihjwhlxmsiwjmbsbuwrirmygvsa", 40);
    memcpy(&obj[16]->lts->x[976], "ubolpdmldesbkimvp", 17);
    memcpy(&obj[16]->lts->y[372], "futnewcfwwkvnmnj", 16);
    obj[16]->lti->x[342] = 111;
    memcpy(&obj[16]->lts->y[830], "tzddiybkhhdzcsqzdt", 18);
    obj[16]->lti->x[928] = 112;
    obj[16]->lti->x[155] = 119;
    obj[16]->lti->x[384] = 120;
    obj[16]->lti->x[127] = 103;
    obj[17]->lti->x[998] = 117;
    memcpy(&obj[17]->lts->y[934], "kdntgpsehtiezsmnwklqpadgc", 25);
    memcpy(&obj[17]->lts->y[874], "uh", 2);
    memcpy(&obj[17]->lts->x[373], "zhlprzbrioqqkvvoeyyohqoudgsgooxphwzimnseeq", 42);
    memcpy(&obj[17]->lts->x[303], "tuokvvtrgjzpzkugqlmkdxhcsfbbwpqutf", 34);
    obj[17]->lti->y[730] = 114;
    memcpy(&obj[17]->lts->y[5], "rknpbotdjvpoxzyr", 16);
    obj[17]->lti->y[739] = 122;
    obj[17]->lti->y[434] = 117;
    memcpy(&obj[17]->lts->y[293], "gpcdefq", 7);
    memcpy(&obj[18]->lts->y[777], "yagyommjjmyuvgmvzxxijwkukgabdj", 30);
    memcpy(&obj[18]->lts->x[206], "hrzpmtbpo", 9);
    memcpy(&obj[18]->lts->x[956], "pkroyynjreqaqekvgoudnhpeuomztyit", 32);
    obj[18]->lti->x[254] = 117;
    obj[18]->lti->x[66] = 107;
    obj[18]->lti->y[683] = 103;
    obj[18]->lti->y[404] = 112;
    memcpy(&obj[18]->lts->y[645], "ogtprj", 6);
    memcpy(&obj[18]->lts->y[841], "qekqdqzoqivlukbrdvdaogomyqhhbseknmuayuenmekacnpb", 48);
    memcpy(&obj[18]->lts->y[449], "crfqxvdoigcuwlpvqir", 19);
    memcpy(&obj[19]->lts->y[567], "fabxx", 5);
    memcpy(&obj[19]->lts->x[246], "qqlksqwqujnadwsubmwnndtgqpqzycmvvgfsxomvr", 41);
    obj[19]->lti->x[311] = 102;
    obj[19]->lti->y[750] = 109;
    obj[19]->lti->y[899] = 105;
    obj[19]->lti->x[286] = 119;
    obj[19]->lti->x[749] = 110;
    memcpy(&obj[19]->lts->y[333], "leijslikgmspunlzcgsvglorswdbeslcnpqqwhoeqhtmpo", 46);
    obj[19]->lti->x[925] = 117;
    memcpy(&obj[19]->lts->y[74], "tqfberbzvbuhmjbqjdujuxjzjyhpkufvqzuqhravmnydvdjiqj", 50);
}
void branchPruned(struct HighType** obj) {
    if(obj[0] == NULL &&
    obj[1]->lts->y[140] == 'z' &&
    obj[1]->lts->y[141] == 'x' &&
    obj[1]->lts->y[142] == 'a' &&
    obj[1]->lts->y[143] == 'w' &&
    obj[1]->lts->y[144] == 'j' &&
    obj[1]->lts->y[145] == 't' &&
    obj[1]->lts->y[146] == 'g' &&
    obj[1]->lts->y[147] == 'g' &&
    obj[1]->lts->y[148] == 'q' &&
    obj[1]->lts->y[149] == 't' &&
    obj[1]->lts->y[150] == 'o' &&
    obj[1]->lts->y[151] == 'm' &&
    obj[1]->lts->y[152] == 'h' &&
    obj[1]->lts->y[291] == 'c' &&
    obj[1]->lts->y[292] == 'o' &&
    obj[1]->lts->y[293] == 'p' &&
    obj[1]->lts->y[294] == 'j' &&
    obj[1]->lts->y[295] == 'b' &&
    obj[1]->lts->y[296] == 'i' &&
    obj[1]->lts->y[297] == 'e' &&
    obj[1]->lts->y[298] == 'a' &&
    obj[1]->lts->y[299] == 'a' &&
    obj[1]->lts->y[300] == 'z' &&
    obj[1]->lts->y[301] == 'z' &&
    obj[1]->lts->y[302] == 'v' &&
    obj[1]->lts->y[303] == 'n' &&
    obj[1]->lts->y[304] == 'w' &&
    obj[1]->lts->y[305] == 'p' &&
    obj[1]->lts->y[306] == 'q' &&
    obj[1]->lts->y[307] == 'r' &&
    obj[1]->lts->y[308] == 'f' &&
    obj[1]->lts->y[309] == 'y' &&
    obj[1]->lts->y[310] == 's' &&
    obj[1]->lts->y[311] == 'd' &&
    obj[1]->lts->y[312] == 's' &&
    obj[1]->lts->y[313] == 'q' &&
    obj[1]->lts->y[314] == 'c' &&
    obj[1]->lts->y[315] == 'g' &&
    obj[1]->lts->y[316] == 'x' &&
    obj[1]->lts->y[317] == 'm' &&
    obj[1]->lts->y[318] == 'm' &&
    obj[1]->lts->y[319] == 'y' &&
    obj[1]->lts->y[320] == 'a' &&
    obj[1]->lts->y[321] == 'r' &&
    obj[1]->lts->y[322] == 'p' &&
    obj[1]->lts->y[323] == 'b' &&
    obj[1]->lts->y[324] == 'n' &&
    obj[1]->lts->y[325] == 'a' &&
    obj[1]->lts->y[326] == 'u' &&
    obj[1]->lts->y[794] == 'i' &&
    obj[1]->lts->y[795] == 'y' &&
    obj[1]->lts->y[796] == 'j' &&
    obj[1]->lts->y[797] == 'q' &&
    obj[1]->lts->y[798] == 'm' &&
    obj[1]->lts->y[799] == 'a' &&
    obj[1]->lts->y[800] == 'o' &&
    obj[1]->lts->y[801] == 't' &&
    obj[1]->lts->y[802] == 'a' &&
    obj[1]->lts->y[803] == 'g' &&
    obj[1]->lts->y[804] == 'f' &&
    obj[1]->lts->y[805] == 'q' &&
    obj[1]->lts->y[806] == 'd' &&
    obj[1]->lts->y[807] == 'm' &&
    obj[1]->lts->y[808] == 'a' &&
    obj[1]->lts->y[809] == 'x' &&
    obj[1]->lts->y[810] == 'q' &&
    obj[1]->lts->y[811] == 'v' &&
    obj[1]->lts->y[812] == 'e' &&
    obj[1]->lts->y[813] == 'k' &&
    obj[1]->lts->y[814] == 's' &&
    obj[1]->lts->y[815] == 'f' &&
    obj[1]->lts->y[816] == 'a' &&
    obj[1]->lts->y[817] == 'i' &&
    obj[1]->lts->y[818] == 'a' &&
    obj[1]->lts->y[819] == 'b' &&
    obj[1]->lts->y[820] == 'c' &&
    obj[1]->lts->y[821] == 'p' &&
    obj[1]->lts->y[822] == 'i' &&
    obj[1]->lts->y[823] == 'c' &&
    obj[1]->lts->y[824] == 'e' &&
    obj[1]->lts->y[825] == 'd' &&
    obj[1]->lts->y[826] == 'h' &&
    obj[1]->lts->y[827] == 'm' &&
    obj[1]->lts->y[987] == 'u' &&
    obj[1]->lts->y[988] == 'e' &&
    obj[1]->lts->y[989] == 'n' &&
    obj[1]->lts->y[990] == 'k' &&
    obj[1]->lts->y[991] == 'u' &&
    obj[1]->lts->y[992] == 'f' &&
    obj[1]->lts->y[993] == 'b' &&
    obj[1]->lts->y[994] == 'w' &&
    obj[1]->lts->y[995] == 'l' &&
    obj[1]->lts->x[314] == 'm' &&
    obj[1]->lts->x[315] == 'c' &&
    obj[1]->lts->x[316] == 'u' &&
    obj[1]->lts->x[317] == 'l' &&
    obj[1]->lts->x[318] == 'j' &&
    obj[1]->lts->x[319] == 'q' &&
    obj[1]->lts->x[320] == 'n' &&
    obj[1]->lts->x[321] == 'c' &&
    obj[1]->lts->x[322] == 'x' &&
    obj[1]->lts->x[323] == 'j' &&
    obj[1]->lts->x[324] == 'a' &&
    obj[1]->lts->x[325] == 'j' &&
    obj[1]->lts->x[326] == 'b' &&
    obj[1]->lts->x[327] == 'u' &&
    obj[1]->lts->x[328] == 'n' &&
    obj[1]->lts->x[329] == 'n' &&
    obj[1]->lts->x[330] == 't' &&
    obj[1]->lts->x[877] == 's' &&
    obj[1]->lts->x[878] == 'p' &&
    obj[1]->lts->x[879] == 'w' &&
    obj[1]->lts->x[880] == 'b' &&
    obj[1]->lts->x[881] == 'd' &&
    obj[1]->lts->x[882] == 'h' &&
    obj[1]->lts->x[883] == 'p' &&
    obj[1]->lts->x[884] == 'w' &&
    obj[1]->lts->x[885] == 'w' &&
    obj[1]->lts->x[886] == 'a' &&
    obj[1]->lts->x[887] == 't' &&
    obj[1]->lts->x[888] == 'w' &&
    obj[1]->lts->x[889] == 'r' &&
    obj[1]->lts->x[890] == 'p' &&
    obj[1]->lts->x[891] == 'm' &&
    obj[1]->lts->x[892] == 't' &&
    obj[1]->lts->x[893] == 'f' &&
    obj[1]->lts->x[894] == 'd' &&
    obj[1]->lts->x[895] == 'b' &&
    obj[1]->lts->x[896] == 'k' &&
    obj[1]->lts->x[897] == 'o' &&
    obj[1]->lts->x[898] == 'j' &&
    obj[1]->lts->x[899] == 'w' &&
    obj[1]->lts->x[900] == 's' &&
    obj[1]->lts->x[901] == 'y' &&
    obj[1]->lts->x[902] == 'q' &&
    obj[1]->lts->x[903] == 's' &&
    obj[1]->lts->x[904] == 'b' &&
    obj[1]->lts->x[905] == 'm' &&
    obj[1]->lts->x[906] == 'o' &&
    obj[1]->lts->x[907] == 'd' &&
    obj[1]->lts->x[908] == 'e' &&
    obj[1]->lts->x[909] == 'r' &&
    obj[1]->lts->x[910] == 's' &&
    obj[1]->lts->x[911] == 'o' &&
    obj[1]->lts->x[912] == 'k' &&
    obj[1]->lts->x[913] == 'p' &&
    obj[1]->lts->x[914] == 'f' &&
    obj[1]->lts->x[915] == 'u' &&
    obj[1]->lts->x[946] == 'q' &&
    obj[1]->lts->x[947] == 'm' &&
    obj[1]->lts->x[948] == 'o' &&
    obj[1]->lts->x[949] == 'p' &&
    obj[1]->lts->x[950] == 'j' &&
    obj[1]->lts->x[951] == 'l' &&
    obj[1]->lts->x[952] == 'p' &&
    obj[1]->lts->x[953] == 'j' &&
    obj[1]->lts->x[954] == 'f' &&
    obj[1]->lts->x[955] == 'b' &&
    obj[1]->lts->x[956] == 'c' &&
    obj[1]->lts->x[957] == 'k' &&
    obj[1]->lts->x[958] == 'z' &&
    obj[1]->lts->x[959] == 'e' &&
    obj[1]->lts->x[960] == 'u' &&
    obj[1]->lts->x[961] == 'v' &&
    obj[1]->lts->x[962] == 'n' &&
    obj[1]->lts->x[963] == 't' &&
    obj[1]->lts->x[964] == 'c' &&
    obj[1]->lts->x[965] == 'h' &&
    obj[1]->lts->x[966] == 'd' &&
    obj[1]->lts->x[967] == 'm' &&
    obj[1]->lts->x[968] == 'm' &&
    obj[1]->lts->x[969] == 'n' &&
    obj[1]->lts->x[970] == 'j' &&
    obj[1]->lts->x[971] == 'z' &&
    obj[1]->lts->x[972] == 'l' &&
    obj[1]->lts->x[973] == 'e' &&
    obj[1]->lti->y[20] == 102 &&
    obj[1]->lti->x[16] == 106 &&
    obj[1]->lti->x[426] == 104 &&
    !strcmp(&obj[1]->lts->y[140], "zxawjtggqtomh") &&
    !strcmp(&obj[1]->lts->y[291], "copjbieaazzvnwpqrfysdsqcgxmmyarpbnau") &&
    !strcmp(&obj[1]->lts->y[794], "iyjqmaotagfqdmaxqveksfaiabcpicedhm") &&
    !strcmp(&obj[1]->lts->y[987], "uenkufbwl") &&
    !strcmp(&obj[1]->lts->x[946], "qmopjlpjfbckzeuvntchdmmnjzle") &&
    !strcmp(&obj[1]->lts->x[877], "spwbdhpwwatwrpmtfdbkojwsyqsbmodersokpfu") &&
    !strcmp(&obj[1]->lts->x[314], "mculjqncxjajbunnt") &&
    obj[2]->lts->y[7] == 'g' &&
    obj[2]->lts->y[8] == 'k' &&
    obj[2]->lts->y[9] == 's' &&
    obj[2]->lts->y[10] == 'k' &&
    obj[2]->lts->y[11] == 'f' &&
    obj[2]->lts->y[12] == 't' &&
    obj[2]->lts->y[13] == 'q' &&
    obj[2]->lts->y[14] == 'q' &&
    obj[2]->lts->y[15] == 'q' &&
    obj[2]->lts->y[16] == 'b' &&
    obj[2]->lts->y[17] == 'p' &&
    obj[2]->lts->y[18] == 'c' &&
    obj[2]->lts->y[19] == 'c' &&
    obj[2]->lts->y[20] == 'u' &&
    obj[2]->lts->y[21] == 'a' &&
    obj[2]->lts->y[22] == 't' &&
    obj[2]->lts->y[23] == 'd' &&
    obj[2]->lts->y[24] == 'c' &&
    obj[2]->lts->y[25] == 'z' &&
    obj[2]->lts->y[26] == 'm' &&
    obj[2]->lts->y[27] == 'z' &&
    obj[2]->lts->y[28] == 'i' &&
    obj[2]->lts->y[29] == 'j' &&
    obj[2]->lts->y[556] == 's' &&
    obj[2]->lts->y[557] == 'd' &&
    obj[2]->lts->y[558] == 's' &&
    obj[2]->lts->y[559] == 'x' &&
    obj[2]->lts->y[560] == 'r' &&
    obj[2]->lts->y[561] == 'p' &&
    obj[2]->lts->y[562] == 'n' &&
    obj[2]->lts->y[563] == 'z' &&
    obj[2]->lts->y[564] == 'g' &&
    obj[2]->lts->y[565] == 'g' &&
    obj[2]->lts->y[566] == 'v' &&
    obj[2]->lts->y[567] == 'b' &&
    obj[2]->lts->y[568] == 'j' &&
    obj[2]->lts->y[569] == 'j' &&
    obj[2]->lts->y[570] == 'l' &&
    obj[2]->lts->y[571] == 'f' &&
    obj[2]->lts->y[572] == 'w' &&
    obj[2]->lts->y[573] == 'c' &&
    obj[2]->lts->y[574] == 'f' &&
    obj[2]->lts->y[575] == 'f' &&
    obj[2]->lts->y[576] == 'g' &&
    obj[2]->lts->y[577] == 'j' &&
    obj[2]->lts->y[578] == 'v' &&
    obj[2]->lts->y[579] == 'd' &&
    obj[2]->lts->y[580] == 'o' &&
    obj[2]->lts->y[581] == 'p' &&
    obj[2]->lts->y[582] == 'p' &&
    obj[2]->lts->y[583] == 'g' &&
    obj[2]->lts->y[584] == 'y' &&
    obj[2]->lts->y[585] == 'c' &&
    obj[2]->lts->y[586] == 'w' &&
    obj[2]->lts->y[587] == 'i' &&
    obj[2]->lts->y[588] == 'j' &&
    obj[2]->lts->y[589] == 'u' &&
    obj[2]->lts->y[590] == 'j' &&
    obj[2]->lts->y[591] == 'f' &&
    obj[2]->lts->y[592] == 'w' &&
    obj[2]->lts->y[593] == 'l' &&
    obj[2]->lts->x[457] == 'b' &&
    obj[2]->lts->x[458] == 'l' &&
    obj[2]->lts->x[459] == 't' &&
    obj[2]->lts->x[460] == 'k' &&
    obj[2]->lts->x[461] == 'g' &&
    obj[2]->lts->x[462] == 'a' &&
    obj[2]->lts->x[463] == 'a' &&
    obj[2]->lts->x[464] == 'k' &&
    obj[2]->lts->x[465] == 'u' &&
    obj[2]->lts->x[466] == 'e' &&
    obj[2]->lts->x[467] == 'e' &&
    obj[2]->lts->x[468] == 'k' &&
    obj[2]->lts->x[469] == 'z' &&
    obj[2]->lts->x[470] == 'b' &&
    obj[2]->lts->x[471] == 'x' &&
    obj[2]->lts->x[472] == 'y' &&
    obj[2]->lts->x[473] == 'n' &&
    obj[2]->lts->x[474] == 'z' &&
    obj[2]->lts->x[475] == 'i' &&
    obj[2]->lts->x[476] == 'q' &&
    obj[2]->lts->x[477] == 'i' &&
    obj[2]->lts->x[478] == 'p' &&
    obj[2]->lts->x[479] == 'a' &&
    obj[2]->lts->x[480] == 'p' &&
    obj[2]->lts->x[481] == 'r' &&
    obj[2]->lts->x[482] == 'c' &&
    obj[2]->lts->x[483] == 't' &&
    obj[2]->lts->x[484] == 'h' &&
    obj[2]->lts->x[485] == 'x' &&
    obj[2]->lts->x[486] == 'g' &&
    obj[2]->lts->x[487] == 't' &&
    obj[2]->lts->x[488] == 'e' &&
    obj[2]->lts->x[489] == 'p' &&
    obj[2]->lts->x[490] == 'f' &&
    obj[2]->lts->x[954] == 'g' &&
    obj[2]->lts->x[955] == 'h' &&
    obj[2]->lts->x[956] == 't' &&
    obj[2]->lti->y[689] == 113 &&
    obj[2]->lti->y[855] == 122 &&
    obj[2]->lti->y[883] == 100 &&
    obj[2]->lti->x[368] == 97 &&
    obj[2]->lti->x[447] == 107 &&
    obj[2]->lti->x[764] == 115 &&
    !strcmp(&obj[2]->lts->y[556], "sdsxrpnzggvbjjlfwcffgjvdoppgycwijujfwl") &&
    !strcmp(&obj[2]->lts->y[7], "gkskftqqqbpccuatdczmzij") &&
    !strcmp(&obj[2]->lts->x[954], "ght") &&
    !strcmp(&obj[2]->lts->x[457], "bltkgaakueekzbxynziqipaprcthxgtepf") &&
    obj[3]->lts->y[995] == 'e' &&
    obj[3]->lts->y[996] == 'u' &&
    obj[3]->lts->y[997] == 'd' &&
    obj[3]->lts->y[998] == 'f' &&
    obj[3]->lts->y[999] == 'h' &&
    obj[3]->lts->x[114] == 'g' &&
    obj[3]->lts->x[115] == 'g' &&
    obj[3]->lts->x[116] == 'i' &&
    obj[3]->lts->x[117] == 't' &&
    obj[3]->lts->x[118] == 'c' &&
    obj[3]->lts->x[366] == 'z' &&
    obj[3]->lts->x[367] == 'c' &&
    obj[3]->lts->x[368] == 'j' &&
    obj[3]->lts->x[369] == 'x' &&
    obj[3]->lts->x[370] == 'h' &&
    obj[3]->lti->y[87] == 114 &&
    obj[3]->lti->y[425] == 99 &&
    obj[3]->lti->y[614] == 98 &&
    obj[3]->lti->x[423] == 121 &&
    obj[3]->lti->x[439] == 121 &&
    obj[3]->lti->x[756] == 117 &&
    !strcmp(&obj[3]->lts->y[995], "eudfh") &&
    !strcmp(&obj[3]->lts->x[114], "ggitc") &&
    !strcmp(&obj[3]->lts->x[366], "zcjxh") &&
    obj[4]->lts->y[73] == 't' &&
    obj[4]->lts->y[74] == 'n' &&
    obj[4]->lts->y[75] == 'q' &&
    obj[4]->lts->y[76] == 'g' &&
    obj[4]->lts->y[77] == 'q' &&
    obj[4]->lts->y[78] == 'o' &&
    obj[4]->lts->y[79] == 'y' &&
    obj[4]->lts->y[461] == 'f' &&
    obj[4]->lts->y[462] == 'w' &&
    obj[4]->lts->y[463] == 'p' &&
    obj[4]->lts->y[464] == 'z' &&
    obj[4]->lts->y[465] == 's' &&
    obj[4]->lts->y[466] == 's' &&
    obj[4]->lts->y[467] == 'l' &&
    obj[4]->lts->y[468] == 'w' &&
    obj[4]->lts->y[469] == 'a' &&
    obj[4]->lts->y[470] == 'm' &&
    obj[4]->lts->y[471] == 's' &&
    obj[4]->lts->y[472] == 'j' &&
    obj[4]->lts->y[473] == 'y' &&
    obj[4]->lts->y[474] == 'j' &&
    obj[4]->lts->y[475] == 'n' &&
    obj[4]->lts->y[476] == 'l' &&
    obj[4]->lts->y[477] == 'k' &&
    obj[4]->lts->y[478] == 'g' &&
    obj[4]->lts->y[479] == 'p' &&
    obj[4]->lts->y[480] == 's' &&
    obj[4]->lts->y[481] == 'r' &&
    obj[4]->lts->y[482] == 'a' &&
    obj[4]->lts->y[483] == 'd' &&
    obj[4]->lts->y[484] == 'z' &&
    obj[4]->lts->y[485] == 'o' &&
    obj[4]->lts->y[486] == 'q' &&
    obj[4]->lts->y[487] == 'l' &&
    obj[4]->lts->y[488] == 'e' &&
    obj[4]->lts->y[489] == 'i' &&
    obj[4]->lts->y[490] == 'l' &&
    obj[4]->lts->y[491] == 'l' &&
    obj[4]->lts->y[492] == 'v' &&
    obj[4]->lts->y[493] == 't' &&
    obj[4]->lts->x[41] == 'z' &&
    obj[4]->lts->x[42] == 'e' &&
    obj[4]->lts->x[43] == 'o' &&
    obj[4]->lts->x[44] == 'o' &&
    obj[4]->lts->x[45] == 'i' &&
    obj[4]->lts->x[46] == 'd' &&
    obj[4]->lts->x[47] == 'z' &&
    obj[4]->lts->x[48] == 'n' &&
    obj[4]->lts->x[49] == 'z' &&
    obj[4]->lts->x[50] == 'h' &&
    obj[4]->lts->x[51] == 'l' &&
    obj[4]->lts->x[52] == 'p' &&
    obj[4]->lts->x[53] == 's' &&
    obj[4]->lts->x[54] == 'l' &&
    obj[4]->lts->x[55] == 'h' &&
    obj[4]->lts->x[56] == 'c' &&
    obj[4]->lts->x[57] == 'j' &&
    obj[4]->lts->x[58] == 'q' &&
    obj[4]->lts->x[59] == 'j' &&
    obj[4]->lts->x[60] == 'e' &&
    obj[4]->lts->x[61] == 'p' &&
    obj[4]->lts->x[62] == 'i' &&
    obj[4]->lts->x[63] == 'o' &&
    obj[4]->lts->x[64] == 'c' &&
    obj[4]->lts->x[65] == 'q' &&
    obj[4]->lts->x[66] == 'b' &&
    obj[4]->lts->x[67] == 'c' &&
    obj[4]->lts->x[68] == 'h' &&
    obj[4]->lts->x[69] == 'z' &&
    obj[4]->lts->x[70] == 's' &&
    obj[4]->lts->x[71] == 'l' &&
    obj[4]->lts->x[100] == 'b' &&
    obj[4]->lts->x[101] == 'z' &&
    obj[4]->lts->x[102] == 'd' &&
    obj[4]->lts->x[103] == 'm' &&
    obj[4]->lts->x[104] == 'b' &&
    obj[4]->lts->x[105] == 'm' &&
    obj[4]->lts->x[106] == 'm' &&
    obj[4]->lts->x[107] == 'q' &&
    obj[4]->lts->x[108] == 'v' &&
    obj[4]->lts->x[109] == 'x' &&
    obj[4]->lts->x[110] == 'o' &&
    obj[4]->lts->x[111] == 'c' &&
    obj[4]->lts->x[112] == 'z' &&
    obj[4]->lts->x[113] == 'q' &&
    obj[4]->lts->x[114] == 'z' &&
    obj[4]->lts->x[115] == 'o' &&
    obj[4]->lts->x[116] == 'c' &&
    obj[4]->lts->x[117] == 'u' &&
    obj[4]->lts->x[118] == 'v' &&
    obj[4]->lts->x[119] == 'z' &&
    obj[4]->lts->x[120] == 'e' &&
    obj[4]->lts->x[121] == 'c' &&
    obj[4]->lts->x[122] == 'a' &&
    obj[4]->lts->x[123] == 'z' &&
    obj[4]->lts->x[124] == 'l' &&
    obj[4]->lts->x[125] == 'c' &&
    obj[4]->lts->x[126] == 'b' &&
    obj[4]->lts->x[127] == 'i' &&
    obj[4]->lts->x[128] == 'p' &&
    obj[4]->lts->x[129] == 't' &&
    obj[4]->lts->x[130] == 'a' &&
    obj[4]->lts->x[131] == 'i' &&
    obj[4]->lts->x[132] == 's' &&
    obj[4]->lts->x[133] == 'd' &&
    obj[4]->lts->x[134] == 'p' &&
    obj[4]->lts->x[135] == 'w' &&
    obj[4]->lts->x[136] == 'a' &&
    obj[4]->lts->x[137] == 's' &&
    obj[4]->lts->x[138] == 'j' &&
    obj[4]->lts->x[139] == 'n' &&
    obj[4]->lts->x[140] == 'c' &&
    obj[4]->lts->x[141] == 'g' &&
    obj[4]->lts->x[142] == 't' &&
    obj[4]->lts->x[574] == 't' &&
    obj[4]->lts->x[575] == 'h' &&
    obj[4]->lts->x[576] == 'k' &&
    obj[4]->lts->x[577] == 't' &&
    obj[4]->lts->x[578] == 'i' &&
    obj[4]->lts->x[579] == 'k' &&
    obj[4]->lts->x[580] == 'e' &&
    obj[4]->lts->x[581] == 'r' &&
    obj[4]->lts->x[582] == 'x' &&
    obj[4]->lts->x[583] == 'i' &&
    obj[4]->lts->x[584] == 'x' &&
    obj[4]->lts->x[585] == 'o' &&
    obj[4]->lts->x[586] == 'p' &&
    obj[4]->lts->x[587] == 'k' &&
    obj[4]->lts->x[588] == 'l' &&
    obj[4]->lts->x[589] == 'q' &&
    obj[4]->lts->x[590] == 'i' &&
    obj[4]->lts->x[591] == 'p' &&
    obj[4]->lts->x[592] == 'b' &&
    obj[4]->lts->x[593] == 'i' &&
    obj[4]->lts->x[594] == 'y' &&
    obj[4]->lts->x[595] == 'c' &&
    obj[4]->lts->x[596] == 'o' &&
    obj[4]->lts->x[597] == 'g' &&
    obj[4]->lts->x[598] == 'f' &&
    obj[4]->lts->x[599] == 'q' &&
    obj[4]->lts->x[600] == 's' &&
    obj[4]->lts->x[601] == 'r' &&
    obj[4]->lts->x[602] == 'f' &&
    obj[4]->lts->x[603] == 'a' &&
    obj[4]->lts->x[604] == 'j' &&
    obj[4]->lts->x[605] == 't' &&
    obj[4]->lts->x[606] == 'p' &&
    obj[4]->lts->x[607] == 'v' &&
    obj[4]->lts->x[608] == 'd' &&
    obj[4]->lts->x[609] == 'z' &&
    obj[4]->lts->x[610] == 'a' &&
    obj[4]->lts->x[611] == 'f' &&
    obj[4]->lts->x[612] == 'j' &&
    obj[4]->lts->x[613] == 'w' &&
    obj[4]->lts->x[614] == 'r' &&
    obj[4]->lts->x[615] == 'm' &&
    obj[4]->lts->x[616] == 'm' &&
    obj[4]->lti->y[194] == 108 &&
    obj[4]->lti->y[214] == 119 &&
    obj[4]->lti->y[478] == 109 &&
    obj[4]->lti->x[577] == 107 &&
    !strcmp(&obj[4]->lts->y[73], "tnqgqoy") &&
    !strcmp(&obj[4]->lts->y[461], "fwpzsslwamsjyjnlkgpsradzoqleillvt") &&
    !strcmp(&obj[4]->lts->x[100], "bzdmbmmqvxoczqzocuvzecazlcbiptaisdpwasjncgt") &&
    !strcmp(&obj[4]->lts->x[41], "zeooidznzhlpslhcjqjepiocqbchzsl") &&
    !strcmp(&obj[4]->lts->x[574], "thktikerxixopklqipbiycogfqsrfajtpvdzafjwrmm") &&
    obj[5]->lts->y[328] == 'm' &&
    obj[5]->lts->y[329] == 'm' &&
    obj[5]->lts->y[330] == 'l' &&
    obj[5]->lts->y[331] == 'y' &&
    obj[5]->lts->y[332] == 'u' &&
    obj[5]->lts->y[333] == 'm' &&
    obj[5]->lts->y[334] == 'y' &&
    obj[5]->lts->y[335] == 'v' &&
    obj[5]->lts->y[336] == 'y' &&
    obj[5]->lts->y[337] == 'b' &&
    obj[5]->lts->y[338] == 'j' &&
    obj[5]->lts->y[339] == 't' &&
    obj[5]->lts->y[340] == 'c' &&
    obj[5]->lts->y[341] == 'v' &&
    obj[5]->lts->y[342] == 'v' &&
    obj[5]->lts->y[343] == 'g' &&
    obj[5]->lts->y[344] == 'w' &&
    obj[5]->lts->y[345] == 't' &&
    obj[5]->lts->y[346] == 'y' &&
    obj[5]->lts->y[347] == 'q' &&
    obj[5]->lts->y[348] == 'p' &&
    obj[5]->lts->y[349] == 'x' &&
    obj[5]->lts->y[350] == 'a' &&
    obj[5]->lts->y[351] == 'n' &&
    obj[5]->lts->y[352] == 'n' &&
    obj[5]->lts->y[353] == 'm' &&
    obj[5]->lts->y[354] == 'd' &&
    obj[5]->lts->y[355] == 'l' &&
    obj[5]->lts->y[356] == 'w' &&
    obj[5]->lts->y[357] == 't' &&
    obj[5]->lts->y[358] == 'i' &&
    obj[5]->lts->y[359] == 'k' &&
    obj[5]->lts->y[360] == 'l' &&
    obj[5]->lts->y[507] == 'd' &&
    obj[5]->lts->y[508] == 'h' &&
    obj[5]->lts->y[509] == 'd' &&
    obj[5]->lts->y[510] == 'p' &&
    obj[5]->lts->y[511] == 'w' &&
    obj[5]->lts->y[512] == 'w' &&
    obj[5]->lts->y[513] == 'w' &&
    obj[5]->lts->y[514] == 'w' &&
    obj[5]->lts->y[515] == 'g' &&
    obj[5]->lts->y[516] == 'v' &&
    obj[5]->lts->y[517] == 'i' &&
    obj[5]->lts->y[518] == 'q' &&
    obj[5]->lts->y[519] == 'w' &&
    obj[5]->lts->y[520] == 'l' &&
    obj[5]->lts->y[521] == 'v' &&
    obj[5]->lts->y[522] == 'p' &&
    obj[5]->lts->y[523] == 'k' &&
    obj[5]->lts->y[524] == 'b' &&
    obj[5]->lts->y[525] == 'e' &&
    obj[5]->lts->y[526] == 'b' &&
    obj[5]->lts->y[527] == 'h' &&
    obj[5]->lts->y[528] == 'p' &&
    obj[5]->lts->y[529] == 'w' &&
    obj[5]->lts->y[530] == 's' &&
    obj[5]->lts->y[531] == 'i' &&
    obj[5]->lts->y[532] == 'c' &&
    obj[5]->lts->y[533] == 'g' &&
    obj[5]->lts->y[534] == 't' &&
    obj[5]->lts->y[535] == 's' &&
    obj[5]->lts->y[536] == 'x' &&
    obj[5]->lts->y[537] == 'h' &&
    obj[5]->lts->y[538] == 'b' &&
    obj[5]->lts->y[539] == 'u' &&
    obj[5]->lts->y[540] == 'y' &&
    obj[5]->lts->x[146] == 'j' &&
    obj[5]->lts->x[147] == 't' &&
    obj[5]->lts->x[148] == 'f' &&
    obj[5]->lts->x[149] == 'k' &&
    obj[5]->lts->x[150] == 'd' &&
    obj[5]->lts->x[151] == 'y' &&
    obj[5]->lts->x[152] == 'z' &&
    obj[5]->lts->x[153] == 'a' &&
    obj[5]->lts->x[154] == 'h' &&
    obj[5]->lts->x[155] == 'q' &&
    obj[5]->lts->x[156] == 'c' &&
    obj[5]->lts->x[157] == 'l' &&
    obj[5]->lts->x[158] == 'r' &&
    obj[5]->lts->x[159] == 'd' &&
    obj[5]->lts->x[160] == 'n' &&
    obj[5]->lts->x[161] == 't' &&
    obj[5]->lts->x[162] == 'n' &&
    obj[5]->lts->x[163] == 'f' &&
    obj[5]->lts->x[164] == 'i' &&
    obj[5]->lts->x[693] == 'g' &&
    obj[5]->lts->x[694] == 'z' &&
    obj[5]->lts->x[695] == 't' &&
    obj[5]->lts->x[696] == 'd' &&
    obj[5]->lts->x[697] == 'e' &&
    obj[5]->lts->x[698] == 'a' &&
    obj[5]->lts->x[699] == 'm' &&
    obj[5]->lts->x[700] == 'b' &&
    obj[5]->lts->x[701] == 'p' &&
    obj[5]->lts->x[702] == 'd' &&
    obj[5]->lts->x[703] == 'j' &&
    obj[5]->lts->x[704] == 'c' &&
    obj[5]->lts->x[705] == 'd' &&
    obj[5]->lts->x[706] == 'g' &&
    obj[5]->lts->x[707] == 'g' &&
    obj[5]->lts->x[708] == 'p' &&
    obj[5]->lts->x[709] == 'f' &&
    obj[5]->lts->x[710] == 'l' &&
    obj[5]->lts->x[711] == 'v' &&
    obj[5]->lts->x[712] == 'l' &&
    obj[5]->lts->x[713] == 'r' &&
    obj[5]->lts->x[714] == 'i' &&
    obj[5]->lts->x[715] == 'c' &&
    obj[5]->lts->x[716] == 'y' &&
    obj[5]->lts->x[717] == 'k' &&
    obj[5]->lts->x[718] == 's' &&
    obj[5]->lts->x[719] == 'u' &&
    obj[5]->lts->x[720] == 'v' &&
    obj[5]->lts->x[721] == 'h' &&
    obj[5]->lts->x[722] == 'j' &&
    obj[5]->lts->x[723] == 'l' &&
    obj[5]->lts->x[724] == 'r' &&
    obj[5]->lts->x[725] == 'h' &&
    obj[5]->lts->x[726] == 'l' &&
    obj[5]->lts->x[727] == 't' &&
    obj[5]->lts->x[728] == 'p' &&
    obj[5]->lts->x[729] == 'y' &&
    obj[5]->lts->x[730] == 'w' &&
    obj[5]->lts->x[731] == 'x' &&
    obj[5]->lts->x[732] == 'o' &&
    obj[5]->lts->x[733] == 'r' &&
    obj[5]->lts->x[808] == 'a' &&
    obj[5]->lti->y[458] == 100 &&
    obj[5]->lti->y[516] == 100 &&
    obj[5]->lti->y[579] == 97 &&
    obj[5]->lti->x[714] == 113 &&
    obj[5]->lti->x[898] == 105 &&
    !strcmp(&obj[5]->lts->y[328], "mmlyumyvybjtcvvgwtyqpxannmdlwtikl") &&
    !strcmp(&obj[5]->lts->y[507], "dhdpwwwwgviqwlvpkbebhpwsicgtsxhbuy") &&
    !strcmp(&obj[5]->lts->x[693], "gztdeambpdjcdggpflvlricyksuvhjlrhltpywxor") &&
    !strcmp(&obj[5]->lts->x[146], "jtfkdyzahqclrdntnfi") &&
    !strcmp(&obj[5]->lts->x[808], "a") &&
    obj[6]->lts->y[179] == 'l' &&
    obj[6]->lts->y[180] == 'u' &&
    obj[6]->lts->y[181] == 'y' &&
    obj[6]->lts->y[182] == 'u' &&
    obj[6]->lts->y[183] == 'v' &&
    obj[6]->lts->y[184] == 'd' &&
    obj[6]->lts->y[185] == 'v' &&
    obj[6]->lts->y[186] == 'j' &&
    obj[6]->lts->y[187] == 't' &&
    obj[6]->lts->y[188] == 'g' &&
    obj[6]->lts->y[189] == 'n' &&
    obj[6]->lts->y[190] == 's' &&
    obj[6]->lts->y[191] == 'x' &&
    obj[6]->lts->y[192] == 'n' &&
    obj[6]->lts->y[193] == 'u' &&
    obj[6]->lts->y[194] == 'd' &&
    obj[6]->lts->y[195] == 'e' &&
    obj[6]->lts->y[196] == 'r' &&
    obj[6]->lts->y[197] == 'y' &&
    obj[6]->lts->y[198] == 'n' &&
    obj[6]->lts->y[411] == 'p' &&
    obj[6]->lts->y[412] == 'u' &&
    obj[6]->lts->y[413] == 'w' &&
    obj[6]->lts->y[414] == 'b' &&
    obj[6]->lts->y[415] == 'm' &&
    obj[6]->lts->y[416] == 'o' &&
    obj[6]->lts->y[417] == 's' &&
    obj[6]->lts->y[418] == 'f' &&
    obj[6]->lts->y[419] == 'b' &&
    obj[6]->lts->y[420] == 'k' &&
    obj[6]->lts->y[421] == 'u' &&
    obj[6]->lts->y[422] == 'x' &&
    obj[6]->lts->y[423] == 'p' &&
    obj[6]->lts->y[424] == 'j' &&
    obj[6]->lts->y[425] == 'm' &&
    obj[6]->lts->y[426] == 'e' &&
    obj[6]->lts->y[427] == 'y' &&
    obj[6]->lts->y[428] == 'x' &&
    obj[6]->lts->y[429] == 'h' &&
    obj[6]->lts->y[430] == 'm' &&
    obj[6]->lts->y[431] == 'k' &&
    obj[6]->lts->y[432] == 'v' &&
    obj[6]->lts->y[433] == 'p' &&
    obj[6]->lts->y[434] == 'r' &&
    obj[6]->lts->y[435] == 'e' &&
    obj[6]->lts->y[436] == 'i' &&
    obj[6]->lts->y[437] == 'e' &&
    obj[6]->lts->y[438] == 'e' &&
    obj[6]->lts->y[439] == 'e' &&
    obj[6]->lts->y[440] == 't' &&
    obj[6]->lts->y[441] == 'b' &&
    obj[6]->lts->y[442] == 'l' &&
    obj[6]->lts->y[443] == 'k' &&
    obj[6]->lts->y[444] == 't' &&
    obj[6]->lts->y[445] == 'k' &&
    obj[6]->lts->y[446] == 'h' &&
    obj[6]->lts->y[447] == 'y' &&
    obj[6]->lts->y[448] == 'k' &&
    obj[6]->lts->y[449] == 'y' &&
    obj[6]->lts->y[450] == 'm' &&
    obj[6]->lts->y[451] == 't' &&
    obj[6]->lts->y[452] == 't' &&
    obj[6]->lts->y[453] == 'b' &&
    obj[6]->lts->y[454] == 'e' &&
    obj[6]->lts->x[34] == 'n' &&
    obj[6]->lts->x[35] == 'b' &&
    obj[6]->lts->x[254] == 'o' &&
    obj[6]->lts->x[255] == 'p' &&
    obj[6]->lts->x[256] == 's' &&
    obj[6]->lts->x[257] == 'd' &&
    obj[6]->lts->x[258] == 'o' &&
    obj[6]->lts->x[259] == 'i' &&
    obj[6]->lts->x[260] == 'q' &&
    obj[6]->lts->x[261] == 'v' &&
    obj[6]->lts->x[262] == 'k' &&
    obj[6]->lts->x[263] == 'u' &&
    obj[6]->lts->x[264] == 'c' &&
    obj[6]->lts->x[265] == 'u' &&
    obj[6]->lts->x[266] == 'w' &&
    obj[6]->lts->x[267] == 'k' &&
    obj[6]->lts->x[268] == 'p' &&
    obj[6]->lts->x[269] == 'd' &&
    obj[6]->lts->x[270] == 'k' &&
    obj[6]->lts->x[271] == 'p' &&
    obj[6]->lts->x[272] == 'j' &&
    obj[6]->lts->x[273] == 'q' &&
    obj[6]->lts->x[274] == 'b' &&
    obj[6]->lts->x[275] == 'o' &&
    obj[6]->lts->x[276] == 'f' &&
    obj[6]->lts->x[277] == 'x' &&
    obj[6]->lts->x[278] == 'g' &&
    obj[6]->lts->x[279] == 'o' &&
    obj[6]->lts->x[280] == 'm' &&
    obj[6]->lts->x[281] == 'x' &&
    obj[6]->lti->y[431] == 109 &&
    obj[6]->lti->y[537] == 104 &&
    obj[6]->lti->y[590] == 110 &&
    obj[6]->lti->x[350] == 112 &&
    obj[6]->lti->x[597] == 121 &&
    obj[6]->lti->x[810] == 97 &&
    !strcmp(&obj[6]->lts->y[411], "puwbmosfbkuxpjmeyxhmkvpreieeetblktkhykymttbe") &&
    !strcmp(&obj[6]->lts->y[179], "luyuvdvjtgnsxnuderyn") &&
    !strcmp(&obj[6]->lts->x[34], "nb") &&
    !strcmp(&obj[6]->lts->x[254], "opsdoiqvkucuwkpdkpjqbofxgomx") &&
    obj[7]->lts->y[326] == 'c' &&
    obj[7]->lts->y[327] == 'g' &&
    obj[7]->lts->y[328] == 's' &&
    obj[7]->lts->y[329] == 'w' &&
    obj[7]->lts->y[330] == 'j' &&
    obj[7]->lts->y[331] == 'c' &&
    obj[7]->lts->y[332] == 'f' &&
    obj[7]->lts->y[627] == 'm' &&
    obj[7]->lts->y[628] == 'o' &&
    obj[7]->lts->y[629] == 'f' &&
    obj[7]->lts->y[630] == 'i' &&
    obj[7]->lts->y[631] == 'e' &&
    obj[7]->lts->y[632] == 'p' &&
    obj[7]->lts->y[633] == 'j' &&
    obj[7]->lts->y[634] == 'a' &&
    obj[7]->lti->y[526] == 109 &&
    obj[7]->lti->x[91] == 118 &&
    obj[7]->lti->x[145] == 105 &&
    obj[7]->lti->x[263] == 99 &&
    obj[7]->lti->x[356] == 107 &&
    obj[7]->lti->x[494] == 115 &&
    obj[7]->lti->x[636] == 97 &&
    obj[7]->lti->x[874] == 112 &&
    !strcmp(&obj[7]->lts->y[627], "mofiepja") &&
    !strcmp(&obj[7]->lts->y[326], "cgswjcf") &&
    obj[8]->lts->y[105] == 'g' &&
    obj[8]->lts->y[106] == 'e' &&
    obj[8]->lts->y[107] == 'd' &&
    obj[8]->lts->y[108] == 'p' &&
    obj[8]->lts->y[109] == 't' &&
    obj[8]->lts->y[110] == 'i' &&
    obj[8]->lts->y[111] == 'r' &&
    obj[8]->lts->y[112] == 'r' &&
    obj[8]->lts->y[113] == 'r' &&
    obj[8]->lts->y[114] == 'v' &&
    obj[8]->lts->y[115] == 'k' &&
    obj[8]->lts->y[116] == 'v' &&
    obj[8]->lts->y[117] == 'v' &&
    obj[8]->lts->y[118] == 'f' &&
    obj[8]->lts->y[119] == 'z' &&
    obj[8]->lts->y[120] == 'r' &&
    obj[8]->lts->y[121] == 'h' &&
    obj[8]->lts->y[122] == 'a' &&
    obj[8]->lts->y[123] == 'n' &&
    obj[8]->lts->y[124] == 'a' &&
    obj[8]->lts->y[125] == 'u' &&
    obj[8]->lts->y[126] == 'i' &&
    obj[8]->lts->y[127] == 'x' &&
    obj[8]->lts->y[128] == 'l' &&
    obj[8]->lts->y[129] == 'h' &&
    obj[8]->lts->y[130] == 't' &&
    obj[8]->lts->y[131] == 'o' &&
    obj[8]->lts->y[132] == 'i' &&
    obj[8]->lts->y[133] == 'a' &&
    obj[8]->lts->y[134] == 'k' &&
    obj[8]->lts->y[135] == 'n' &&
    obj[8]->lts->y[136] == 'f' &&
    obj[8]->lts->y[137] == 'd' &&
    obj[8]->lts->y[138] == 'j' &&
    obj[8]->lts->y[139] == 'h' &&
    obj[8]->lts->y[140] == 'k' &&
    obj[8]->lts->y[141] == 'b' &&
    obj[8]->lts->y[142] == 'l' &&
    obj[8]->lts->y[143] == 't' &&
    obj[8]->lts->y[276] == 'c' &&
    obj[8]->lts->y[277] == 'f' &&
    obj[8]->lts->y[278] == 'k' &&
    obj[8]->lts->y[279] == 'l' &&
    obj[8]->lts->y[280] == 'c' &&
    obj[8]->lts->y[281] == 't' &&
    obj[8]->lts->y[282] == 'm' &&
    obj[8]->lts->y[283] == 't' &&
    obj[8]->lts->y[284] == 'k' &&
    obj[8]->lts->y[285] == 'm' &&
    obj[8]->lts->x[228] == 'm' &&
    obj[8]->lts->x[229] == 'q' &&
    obj[8]->lts->x[230] == 'l' &&
    obj[8]->lts->x[231] == 'f' &&
    obj[8]->lts->x[232] == 'y' &&
    obj[8]->lts->x[233] == 'w' &&
    obj[8]->lts->x[234] == 'j' &&
    obj[8]->lts->x[235] == 'j' &&
    obj[8]->lts->x[236] == 'a' &&
    obj[8]->lts->x[237] == 'i' &&
    obj[8]->lts->x[238] == 'x' &&
    obj[8]->lts->x[239] == 'f' &&
    obj[8]->lts->x[240] == 'w' &&
    obj[8]->lts->x[241] == 'y' &&
    obj[8]->lts->x[242] == 'a' &&
    obj[8]->lts->x[243] == 'p' &&
    obj[8]->lts->x[288] == 'w' &&
    obj[8]->lts->x[289] == 'z' &&
    obj[8]->lts->x[290] == 'o' &&
    obj[8]->lts->x[291] == 'f' &&
    obj[8]->lts->x[292] == 'b' &&
    obj[8]->lts->x[458] == 'z' &&
    obj[8]->lts->x[459] == 'v' &&
    obj[8]->lts->x[460] == 'h' &&
    obj[8]->lts->x[461] == 'h' &&
    obj[8]->lts->x[462] == 'k' &&
    obj[8]->lts->x[463] == 'g' &&
    obj[8]->lts->x[464] == 'a' &&
    obj[8]->lts->x[465] == 'b' &&
    obj[8]->lts->x[466] == 'i' &&
    obj[8]->lts->x[467] == 'w' &&
    obj[8]->lts->x[468] == 's' &&
    obj[8]->lts->x[469] == 'g' &&
    obj[8]->lts->x[470] == 'b' &&
    obj[8]->lts->x[471] == 'u' &&
    obj[8]->lts->x[472] == 'l' &&
    obj[8]->lts->x[473] == 'y' &&
    obj[8]->lts->x[474] == 'z' &&
    obj[8]->lts->x[475] == 'n' &&
    obj[8]->lts->x[476] == 'b' &&
    obj[8]->lts->x[477] == 'h' &&
    obj[8]->lts->x[478] == 'x' &&
    obj[8]->lts->x[479] == 't' &&
    obj[8]->lts->x[480] == 'm' &&
    obj[8]->lts->x[481] == 'y' &&
    obj[8]->lts->x[482] == 'w' &&
    obj[8]->lts->x[483] == 'h' &&
    obj[8]->lts->x[484] == 'i' &&
    obj[8]->lts->x[485] == 'i' &&
    obj[8]->lts->x[486] == 'b' &&
    obj[8]->lts->x[487] == 'g' &&
    obj[8]->lts->x[488] == 'm' &&
    obj[8]->lts->x[489] == 'n' &&
    obj[8]->lts->x[490] == 'b' &&
    obj[8]->lts->x[491] == 'e' &&
    obj[8]->lts->x[492] == 'u' &&
    obj[8]->lts->x[493] == 'e' &&
    obj[8]->lts->x[494] == 'z' &&
    obj[8]->lts->x[495] == 't' &&
    obj[8]->lts->x[496] == 'q' &&
    obj[8]->lts->x[497] == 'w' &&
    obj[8]->lts->x[498] == 'i' &&
    obj[8]->lts->x[499] == 'y' &&
    obj[8]->lts->x[796] == 'y' &&
    obj[8]->lts->x[797] == 'k' &&
    obj[8]->lts->x[798] == 'b' &&
    obj[8]->lts->x[799] == 'x' &&
    obj[8]->lts->x[800] == 'b' &&
    obj[8]->lts->x[801] == 'i' &&
    obj[8]->lts->x[802] == 'a' &&
    obj[8]->lts->x[803] == 't' &&
    obj[8]->lts->x[804] == 'i' &&
    obj[8]->lts->x[805] == 'x' &&
    obj[8]->lts->x[806] == 't' &&
    obj[8]->lts->x[807] == 'r' &&
    obj[8]->lts->x[808] == 'i' &&
    obj[8]->lts->x[809] == 'q' &&
    obj[8]->lts->x[810] == 'b' &&
    obj[8]->lts->x[811] == 'd' &&
    obj[8]->lts->x[812] == 'a' &&
    obj[8]->lts->x[813] == 'q' &&
    obj[8]->lts->x[814] == 'q' &&
    obj[8]->lts->x[815] == 'k' &&
    obj[8]->lts->x[816] == 'y' &&
    obj[8]->lts->x[817] == 'c' &&
    obj[8]->lts->x[818] == 'r' &&
    obj[8]->lts->x[819] == 'a' &&
    obj[8]->lts->x[820] == 'p' &&
    obj[8]->lts->x[821] == 'v' &&
    obj[8]->lts->x[822] == 'k' &&
    obj[8]->lts->x[823] == 'i' &&
    obj[8]->lts->x[824] == 'w' &&
    obj[8]->lts->x[825] == 'x' &&
    obj[8]->lts->x[826] == 'p' &&
    obj[8]->lts->x[827] == 'u' &&
    obj[8]->lts->x[828] == 'j' &&
    obj[8]->lts->x[829] == 'c' &&
    obj[8]->lts->x[830] == 'i' &&
    obj[8]->lts->x[831] == 'h' &&
    obj[8]->lts->x[832] == 'f' &&
    obj[8]->lts->x[833] == 'o' &&
    obj[8]->lts->x[834] == 'r' &&
    obj[8]->lts->x[835] == 'w' &&
    obj[8]->lts->x[836] == 'u' &&
    obj[8]->lts->x[837] == 'y' &&
    obj[8]->lts->x[838] == 'y' &&
    obj[8]->lts->x[839] == 'e' &&
    obj[8]->lts->x[840] == 'j' &&
    obj[8]->lti->y[327] == 119 &&
    obj[8]->lti->x[148] == 108 &&
    obj[8]->lti->x[606] == 111 &&
    obj[8]->lti->x[626] == 100 &&
    !strcmp(&obj[8]->lts->y[276], "cfklctmtkm") &&
    !strcmp(&obj[8]->lts->y[105], "gedptirrrvkvvfzrhanauixlhtoiaknfdjhkblt") &&
    !strcmp(&obj[8]->lts->x[228], "mqlfywjjaixfwyap") &&
    !strcmp(&obj[8]->lts->x[796], "ykbxbiatixtriqbdaqqkycrapvkiwxpujcihforwuyyej") &&
    !strcmp(&obj[8]->lts->x[458], "zvhhkgabiwsgbulyznbhxtmywhiibgmnbeueztqwiy") &&
    !strcmp(&obj[8]->lts->x[288], "wzofb") &&
    obj[9] == NULL &&
    obj[10]->lts->y[260] == 's' &&
    obj[10]->lts->y[261] == 'y' &&
    obj[10]->lts->y[262] == 'n' &&
    obj[10]->lts->y[263] == 'g' &&
    obj[10]->lts->y[264] == 'z' &&
    obj[10]->lts->y[265] == 't' &&
    obj[10]->lts->y[266] == 'a' &&
    obj[10]->lts->y[267] == 'b' &&
    obj[10]->lts->y[268] == 's' &&
    obj[10]->lts->y[269] == 'e' &&
    obj[10]->lts->y[270] == 'a' &&
    obj[10]->lts->y[271] == 'a' &&
    obj[10]->lts->y[272] == 'i' &&
    obj[10]->lts->y[273] == 's' &&
    obj[10]->lts->y[274] == 'v' &&
    obj[10]->lts->y[275] == 's' &&
    obj[10]->lts->y[276] == 't' &&
    obj[10]->lts->y[277] == 'n' &&
    obj[10]->lts->y[278] == 'e' &&
    obj[10]->lts->y[336] == 'r' &&
    obj[10]->lts->y[337] == 'l' &&
    obj[10]->lts->y[338] == 'f' &&
    obj[10]->lts->y[339] == 'z' &&
    obj[10]->lts->y[340] == 'c' &&
    obj[10]->lts->y[341] == 's' &&
    obj[10]->lts->y[342] == 'x' &&
    obj[10]->lts->y[343] == 'q' &&
    obj[10]->lts->y[344] == 'c' &&
    obj[10]->lts->y[345] == 't' &&
    obj[10]->lts->y[346] == 'a' &&
    obj[10]->lts->y[347] == 'o' &&
    obj[10]->lts->y[348] == 'p' &&
    obj[10]->lts->y[349] == 'c' &&
    obj[10]->lts->y[350] == 'g' &&
    obj[10]->lts->y[351] == 'o' &&
    obj[10]->lts->y[352] == 'e' &&
    obj[10]->lts->y[353] == 'q' &&
    obj[10]->lts->y[354] == 'p' &&
    obj[10]->lts->y[355] == 'b' &&
    obj[10]->lts->y[356] == 'z' &&
    obj[10]->lts->y[357] == 'y' &&
    obj[10]->lts->y[358] == 'g' &&
    obj[10]->lts->y[359] == 'c' &&
    obj[10]->lts->y[360] == 'f' &&
    obj[10]->lts->y[361] == 'j' &&
    obj[10]->lts->y[362] == 's' &&
    obj[10]->lts->y[363] == 'l' &&
    obj[10]->lts->y[364] == 'd' &&
    obj[10]->lts->y[365] == 'i' &&
    obj[10]->lts->y[366] == 'x' &&
    obj[10]->lts->y[367] == 'u' &&
    obj[10]->lts->y[368] == 'l' &&
    obj[10]->lts->y[375] == 'l' &&
    obj[10]->lts->y[376] == 'p' &&
    obj[10]->lts->y[377] == 'h' &&
    obj[10]->lts->y[378] == 'b' &&
    obj[10]->lts->y[379] == 'v' &&
    obj[10]->lts->y[380] == 'e' &&
    obj[10]->lts->y[381] == 'x' &&
    obj[10]->lts->y[382] == 'q' &&
    obj[10]->lts->y[383] == 'q' &&
    obj[10]->lts->y[384] == 'a' &&
    obj[10]->lts->y[385] == 'c' &&
    obj[10]->lts->y[386] == 'u' &&
    obj[10]->lts->y[387] == 'x' &&
    obj[10]->lts->y[388] == 'g' &&
    obj[10]->lts->x[53] == 'q' &&
    obj[10]->lts->x[54] == 'i' &&
    obj[10]->lts->x[55] == 'u' &&
    obj[10]->lts->x[56] == 'z' &&
    obj[10]->lts->x[57] == 'y' &&
    obj[10]->lts->x[58] == 'q' &&
    obj[10]->lts->x[59] == 'p' &&
    obj[10]->lts->x[60] == 'x' &&
    obj[10]->lts->x[61] == 'g' &&
    obj[10]->lts->x[62] == 'q' &&
    obj[10]->lts->x[63] == 'e' &&
    obj[10]->lts->x[64] == 'a' &&
    obj[10]->lts->x[65] == 'h' &&
    obj[10]->lts->x[66] == 'd' &&
    obj[10]->lti->y[610] == 106 &&
    obj[10]->lti->y[633] == 109 &&
    obj[10]->lti->x[29] == 119 &&
    obj[10]->lti->x[366] == 102 &&
    obj[10]->lti->x[377] == 117 &&
    obj[10]->lti->x[413] == 117 &&
    !strcmp(&obj[10]->lts->y[375], "lphbvexqqacuxg") &&
    !strcmp(&obj[10]->lts->y[260], "syngztabseaaisvstne") &&
    !strcmp(&obj[10]->lts->y[336], "rlfzcsxqctaopcgoeqpbzygcfjsldixul") &&
    !strcmp(&obj[10]->lts->x[53], "qiuzyqpxgqeahd") &&
    obj[12]->lts->y[11] == 'l' &&
    obj[12]->lts->y[12] == 'w' &&
    obj[12]->lts->y[13] == 'h' &&
    obj[12]->lts->y[14] == 'a' &&
    obj[12]->lts->y[15] == 'n' &&
    obj[12]->lts->y[16] == 'y' &&
    obj[12]->lts->y[17] == 'j' &&
    obj[12]->lts->y[18] == 'm' &&
    obj[12]->lts->y[19] == 'f' &&
    obj[12]->lts->y[20] == 'x' &&
    obj[12]->lts->y[21] == 'p' &&
    obj[12]->lts->y[22] == 'g' &&
    obj[12]->lts->y[23] == 'v' &&
    obj[12]->lts->y[24] == 't' &&
    obj[12]->lts->y[25] == 'm' &&
    obj[12]->lts->y[26] == 'l' &&
    obj[12]->lts->y[27] == 'd' &&
    obj[12]->lts->y[28] == 'p' &&
    obj[12]->lts->y[29] == 'd' &&
    obj[12]->lts->y[30] == 'b' &&
    obj[12]->lts->y[31] == 'q' &&
    obj[12]->lts->y[32] == 'n' &&
    obj[12]->lts->y[33] == 'd' &&
    obj[12]->lts->y[34] == 'g' &&
    obj[12]->lts->y[35] == 'e' &&
    obj[12]->lts->y[36] == 'w' &&
    obj[12]->lts->y[37] == 'z' &&
    obj[12]->lts->y[38] == 'z' &&
    obj[12]->lts->y[39] == 't' &&
    obj[12]->lts->y[40] == 'z' &&
    obj[12]->lts->y[41] == 'l' &&
    obj[12]->lts->y[42] == 't' &&
    obj[12]->lts->y[43] == 'w' &&
    obj[12]->lts->y[44] == 'j' &&
    obj[12]->lts->y[45] == 'p' &&
    obj[12]->lts->y[46] == 'y' &&
    obj[12]->lts->y[47] == 'h' &&
    obj[12]->lts->y[48] == 'h' &&
    obj[12]->lts->y[49] == 's' &&
    obj[12]->lts->y[50] == 'w' &&
    obj[12]->lts->y[51] == 'v' &&
    obj[12]->lts->y[52] == 'l' &&
    obj[12]->lts->y[53] == 'u' &&
    obj[12]->lts->y[54] == 's' &&
    obj[12]->lts->y[55] == 'p' &&
    obj[12]->lts->y[133] == 'n' &&
    obj[12]->lts->y[134] == 'a' &&
    obj[12]->lts->y[135] == 'o' &&
    obj[12]->lts->y[136] == 't' &&
    obj[12]->lts->y[137] == 'u' &&
    obj[12]->lts->y[138] == 'm' &&
    obj[12]->lts->y[139] == 'q' &&
    obj[12]->lts->y[140] == 'm' &&
    obj[12]->lts->y[141] == 'y' &&
    obj[12]->lts->y[142] == 'j' &&
    obj[12]->lts->y[143] == 'n' &&
    obj[12]->lts->y[144] == 'x' &&
    obj[12]->lts->y[145] == 'u' &&
    obj[12]->lts->y[146] == 'y' &&
    obj[12]->lts->y[147] == 'c' &&
    obj[12]->lts->y[148] == 'p' &&
    obj[12]->lts->y[671] == 'w' &&
    obj[12]->lts->y[672] == 'x' &&
    obj[12]->lts->y[673] == 'p' &&
    obj[12]->lts->y[674] == 'g' &&
    obj[12]->lts->y[675] == 'k' &&
    obj[12]->lts->y[676] == 'w' &&
    obj[12]->lts->y[677] == 'p' &&
    obj[12]->lts->y[678] == 'f' &&
    obj[12]->lts->y[679] == 's' &&
    obj[12]->lts->y[680] == 'd' &&
    obj[12]->lts->y[681] == 'u' &&
    obj[12]->lts->y[801] == 'y' &&
    obj[12]->lts->y[802] == 'w' &&
    obj[12]->lts->y[803] == 'i' &&
    obj[12]->lts->y[804] == 'p' &&
    obj[12]->lts->y[805] == 'k' &&
    obj[12]->lts->y[806] == 'b' &&
    obj[12]->lts->y[807] == 'h' &&
    obj[12]->lts->y[808] == 't' &&
    obj[12]->lts->y[809] == 'm' &&
    obj[12]->lts->y[810] == 'i' &&
    obj[12]->lts->y[811] == 'n' &&
    obj[12]->lts->y[812] == 'i' &&
    obj[12]->lts->y[813] == 'u' &&
    obj[12]->lts->y[814] == 'x' &&
    obj[12]->lts->y[815] == 'q' &&
    obj[12]->lts->y[816] == 'y' &&
    obj[12]->lts->y[817] == 'r' &&
    obj[12]->lts->y[818] == 'u' &&
    obj[12]->lts->y[819] == 'v' &&
    obj[12]->lts->y[820] == 'w' &&
    obj[12]->lts->y[821] == 'k' &&
    obj[12]->lts->y[822] == 'q' &&
    obj[12]->lts->y[823] == 'o' &&
    obj[12]->lts->y[824] == 'g' &&
    obj[12]->lts->y[825] == 's' &&
    obj[12]->lts->y[826] == 'n' &&
    obj[12]->lts->y[827] == 'z' &&
    obj[12]->lts->y[828] == 'c' &&
    obj[12]->lts->y[829] == 'm' &&
    obj[12]->lts->y[830] == 'y' &&
    obj[12]->lts->y[831] == 'e' &&
    obj[12]->lts->y[832] == 's' &&
    obj[12]->lts->y[833] == 'a' &&
    obj[12]->lts->y[834] == 'c' &&
    obj[12]->lts->y[835] == 'd' &&
    obj[12]->lts->y[836] == 'r' &&
    obj[12]->lts->y[837] == 'm' &&
    obj[12]->lts->y[838] == 'l' &&
    obj[12]->lts->y[839] == 'a' &&
    obj[12]->lts->y[840] == 'b' &&
    obj[12]->lts->y[841] == 'l' &&
    obj[12]->lts->y[842] == 't' &&
    obj[12]->lts->y[843] == 'e' &&
    obj[12]->lts->y[844] == 's' &&
    obj[12]->lts->x[134] == 'f' &&
    obj[12]->lts->x[135] == 'o' &&
    obj[12]->lts->x[136] == 'c' &&
    obj[12]->lts->x[137] == 'o' &&
    obj[12]->lts->x[138] == 'p' &&
    obj[12]->lts->x[139] == 'k' &&
    obj[12]->lts->x[361] == 'b' &&
    obj[12]->lts->x[362] == 'l' &&
    obj[12]->lts->x[363] == 'f' &&
    obj[12]->lts->x[364] == 'j' &&
    obj[12]->lts->x[365] == 'q' &&
    obj[12]->lts->x[366] == 'k' &&
    obj[12]->lts->x[367] == 't' &&
    obj[12]->lts->x[368] == 'o' &&
    obj[12]->lts->x[369] == 'e' &&
    obj[12]->lts->x[370] == 'j' &&
    obj[12]->lts->x[371] == 'c' &&
    obj[12]->lts->x[372] == 'h' &&
    obj[12]->lts->x[373] == 'g' &&
    obj[12]->lts->x[374] == 'k' &&
    obj[12]->lts->x[375] == 'e' &&
    obj[12]->lts->x[376] == 'q' &&
    obj[12]->lts->x[377] == 'm' &&
    obj[12]->lts->x[378] == 'i' &&
    obj[12]->lts->x[379] == 'a' &&
    obj[12]->lts->x[380] == 'n' &&
    obj[12]->lts->x[473] == 'u' &&
    obj[12]->lts->x[474] == 'r' &&
    obj[12]->lts->x[475] == 'l' &&
    obj[12]->lts->x[476] == 'j' &&
    obj[12]->lts->x[477] == 'x' &&
    obj[12]->lts->x[478] == 'z' &&
    obj[12]->lts->x[479] == 'f' &&
    obj[12]->lts->x[480] == 'l' &&
    obj[12]->lts->x[481] == 'd' &&
    obj[12]->lts->x[482] == 'e' &&
    obj[12]->lts->x[483] == 'n' &&
    obj[12]->lts->x[484] == 'l' &&
    obj[12]->lts->x[485] == 'p' &&
    obj[12]->lts->x[486] == 'i' &&
    obj[12]->lts->x[487] == 'm' &&
    obj[12]->lts->x[488] == 'w' &&
    obj[12]->lts->x[489] == 'c' &&
    obj[12]->lts->x[490] == 'f' &&
    obj[12]->lts->x[491] == 'x' &&
    obj[12]->lts->x[492] == 'j' &&
    obj[12]->lts->x[493] == 'n' &&
    obj[12]->lts->x[494] == 'a' &&
    obj[12]->lts->x[495] == 'r' &&
    obj[12]->lts->x[496] == 'p' &&
    obj[12]->lts->x[497] == 'v' &&
    obj[12]->lts->x[498] == 'u' &&
    obj[12]->lts->x[499] == 'c' &&
    obj[12]->lts->x[500] == 'a' &&
    obj[12]->lts->x[501] == 'u' &&
    obj[12]->lts->x[502] == 'm' &&
    obj[12]->lts->x[503] == 'w' &&
    obj[12]->lts->x[504] == 'd' &&
    obj[12]->lts->x[505] == 'w' &&
    obj[12]->lti->y[73] == 106 &&
    obj[12]->lti->x[309] == 109 &&
    obj[12]->lti->x[458] == 114 &&
    !strcmp(&obj[12]->lts->y[801], "ywipkbhtminiuxqyruvwkqogsnzcmyesacdrmlabltes") &&
    !strcmp(&obj[12]->lts->y[671], "wxpgkwpfsdu") &&
    !strcmp(&obj[12]->lts->y[133], "naotumqmyjnxuycp") &&
    !strcmp(&obj[12]->lts->y[11], "lwhanyjmfxpgvtmldpdbqndgewzztzltwjpyhhswvlusp") &&
    !strcmp(&obj[12]->lts->x[134], "focopk") &&
    !strcmp(&obj[12]->lts->x[361], "blfjqktoejchgkeqmian") &&
    !strcmp(&obj[12]->lts->x[473], "urljxzfldenlpimwcfxjnarpvucaumwdw") &&
    obj[14]->lts->y[173] == 'j' &&
    obj[14]->lts->y[174] == 'f' &&
    obj[14]->lts->y[175] == 'g' &&
    obj[14]->lts->y[176] == 'v' &&
    obj[14]->lts->y[177] == 's' &&
    obj[14]->lts->y[178] == 'c' &&
    obj[14]->lts->y[179] == 'j' &&
    obj[14]->lts->y[180] == 'b' &&
    obj[14]->lts->y[181] == 'e' &&
    obj[14]->lts->y[182] == 's' &&
    obj[14]->lts->y[183] == 'k' &&
    obj[14]->lts->y[184] == 'u' &&
    obj[14]->lts->y[185] == 'z' &&
    obj[14]->lts->y[186] == 'e' &&
    obj[14]->lts->y[187] == 'x' &&
    obj[14]->lts->y[188] == 'e' &&
    obj[14]->lts->y[189] == 'l' &&
    obj[14]->lts->y[190] == 'b' &&
    obj[14]->lts->y[191] == 'u' &&
    obj[14]->lts->y[192] == 'o' &&
    obj[14]->lts->y[193] == 'p' &&
    obj[14]->lts->y[194] == 'm' &&
    obj[14]->lts->y[195] == 'c' &&
    obj[14]->lts->y[196] == 'v' &&
    obj[14]->lts->y[197] == 'k' &&
    obj[14]->lts->y[198] == 'n' &&
    obj[14]->lts->y[199] == 's' &&
    obj[14]->lts->y[200] == 'k' &&
    obj[14]->lts->y[201] == 'y' &&
    obj[14]->lts->y[202] == 'a' &&
    obj[14]->lts->y[203] == 'z' &&
    obj[14]->lts->y[204] == 'b' &&
    obj[14]->lts->y[205] == 'm' &&
    obj[14]->lts->y[206] == 'v' &&
    obj[14]->lts->y[207] == 'f' &&
    obj[14]->lts->y[208] == 'q' &&
    obj[14]->lts->y[209] == 'f' &&
    obj[14]->lts->y[210] == 'n' &&
    obj[14]->lts->y[211] == 'g' &&
    obj[14]->lts->y[212] == 'd' &&
    obj[14]->lts->y[213] == 'g' &&
    obj[14]->lts->y[214] == 'h' &&
    obj[14]->lts->y[215] == 'x' &&
    obj[14]->lts->y[216] == 'p' &&
    obj[14]->lts->y[217] == 'f' &&
    obj[14]->lts->y[218] == 's' &&
    obj[14]->lts->y[219] == 'r' &&
    obj[14]->lts->y[220] == 'q' &&
    obj[14]->lts->y[221] == 'k' &&
    obj[14]->lts->y[222] == 'z' &&
    obj[14]->lts->y[991] == 'h' &&
    obj[14]->lts->y[992] == 'w' &&
    obj[14]->lts->y[993] == 'e' &&
    obj[14]->lts->y[994] == 'h' &&
    obj[14]->lts->y[995] == 'r' &&
    obj[14]->lts->y[996] == 'f' &&
    obj[14]->lts->y[997] == 'c' &&
    obj[14]->lts->y[998] == 'p' &&
    obj[14]->lts->x[145] == 'm' &&
    obj[14]->lts->x[146] == 'o' &&
    obj[14]->lts->x[147] == 'e' &&
    obj[14]->lts->x[148] == 'a' &&
    obj[14]->lts->x[149] == 'a' &&
    obj[14]->lts->x[150] == 'g' &&
    obj[14]->lts->x[151] == 'o' &&
    obj[14]->lts->x[152] == 'w' &&
    obj[14]->lts->x[153] == 'y' &&
    obj[14]->lts->x[154] == 'w' &&
    obj[14]->lts->x[155] == 'o' &&
    obj[14]->lts->x[156] == 'a' &&
    obj[14]->lts->x[157] == 'q' &&
    obj[14]->lts->x[158] == 'i' &&
    obj[14]->lts->x[159] == 'e' &&
    obj[14]->lts->x[160] == 'r' &&
    obj[14]->lts->x[161] == 'f' &&
    obj[14]->lts->x[162] == 'w' &&
    obj[14]->lts->x[163] == 'c' &&
    obj[14]->lts->x[164] == 'x' &&
    obj[14]->lts->x[165] == 't' &&
    obj[14]->lts->x[166] == 'k' &&
    obj[14]->lts->x[167] == 'k' &&
    obj[14]->lts->x[168] == 'x' &&
    obj[14]->lts->x[169] == 'i' &&
    obj[14]->lts->x[170] == 'u' &&
    obj[14]->lts->x[171] == 'd' &&
    obj[14]->lts->x[172] == 'u' &&
    obj[14]->lts->x[173] == 'r' &&
    obj[14]->lts->x[174] == 'j' &&
    obj[14]->lts->x[175] == 'i' &&
    obj[14]->lts->x[176] == 'm' &&
    obj[14]->lts->x[177] == 's' &&
    obj[14]->lts->x[178] == 'd' &&
    obj[14]->lts->x[179] == 'v' &&
    obj[14]->lts->x[180] == 'i' &&
    obj[14]->lts->x[420] == 'k' &&
    obj[14]->lts->x[421] == 'h' &&
    obj[14]->lts->x[422] == 'w' &&
    obj[14]->lts->x[423] == 'z' &&
    obj[14]->lts->x[424] == 'f' &&
    obj[14]->lts->x[425] == 'i' &&
    obj[14]->lts->x[852] == 'u' &&
    obj[14]->lts->x[853] == 'a' &&
    obj[14]->lts->x[854] == 'o' &&
    obj[14]->lts->x[855] == 'o' &&
    obj[14]->lts->x[856] == 's' &&
    obj[14]->lts->x[857] == 'r' &&
    obj[14]->lts->x[858] == 'v' &&
    obj[14]->lts->x[859] == 'c' &&
    obj[14]->lts->x[860] == 's' &&
    obj[14]->lts->x[861] == 'e' &&
    obj[14]->lts->x[862] == 'y' &&
    obj[14]->lts->x[863] == 'm' &&
    obj[14]->lts->x[864] == 'q' &&
    obj[14]->lts->x[865] == 'b' &&
    obj[14]->lts->x[866] == 'g' &&
    obj[14]->lts->x[867] == 'r' &&
    obj[14]->lts->x[868] == 'a' &&
    obj[14]->lts->x[869] == 'a' &&
    obj[14]->lts->x[870] == 'h' &&
    obj[14]->lts->x[871] == 'l' &&
    obj[14]->lts->x[872] == 'x' &&
    obj[14]->lts->x[873] == 'q' &&
    obj[14]->lts->x[874] == 'a' &&
    obj[14]->lts->x[875] == 'g' &&
    obj[14]->lts->x[876] == 'b' &&
    obj[14]->lts->x[877] == 'p' &&
    obj[14]->lts->x[878] == 'x' &&
    obj[14]->lts->x[879] == 'l' &&
    obj[14]->lts->x[880] == 'i' &&
    obj[14]->lti->y[663] == 101 &&
    obj[14]->lti->y[994] == 114 &&
    obj[14]->lti->x[444] == 116 &&
    obj[14]->lti->x[535] == 106 &&
    !strcmp(&obj[14]->lts->y[173], "jfgvscjbeskuzexelbuopmcvknskyazbmvfqfngdghxpfsrqkz") &&
    !strcmp(&obj[14]->lts->y[991], "hwehrfcp") &&
    !strcmp(&obj[14]->lts->x[420], "khwzfi") &&
    !strcmp(&obj[14]->lts->x[852], "uaoosrvcseymqbgraahlxqagbpxli") &&
    !strcmp(&obj[14]->lts->x[145], "moeaagowywoaqierfwcxtkkxiudurjimsdvi") &&
    obj[15]->lts->y[45] == 'w' &&
    obj[15]->lts->y[46] == 'q' &&
    obj[15]->lts->y[47] == 'k' &&
    obj[15]->lts->y[48] == 'm' &&
    obj[15]->lts->y[49] == 'p' &&
    obj[15]->lts->y[50] == 's' &&
    obj[15]->lts->y[51] == 'x' &&
    obj[15]->lts->y[52] == 'b' &&
    obj[15]->lts->y[53] == 'v' &&
    obj[15]->lts->y[54] == 'b' &&
    obj[15]->lts->y[55] == 'v' &&
    obj[15]->lts->y[56] == 'i' &&
    obj[15]->lts->y[57] == 'b' &&
    obj[15]->lts->y[58] == 'e' &&
    obj[15]->lts->y[59] == 'q' &&
    obj[15]->lts->y[60] == 'm' &&
    obj[15]->lts->y[61] == 'n' &&
    obj[15]->lts->y[62] == 'x' &&
    obj[15]->lts->y[63] == 'g' &&
    obj[15]->lts->y[64] == 'a' &&
    obj[15]->lts->y[65] == 'j' &&
    obj[15]->lts->y[66] == 'z' &&
    obj[15]->lts->y[67] == 'l' &&
    obj[15]->lts->y[68] == 'x' &&
    obj[15]->lts->y[69] == 't' &&
    obj[15]->lts->y[70] == 'f' &&
    obj[15]->lts->y[71] == 'u' &&
    obj[15]->lts->y[72] == 'p' &&
    obj[15]->lts->y[73] == 'r' &&
    obj[15]->lts->y[74] == 'm' &&
    obj[15]->lts->y[75] == 'a' &&
    obj[15]->lts->y[76] == 'm' &&
    obj[15]->lts->y[77] == 'u' &&
    obj[15]->lts->y[78] == 'w' &&
    obj[15]->lts->y[79] == 'u' &&
    obj[15]->lts->y[80] == 'a' &&
    obj[15]->lts->y[81] == 'y' &&
    obj[15]->lts->y[82] == 'f' &&
    obj[15]->lts->y[83] == 'i' &&
    obj[15]->lts->y[84] == 'b' &&
    obj[15]->lts->y[85] == 'z' &&
    obj[15]->lts->y[86] == 'p' &&
    obj[15]->lts->y[87] == 'x' &&
    obj[15]->lts->y[787] == 'b' &&
    obj[15]->lts->y[788] == 'y' &&
    obj[15]->lts->y[789] == 'h' &&
    obj[15]->lts->y[790] == 'e' &&
    obj[15]->lts->y[791] == 'd' &&
    obj[15]->lts->y[792] == 'v' &&
    obj[15]->lts->y[793] == 'j' &&
    obj[15]->lts->y[902] == 'y' &&
    obj[15]->lts->y[903] == 'x' &&
    obj[15]->lts->y[904] == 'o' &&
    obj[15]->lts->y[905] == 's' &&
    obj[15]->lts->y[906] == 's' &&
    obj[15]->lts->y[907] == 'q' &&
    obj[15]->lts->y[908] == 'v' &&
    obj[15]->lts->y[909] == 'r' &&
    obj[15]->lts->y[910] == 'a' &&
    obj[15]->lts->y[911] == 'k' &&
    obj[15]->lts->y[912] == 'a' &&
    obj[15]->lts->y[913] == 'z' &&
    obj[15]->lts->y[914] == 'u' &&
    obj[15]->lts->y[915] == 'v' &&
    obj[15]->lts->y[916] == 'q' &&
    obj[15]->lts->y[917] == 'z' &&
    obj[15]->lts->y[918] == 'j' &&
    obj[15]->lts->y[919] == 'j' &&
    obj[15]->lts->y[920] == 'c' &&
    obj[15]->lts->y[921] == 'b' &&
    obj[15]->lts->y[922] == 'h' &&
    obj[15]->lts->y[923] == 'd' &&
    obj[15]->lts->y[924] == 'd' &&
    obj[15]->lts->y[925] == 'e' &&
    obj[15]->lts->y[926] == 'e' &&
    obj[15]->lts->y[927] == 'd' &&
    obj[15]->lts->y[928] == 'a' &&
    obj[15]->lts->y[929] == 'i' &&
    obj[15]->lts->y[930] == 'l' &&
    obj[15]->lts->y[931] == 'h' &&
    obj[15]->lts->y[932] == 'j' &&
    obj[15]->lts->y[933] == 'q' &&
    obj[15]->lts->y[934] == 'n' &&
    obj[15]->lts->y[935] == 's' &&
    obj[15]->lts->y[936] == 'y' &&
    obj[15]->lts->y[937] == 'g' &&
    obj[15]->lts->y[938] == 'p' &&
    obj[15]->lts->y[939] == 'd' &&
    obj[15]->lts->y[940] == 'u' &&
    obj[15]->lts->y[941] == 'g' &&
    obj[15]->lts->y[942] == 'p' &&
    obj[15]->lts->y[943] == 't' &&
    obj[15]->lts->x[405] == 'h' &&
    obj[15]->lts->x[406] == 't' &&
    obj[15]->lts->x[407] == 'x' &&
    obj[15]->lts->x[408] == 'u' &&
    obj[15]->lts->x[409] == 'r' &&
    obj[15]->lts->x[410] == 'i' &&
    obj[15]->lts->x[411] == 'l' &&
    obj[15]->lts->x[412] == 'q' &&
    obj[15]->lts->x[413] == 'n' &&
    obj[15]->lts->x[414] == 's' &&
    obj[15]->lts->x[415] == 'l' &&
    obj[15]->lts->x[416] == 'j' &&
    obj[15]->lts->x[417] == 'v' &&
    obj[15]->lts->x[418] == 'w' &&
    obj[15]->lts->x[419] == 'u' &&
    obj[15]->lts->x[420] == 'p' &&
    obj[15]->lts->x[421] == 'v' &&
    obj[15]->lts->x[422] == 'n' &&
    obj[15]->lts->x[423] == 'e' &&
    obj[15]->lts->x[424] == 'i' &&
    obj[15]->lts->x[425] == 'e' &&
    obj[15]->lts->x[426] == 'f' &&
    obj[15]->lts->x[427] == 'v' &&
    obj[15]->lts->x[428] == 'c' &&
    obj[15]->lts->x[429] == 'f' &&
    obj[15]->lts->x[430] == 'o' &&
    obj[15]->lts->x[431] == 'm' &&
    obj[15]->lts->x[432] == 'u' &&
    obj[15]->lts->x[433] == 'f' &&
    obj[15]->lts->x[434] == 'i' &&
    obj[15]->lts->x[435] == 'l' &&
    obj[15]->lts->x[436] == 's' &&
    obj[15]->lts->x[437] == 'o' &&
    obj[15]->lts->x[438] == 'f' &&
    obj[15]->lts->x[439] == 's' &&
    obj[15]->lts->x[440] == 'g' &&
    obj[15]->lts->x[441] == 'a' &&
    obj[15]->lts->x[442] == 'h' &&
    obj[15]->lts->x[443] == 'd' &&
    obj[15]->lts->x[444] == 'l' &&
    obj[15]->lts->x[445] == 'a' &&
    obj[15]->lts->x[446] == 'b' &&
    obj[15]->lts->x[447] == 'i' &&
    obj[15]->lti->x[57] == 105 &&
    obj[15]->lti->x[267] == 101 &&
    obj[15]->lti->x[655] == 117 &&
    obj[15]->lti->x[757] == 100 &&
    obj[15]->lti->x[829] == 114 &&
    obj[15]->lti->x[961] == 103 &&
    !strcmp(&obj[15]->lts->y[45], "wqkmpsxbvbvibeqmnxgajzlxtfuprmamuwuayfibzpx") &&
    !strcmp(&obj[15]->lts->y[902], "yxossqvrakazuvqzjjcbhddeedailhjqnsygpdugpt") &&
    !strcmp(&obj[15]->lts->y[787], "byhedvj") &&
    !strcmp(&obj[15]->lts->x[405], "htxurilqnsljvwupvneiefvcfomufilsofsgahdlabi") &&
    obj[16]->lts->y[372] == 'f' &&
    obj[16]->lts->y[373] == 'u' &&
    obj[16]->lts->y[374] == 't' &&
    obj[16]->lts->y[375] == 'n' &&
    obj[16]->lts->y[376] == 'e' &&
    obj[16]->lts->y[377] == 'w' &&
    obj[16]->lts->y[378] == 'c' &&
    obj[16]->lts->y[379] == 'f' &&
    obj[16]->lts->y[380] == 'w' &&
    obj[16]->lts->y[381] == 'w' &&
    obj[16]->lts->y[382] == 'k' &&
    obj[16]->lts->y[383] == 'v' &&
    obj[16]->lts->y[384] == 'n' &&
    obj[16]->lts->y[385] == 'm' &&
    obj[16]->lts->y[386] == 'n' &&
    obj[16]->lts->y[387] == 'j' &&
    obj[16]->lts->y[830] == 't' &&
    obj[16]->lts->y[831] == 'z' &&
    obj[16]->lts->y[832] == 'd' &&
    obj[16]->lts->y[833] == 'd' &&
    obj[16]->lts->y[834] == 'i' &&
    obj[16]->lts->y[835] == 'y' &&
    obj[16]->lts->y[836] == 'b' &&
    obj[16]->lts->y[837] == 'k' &&
    obj[16]->lts->y[838] == 'h' &&
    obj[16]->lts->y[839] == 'h' &&
    obj[16]->lts->y[840] == 'd' &&
    obj[16]->lts->y[841] == 'z' &&
    obj[16]->lts->y[842] == 'c' &&
    obj[16]->lts->y[843] == 's' &&
    obj[16]->lts->y[844] == 'q' &&
    obj[16]->lts->y[845] == 'z' &&
    obj[16]->lts->y[846] == 'd' &&
    obj[16]->lts->y[847] == 't' &&
    obj[16]->lts->x[68] == 'y' &&
    obj[16]->lts->x[69] == 'e' &&
    obj[16]->lts->x[70] == 'd' &&
    obj[16]->lts->x[71] == 'y' &&
    obj[16]->lts->x[72] == 'f' &&
    obj[16]->lts->x[73] == 'l' &&
    obj[16]->lts->x[74] == 'g' &&
    obj[16]->lts->x[75] == 'e' &&
    obj[16]->lts->x[76] == 'p' &&
    obj[16]->lts->x[77] == 'f' &&
    obj[16]->lts->x[78] == 'd' &&
    obj[16]->lts->x[79] == 'n' &&
    obj[16]->lts->x[80] == 'w' &&
    obj[16]->lts->x[81] == 'i' &&
    obj[16]->lts->x[82] == 'h' &&
    obj[16]->lts->x[83] == 'j' &&
    obj[16]->lts->x[84] == 'w' &&
    obj[16]->lts->x[85] == 'h' &&
    obj[16]->lts->x[86] == 'l' &&
    obj[16]->lts->x[87] == 'x' &&
    obj[16]->lts->x[88] == 'm' &&
    obj[16]->lts->x[89] == 's' &&
    obj[16]->lts->x[90] == 'i' &&
    obj[16]->lts->x[91] == 'w' &&
    obj[16]->lts->x[92] == 'j' &&
    obj[16]->lts->x[93] == 'm' &&
    obj[16]->lts->x[94] == 'b' &&
    obj[16]->lts->x[95] == 's' &&
    obj[16]->lts->x[96] == 'b' &&
    obj[16]->lts->x[97] == 'u' &&
    obj[16]->lts->x[98] == 'w' &&
    obj[16]->lts->x[99] == 'r' &&
    obj[16]->lts->x[100] == 'i' &&
    obj[16]->lts->x[101] == 'r' &&
    obj[16]->lts->x[102] == 'm' &&
    obj[16]->lts->x[103] == 'y' &&
    obj[16]->lts->x[104] == 'g' &&
    obj[16]->lts->x[105] == 'v' &&
    obj[16]->lts->x[106] == 's' &&
    obj[16]->lts->x[107] == 'a' &&
    obj[16]->lts->x[976] == 'u' &&
    obj[16]->lts->x[977] == 'b' &&
    obj[16]->lts->x[978] == 'o' &&
    obj[16]->lts->x[979] == 'l' &&
    obj[16]->lts->x[980] == 'p' &&
    obj[16]->lts->x[981] == 'd' &&
    obj[16]->lts->x[982] == 'm' &&
    obj[16]->lts->x[983] == 'l' &&
    obj[16]->lts->x[984] == 'd' &&
    obj[16]->lts->x[985] == 'e' &&
    obj[16]->lts->x[986] == 's' &&
    obj[16]->lts->x[987] == 'b' &&
    obj[16]->lts->x[988] == 'k' &&
    obj[16]->lts->x[989] == 'i' &&
    obj[16]->lts->x[990] == 'm' &&
    obj[16]->lts->x[991] == 'v' &&
    obj[16]->lts->x[992] == 'p' &&
    obj[16]->lti->x[127] == 103 &&
    obj[16]->lti->x[155] == 119 &&
    obj[16]->lti->x[342] == 111 &&
    obj[16]->lti->x[384] == 120 &&
    obj[16]->lti->x[650] == 105 &&
    obj[16]->lti->x[928] == 112 &&
    !strcmp(&obj[16]->lts->y[372], "futnewcfwwkvnmnj") &&
    !strcmp(&obj[16]->lts->y[830], "tzddiybkhhdzcsqzdt") &&
    !strcmp(&obj[16]->lts->x[68], "yedyflgepfdnwihjwhlxmsiwjmbsbuwrirmygvsa") &&
    !strcmp(&obj[16]->lts->x[976], "ubolpdmldesbkimvp") &&
    obj[17]->lts->y[5] == 'r' &&
    obj[17]->lts->y[6] == 'k' &&
    obj[17]->lts->y[7] == 'n' &&
    obj[17]->lts->y[8] == 'p' &&
    obj[17]->lts->y[9] == 'b' &&
    obj[17]->lts->y[10] == 'o' &&
    obj[17]->lts->y[11] == 't' &&
    obj[17]->lts->y[12] == 'd' &&
    obj[17]->lts->y[13] == 'j' &&
    obj[17]->lts->y[14] == 'v' &&
    obj[17]->lts->y[15] == 'p' &&
    obj[17]->lts->y[16] == 'o' &&
    obj[17]->lts->y[17] == 'x' &&
    obj[17]->lts->y[18] == 'z' &&
    obj[17]->lts->y[19] == 'y' &&
    obj[17]->lts->y[20] == 'r' &&
    obj[17]->lts->y[293] == 'g' &&
    obj[17]->lts->y[294] == 'p' &&
    obj[17]->lts->y[295] == 'c' &&
    obj[17]->lts->y[296] == 'd' &&
    obj[17]->lts->y[297] == 'e' &&
    obj[17]->lts->y[298] == 'f' &&
    obj[17]->lts->y[299] == 'q' &&
    obj[17]->lts->y[874] == 'u' &&
    obj[17]->lts->y[875] == 'h' &&
    obj[17]->lts->y[934] == 'k' &&
    obj[17]->lts->y[935] == 'd' &&
    obj[17]->lts->y[936] == 'n' &&
    obj[17]->lts->y[937] == 't' &&
    obj[17]->lts->y[938] == 'g' &&
    obj[17]->lts->y[939] == 'p' &&
    obj[17]->lts->y[940] == 's' &&
    obj[17]->lts->y[941] == 'e' &&
    obj[17]->lts->y[942] == 'h' &&
    obj[17]->lts->y[943] == 't' &&
    obj[17]->lts->y[944] == 'i' &&
    obj[17]->lts->y[945] == 'e' &&
    obj[17]->lts->y[946] == 'z' &&
    obj[17]->lts->y[947] == 's' &&
    obj[17]->lts->y[948] == 'm' &&
    obj[17]->lts->y[949] == 'n' &&
    obj[17]->lts->y[950] == 'w' &&
    obj[17]->lts->y[951] == 'k' &&
    obj[17]->lts->y[952] == 'l' &&
    obj[17]->lts->y[953] == 'q' &&
    obj[17]->lts->y[954] == 'p' &&
    obj[17]->lts->y[955] == 'a' &&
    obj[17]->lts->y[956] == 'd' &&
    obj[17]->lts->y[957] == 'g' &&
    obj[17]->lts->y[958] == 'c' &&
    obj[17]->lts->x[303] == 't' &&
    obj[17]->lts->x[304] == 'u' &&
    obj[17]->lts->x[305] == 'o' &&
    obj[17]->lts->x[306] == 'k' &&
    obj[17]->lts->x[307] == 'v' &&
    obj[17]->lts->x[308] == 'v' &&
    obj[17]->lts->x[309] == 't' &&
    obj[17]->lts->x[310] == 'r' &&
    obj[17]->lts->x[311] == 'g' &&
    obj[17]->lts->x[312] == 'j' &&
    obj[17]->lts->x[313] == 'z' &&
    obj[17]->lts->x[314] == 'p' &&
    obj[17]->lts->x[315] == 'z' &&
    obj[17]->lts->x[316] == 'k' &&
    obj[17]->lts->x[317] == 'u' &&
    obj[17]->lts->x[318] == 'g' &&
    obj[17]->lts->x[319] == 'q' &&
    obj[17]->lts->x[320] == 'l' &&
    obj[17]->lts->x[321] == 'm' &&
    obj[17]->lts->x[322] == 'k' &&
    obj[17]->lts->x[323] == 'd' &&
    obj[17]->lts->x[324] == 'x' &&
    obj[17]->lts->x[325] == 'h' &&
    obj[17]->lts->x[326] == 'c' &&
    obj[17]->lts->x[327] == 's' &&
    obj[17]->lts->x[328] == 'f' &&
    obj[17]->lts->x[329] == 'b' &&
    obj[17]->lts->x[330] == 'b' &&
    obj[17]->lts->x[331] == 'w' &&
    obj[17]->lts->x[332] == 'p' &&
    obj[17]->lts->x[333] == 'q' &&
    obj[17]->lts->x[334] == 'u' &&
    obj[17]->lts->x[335] == 't' &&
    obj[17]->lts->x[336] == 'f' &&
    obj[17]->lts->x[373] == 'z' &&
    obj[17]->lts->x[374] == 'h' &&
    obj[17]->lts->x[375] == 'l' &&
    obj[17]->lts->x[376] == 'p' &&
    obj[17]->lts->x[377] == 'r' &&
    obj[17]->lts->x[378] == 'z' &&
    obj[17]->lts->x[379] == 'b' &&
    obj[17]->lts->x[380] == 'r' &&
    obj[17]->lts->x[381] == 'i' &&
    obj[17]->lts->x[382] == 'o' &&
    obj[17]->lts->x[383] == 'q' &&
    obj[17]->lts->x[384] == 'q' &&
    obj[17]->lts->x[385] == 'k' &&
    obj[17]->lts->x[386] == 'v' &&
    obj[17]->lts->x[387] == 'v' &&
    obj[17]->lts->x[388] == 'o' &&
    obj[17]->lts->x[389] == 'e' &&
    obj[17]->lts->x[390] == 'y' &&
    obj[17]->lts->x[391] == 'y' &&
    obj[17]->lts->x[392] == 'o' &&
    obj[17]->lts->x[393] == 'h' &&
    obj[17]->lts->x[394] == 'q' &&
    obj[17]->lts->x[395] == 'o' &&
    obj[17]->lts->x[396] == 'u' &&
    obj[17]->lts->x[397] == 'd' &&
    obj[17]->lts->x[398] == 'g' &&
    obj[17]->lts->x[399] == 's' &&
    obj[17]->lts->x[400] == 'g' &&
    obj[17]->lts->x[401] == 'o' &&
    obj[17]->lts->x[402] == 'o' &&
    obj[17]->lts->x[403] == 'x' &&
    obj[17]->lts->x[404] == 'p' &&
    obj[17]->lts->x[405] == 'h' &&
    obj[17]->lts->x[406] == 'w' &&
    obj[17]->lts->x[407] == 'z' &&
    obj[17]->lts->x[408] == 'i' &&
    obj[17]->lts->x[409] == 'm' &&
    obj[17]->lts->x[410] == 'n' &&
    obj[17]->lts->x[411] == 's' &&
    obj[17]->lts->x[412] == 'e' &&
    obj[17]->lts->x[413] == 'e' &&
    obj[17]->lts->x[414] == 'q' &&
    obj[17]->lti->y[434] == 117 &&
    obj[17]->lti->y[730] == 114 &&
    obj[17]->lti->y[739] == 122 &&
    obj[17]->lti->x[998] == 117 &&
    !strcmp(&obj[17]->lts->y[934], "kdntgpsehtiezsmnwklqpadgc") &&
    !strcmp(&obj[17]->lts->y[874], "uh") &&
    !strcmp(&obj[17]->lts->y[5], "rknpbotdjvpoxzyr") &&
    !strcmp(&obj[17]->lts->y[293], "gpcdefq") &&
    !strcmp(&obj[17]->lts->x[373], "zhlprzbrioqqkvvoeyyohqoudgsgooxphwzimnseeq") &&
    !strcmp(&obj[17]->lts->x[303], "tuokvvtrgjzpzkugqlmkdxhcsfbbwpqutf") &&
    obj[18]->lts->y[449] == 'c' &&
    obj[18]->lts->y[450] == 'r' &&
    obj[18]->lts->y[451] == 'f' &&
    obj[18]->lts->y[452] == 'q' &&
    obj[18]->lts->y[453] == 'x' &&
    obj[18]->lts->y[454] == 'v' &&
    obj[18]->lts->y[455] == 'd' &&
    obj[18]->lts->y[456] == 'o' &&
    obj[18]->lts->y[457] == 'i' &&
    obj[18]->lts->y[458] == 'g' &&
    obj[18]->lts->y[459] == 'c' &&
    obj[18]->lts->y[460] == 'u' &&
    obj[18]->lts->y[461] == 'w' &&
    obj[18]->lts->y[462] == 'l' &&
    obj[18]->lts->y[463] == 'p' &&
    obj[18]->lts->y[464] == 'v' &&
    obj[18]->lts->y[465] == 'q' &&
    obj[18]->lts->y[466] == 'i' &&
    obj[18]->lts->y[467] == 'r' &&
    obj[18]->lts->y[645] == 'o' &&
    obj[18]->lts->y[646] == 'g' &&
    obj[18]->lts->y[647] == 't' &&
    obj[18]->lts->y[648] == 'p' &&
    obj[18]->lts->y[649] == 'r' &&
    obj[18]->lts->y[650] == 'j' &&
    obj[18]->lts->y[777] == 'y' &&
    obj[18]->lts->y[778] == 'a' &&
    obj[18]->lts->y[779] == 'g' &&
    obj[18]->lts->y[780] == 'y' &&
    obj[18]->lts->y[781] == 'o' &&
    obj[18]->lts->y[782] == 'm' &&
    obj[18]->lts->y[783] == 'm' &&
    obj[18]->lts->y[784] == 'j' &&
    obj[18]->lts->y[785] == 'j' &&
    obj[18]->lts->y[786] == 'm' &&
    obj[18]->lts->y[787] == 'y' &&
    obj[18]->lts->y[788] == 'u' &&
    obj[18]->lts->y[789] == 'v' &&
    obj[18]->lts->y[790] == 'g' &&
    obj[18]->lts->y[791] == 'm' &&
    obj[18]->lts->y[792] == 'v' &&
    obj[18]->lts->y[793] == 'z' &&
    obj[18]->lts->y[794] == 'x' &&
    obj[18]->lts->y[795] == 'x' &&
    obj[18]->lts->y[796] == 'i' &&
    obj[18]->lts->y[797] == 'j' &&
    obj[18]->lts->y[798] == 'w' &&
    obj[18]->lts->y[799] == 'k' &&
    obj[18]->lts->y[800] == 'u' &&
    obj[18]->lts->y[801] == 'k' &&
    obj[18]->lts->y[802] == 'g' &&
    obj[18]->lts->y[803] == 'a' &&
    obj[18]->lts->y[804] == 'b' &&
    obj[18]->lts->y[805] == 'd' &&
    obj[18]->lts->y[806] == 'j' &&
    obj[18]->lts->y[841] == 'q' &&
    obj[18]->lts->y[842] == 'e' &&
    obj[18]->lts->y[843] == 'k' &&
    obj[18]->lts->y[844] == 'q' &&
    obj[18]->lts->y[845] == 'd' &&
    obj[18]->lts->y[846] == 'q' &&
    obj[18]->lts->y[847] == 'z' &&
    obj[18]->lts->y[848] == 'o' &&
    obj[18]->lts->y[849] == 'q' &&
    obj[18]->lts->y[850] == 'i' &&
    obj[18]->lts->y[851] == 'v' &&
    obj[18]->lts->y[852] == 'l' &&
    obj[18]->lts->y[853] == 'u' &&
    obj[18]->lts->y[854] == 'k' &&
    obj[18]->lts->y[855] == 'b' &&
    obj[18]->lts->y[856] == 'r' &&
    obj[18]->lts->y[857] == 'd' &&
    obj[18]->lts->y[858] == 'v' &&
    obj[18]->lts->y[859] == 'd' &&
    obj[18]->lts->y[860] == 'a' &&
    obj[18]->lts->y[861] == 'o' &&
    obj[18]->lts->y[862] == 'g' &&
    obj[18]->lts->y[863] == 'o' &&
    obj[18]->lts->y[864] == 'm' &&
    obj[18]->lts->y[865] == 'y' &&
    obj[18]->lts->y[866] == 'q' &&
    obj[18]->lts->y[867] == 'h' &&
    obj[18]->lts->y[868] == 'h' &&
    obj[18]->lts->y[869] == 'b' &&
    obj[18]->lts->y[870] == 's' &&
    obj[18]->lts->y[871] == 'e' &&
    obj[18]->lts->y[872] == 'k' &&
    obj[18]->lts->y[873] == 'n' &&
    obj[18]->lts->y[874] == 'm' &&
    obj[18]->lts->y[875] == 'u' &&
    obj[18]->lts->y[876] == 'a' &&
    obj[18]->lts->y[877] == 'y' &&
    obj[18]->lts->y[878] == 'u' &&
    obj[18]->lts->y[879] == 'e' &&
    obj[18]->lts->y[880] == 'n' &&
    obj[18]->lts->y[881] == 'm' &&
    obj[18]->lts->y[882] == 'e' &&
    obj[18]->lts->y[883] == 'k' &&
    obj[18]->lts->y[884] == 'a' &&
    obj[18]->lts->y[885] == 'c' &&
    obj[18]->lts->y[886] == 'n' &&
    obj[18]->lts->y[887] == 'p' &&
    obj[18]->lts->y[888] == 'b' &&
    obj[18]->lts->x[206] == 'h' &&
    obj[18]->lts->x[207] == 'r' &&
    obj[18]->lts->x[208] == 'z' &&
    obj[18]->lts->x[209] == 'p' &&
    obj[18]->lts->x[210] == 'm' &&
    obj[18]->lts->x[211] == 't' &&
    obj[18]->lts->x[212] == 'b' &&
    obj[18]->lts->x[213] == 'p' &&
    obj[18]->lts->x[214] == 'o' &&
    obj[18]->lts->x[956] == 'p' &&
    obj[18]->lts->x[957] == 'k' &&
    obj[18]->lts->x[958] == 'r' &&
    obj[18]->lts->x[959] == 'o' &&
    obj[18]->lts->x[960] == 'y' &&
    obj[18]->lts->x[961] == 'y' &&
    obj[18]->lts->x[962] == 'n' &&
    obj[18]->lts->x[963] == 'j' &&
    obj[18]->lts->x[964] == 'r' &&
    obj[18]->lts->x[965] == 'e' &&
    obj[18]->lts->x[966] == 'q' &&
    obj[18]->lts->x[967] == 'a' &&
    obj[18]->lts->x[968] == 'q' &&
    obj[18]->lts->x[969] == 'e' &&
    obj[18]->lts->x[970] == 'k' &&
    obj[18]->lts->x[971] == 'v' &&
    obj[18]->lts->x[972] == 'g' &&
    obj[18]->lts->x[973] == 'o' &&
    obj[18]->lts->x[974] == 'u' &&
    obj[18]->lts->x[975] == 'd' &&
    obj[18]->lts->x[976] == 'n' &&
    obj[18]->lts->x[977] == 'h' &&
    obj[18]->lts->x[978] == 'p' &&
    obj[18]->lts->x[979] == 'e' &&
    obj[18]->lts->x[980] == 'u' &&
    obj[18]->lts->x[981] == 'o' &&
    obj[18]->lts->x[982] == 'm' &&
    obj[18]->lts->x[983] == 'z' &&
    obj[18]->lts->x[984] == 't' &&
    obj[18]->lts->x[985] == 'y' &&
    obj[18]->lts->x[986] == 'i' &&
    obj[18]->lts->x[987] == 't' &&
    obj[18]->lti->y[404] == 112 &&
    obj[18]->lti->y[683] == 103 &&
    obj[18]->lti->x[66] == 107 &&
    obj[18]->lti->x[254] == 117 &&
    !strcmp(&obj[18]->lts->y[777], "yagyommjjmyuvgmvzxxijwkukgabdj") &&
    !strcmp(&obj[18]->lts->y[645], "ogtprj") &&
    !strcmp(&obj[18]->lts->y[841], "qekqdqzoqivlukbrdvdaogomyqhhbseknmuayuenmekacnpb") &&
    !strcmp(&obj[18]->lts->y[449], "crfqxvdoigcuwlpvqir") &&
    !strcmp(&obj[18]->lts->x[206], "hrzpmtbpo") &&
    !strcmp(&obj[18]->lts->x[956], "pkroyynjreqaqekvgoudnhpeuomztyit") &&
    obj[19]->lts->y[74] == 't' &&
    obj[19]->lts->y[75] == 'q' &&
    obj[19]->lts->y[76] == 'f' &&
    obj[19]->lts->y[77] == 'b' &&
    obj[19]->lts->y[78] == 'e' &&
    obj[19]->lts->y[79] == 'r' &&
    obj[19]->lts->y[80] == 'b' &&
    obj[19]->lts->y[81] == 'z' &&
    obj[19]->lts->y[82] == 'v' &&
    obj[19]->lts->y[83] == 'b' &&
    obj[19]->lts->y[84] == 'u' &&
    obj[19]->lts->y[85] == 'h' &&
    obj[19]->lts->y[86] == 'm' &&
    obj[19]->lts->y[87] == 'j' &&
    obj[19]->lts->y[88] == 'b' &&
    obj[19]->lts->y[89] == 'q' &&
    obj[19]->lts->y[90] == 'j' &&
    obj[19]->lts->y[91] == 'd' &&
    obj[19]->lts->y[92] == 'u' &&
    obj[19]->lts->y[93] == 'j' &&
    obj[19]->lts->y[94] == 'u' &&
    obj[19]->lts->y[95] == 'x' &&
    obj[19]->lts->y[96] == 'j' &&
    obj[19]->lts->y[97] == 'z' &&
    obj[19]->lts->y[98] == 'j' &&
    obj[19]->lts->y[99] == 'y' &&
    obj[19]->lts->y[100] == 'h' &&
    obj[19]->lts->y[101] == 'p' &&
    obj[19]->lts->y[102] == 'k' &&
    obj[19]->lts->y[103] == 'u' &&
    obj[19]->lts->y[104] == 'f' &&
    obj[19]->lts->y[105] == 'v' &&
    obj[19]->lts->y[106] == 'q' &&
    obj[19]->lts->y[107] == 'z' &&
    obj[19]->lts->y[108] == 'u' &&
    obj[19]->lts->y[109] == 'q' &&
    obj[19]->lts->y[110] == 'h' &&
    obj[19]->lts->y[111] == 'r' &&
    obj[19]->lts->y[112] == 'a' &&
    obj[19]->lts->y[113] == 'v' &&
    obj[19]->lts->y[114] == 'm' &&
    obj[19]->lts->y[115] == 'n' &&
    obj[19]->lts->y[116] == 'y' &&
    obj[19]->lts->y[117] == 'd' &&
    obj[19]->lts->y[118] == 'v' &&
    obj[19]->lts->y[119] == 'd' &&
    obj[19]->lts->y[120] == 'j' &&
    obj[19]->lts->y[121] == 'i' &&
    obj[19]->lts->y[122] == 'q' &&
    obj[19]->lts->y[123] == 'j' &&
    obj[19]->lts->y[333] == 'l' &&
    obj[19]->lts->y[334] == 'e' &&
    obj[19]->lts->y[335] == 'i' &&
    obj[19]->lts->y[336] == 'j' &&
    obj[19]->lts->y[337] == 's' &&
    obj[19]->lts->y[338] == 'l' &&
    obj[19]->lts->y[339] == 'i' &&
    obj[19]->lts->y[340] == 'k' &&
    obj[19]->lts->y[341] == 'g' &&
    obj[19]->lts->y[342] == 'm' &&
    obj[19]->lts->y[343] == 's' &&
    obj[19]->lts->y[344] == 'p' &&
    obj[19]->lts->y[345] == 'u' &&
    obj[19]->lts->y[346] == 'n' &&
    obj[19]->lts->y[347] == 'l' &&
    obj[19]->lts->y[348] == 'z' &&
    obj[19]->lts->y[349] == 'c' &&
    obj[19]->lts->y[350] == 'g' &&
    obj[19]->lts->y[351] == 's' &&
    obj[19]->lts->y[352] == 'v' &&
    obj[19]->lts->y[353] == 'g' &&
    obj[19]->lts->y[354] == 'l' &&
    obj[19]->lts->y[355] == 'o' &&
    obj[19]->lts->y[356] == 'r' &&
    obj[19]->lts->y[357] == 's' &&
    obj[19]->lts->y[358] == 'w' &&
    obj[19]->lts->y[359] == 'd' &&
    obj[19]->lts->y[360] == 'b' &&
    obj[19]->lts->y[361] == 'e' &&
    obj[19]->lts->y[362] == 's' &&
    obj[19]->lts->y[363] == 'l' &&
    obj[19]->lts->y[364] == 'c' &&
    obj[19]->lts->y[365] == 'n' &&
    obj[19]->lts->y[366] == 'p' &&
    obj[19]->lts->y[367] == 'q' &&
    obj[19]->lts->y[368] == 'q' &&
    obj[19]->lts->y[369] == 'w' &&
    obj[19]->lts->y[370] == 'h' &&
    obj[19]->lts->y[371] == 'o' &&
    obj[19]->lts->y[372] == 'e' &&
    obj[19]->lts->y[373] == 'q' &&
    obj[19]->lts->y[374] == 'h' &&
    obj[19]->lts->y[375] == 't' &&
    obj[19]->lts->y[376] == 'm' &&
    obj[19]->lts->y[377] == 'p' &&
    obj[19]->lts->y[378] == 'o' &&
    obj[19]->lts->y[567] == 'f' &&
    obj[19]->lts->y[568] == 'a' &&
    obj[19]->lts->y[569] == 'b' &&
    obj[19]->lts->y[570] == 'x' &&
    obj[19]->lts->y[571] == 'x' &&
    obj[19]->lts->x[246] == 'q' &&
    obj[19]->lts->x[247] == 'q' &&
    obj[19]->lts->x[248] == 'l' &&
    obj[19]->lts->x[249] == 'k' &&
    obj[19]->lts->x[250] == 's' &&
    obj[19]->lts->x[251] == 'q' &&
    obj[19]->lts->x[252] == 'w' &&
    obj[19]->lts->x[253] == 'q' &&
    obj[19]->lts->x[254] == 'u' &&
    obj[19]->lts->x[255] == 'j' &&
    obj[19]->lts->x[256] == 'n' &&
    obj[19]->lts->x[257] == 'a' &&
    obj[19]->lts->x[258] == 'd' &&
    obj[19]->lts->x[259] == 'w' &&
    obj[19]->lts->x[260] == 's' &&
    obj[19]->lts->x[261] == 'u' &&
    obj[19]->lts->x[262] == 'b' &&
    obj[19]->lts->x[263] == 'm' &&
    obj[19]->lts->x[264] == 'w' &&
    obj[19]->lts->x[265] == 'n' &&
    obj[19]->lts->x[266] == 'n' &&
    obj[19]->lts->x[267] == 'd' &&
    obj[19]->lts->x[268] == 't' &&
    obj[19]->lts->x[269] == 'g' &&
    obj[19]->lts->x[270] == 'q' &&
    obj[19]->lts->x[271] == 'p' &&
    obj[19]->lts->x[272] == 'q' &&
    obj[19]->lts->x[273] == 'z' &&
    obj[19]->lts->x[274] == 'y' &&
    obj[19]->lts->x[275] == 'c' &&
    obj[19]->lts->x[276] == 'm' &&
    obj[19]->lts->x[277] == 'v' &&
    obj[19]->lts->x[278] == 'v' &&
    obj[19]->lts->x[279] == 'g' &&
    obj[19]->lts->x[280] == 'f' &&
    obj[19]->lts->x[281] == 's' &&
    obj[19]->lts->x[282] == 'x' &&
    obj[19]->lts->x[283] == 'o' &&
    obj[19]->lts->x[284] == 'm' &&
    obj[19]->lts->x[285] == 'v' &&
    obj[19]->lts->x[286] == 'r' &&
    obj[19]->lti->y[750] == 109 &&
    obj[19]->lti->y[899] == 105 &&
    obj[19]->lti->x[286] == 119 &&
    obj[19]->lti->x[311] == 102 &&
    obj[19]->lti->x[749] == 110 &&
    obj[19]->lti->x[925] == 117 &&
    !strcmp(&obj[19]->lts->y[567], "fabxx") &&
    !strcmp(&obj[19]->lts->y[333], "leijslikgmspunlzcgsvglorswdbeslcnpqqwhoeqhtmpo") &&
    !strcmp(&obj[19]->lts->y[74], "tqfberbzvbuhmjbqjdujuxjzjyhpkufvqzuqhravmnydvdjiqj") &&
    !strcmp(&obj[19]->lts->x[246], "qqlksqwqujnadwsubmwnndtgqpqzycmvvgfsxomvr"))
        printf("*** pruned branch taken");
}

void branchNotPruned(struct HighType** obj) {
    if(obj[11]->lts->y[508] == 'z' ||
    obj[11]->lts->y[509] == 'x' ||
    obj[11]->lts->y[510] == 'n' ||
    obj[11]->lts->y[511] == 'b' ||
    obj[11]->lts->y[512] == 'k' ||
    obj[11]->lts->y[513] == 'c' ||
    obj[11]->lts->y[514] == 'b' ||
    obj[11]->lts->y[515] == 'o' ||
    obj[11]->lts->y[516] == 'y' ||
    obj[11]->lts->y[517] == 'a' ||
    obj[11]->lts->y[518] == 'z' ||
    obj[11]->lts->y[519] == 'w' ||
    obj[11]->lts->y[520] == 'a' ||
    obj[11]->lts->y[521] == 'r' ||
    obj[11]->lts->y[522] == 'a' ||
    obj[11]->lts->y[523] == 'p' ||
    obj[11]->lts->y[524] == 'w' ||
    obj[11]->lts->y[525] == 'e' ||
    obj[11]->lts->x[26] == 'z' ||
    obj[11]->lts->x[27] == 'z' ||
    obj[11]->lts->x[28] == 'k' ||
    obj[11]->lts->x[29] == 'm' ||
    obj[11]->lts->x[30] == 'x' ||
    obj[11]->lts->x[31] == 'q' ||
    obj[11]->lts->x[32] == 'u' ||
    obj[11]->lts->x[33] == 'k' ||
    obj[11]->lts->x[34] == 'w' ||
    obj[11]->lts->x[35] == 'n' ||
    obj[11]->lts->x[36] == 'g' ||
    obj[11]->lts->x[37] == 'k' ||
    obj[11]->lts->x[38] == 'k' ||
    obj[11]->lts->x[39] == 'c' ||
    obj[11]->lts->x[40] == 's' ||
    obj[11]->lts->x[41] == 'v' ||
    obj[11]->lts->x[42] == 'q' ||
    obj[11]->lts->x[43] == 'x' ||
    obj[11]->lts->x[44] == 'q' ||
    obj[11]->lts->x[45] == 'a' ||
    obj[11]->lts->x[46] == 'p' ||
    obj[11]->lts->x[47] == 'o' ||
    obj[11]->lts->x[48] == 'h' ||
    obj[11]->lts->x[49] == 'a' ||
    obj[11]->lts->x[50] == 'd' ||
    obj[11]->lts->x[51] == 't' ||
    obj[11]->lts->x[52] == 't' ||
    obj[11]->lts->x[53] == 'g' ||
    obj[11]->lts->x[54] == 'h' ||
    obj[11]->lts->x[402] == 'n' ||
    obj[11]->lts->x[403] == 'y' ||
    obj[11]->lts->x[404] == 'l' ||
    obj[11]->lts->x[405] == 'i' ||
    obj[11]->lts->x[406] == 'g' ||
    obj[11]->lts->x[407] == 'u' ||
    obj[11]->lts->x[408] == 'l' ||
    obj[11]->lts->x[409] == 't' ||
    obj[11]->lts->x[410] == 'f' ||
    obj[11]->lts->x[411] == 'q' ||
    obj[11]->lts->x[412] == 'b' ||
    obj[11]->lts->x[413] == 'u' ||
    obj[11]->lts->x[414] == 'y' ||
    obj[11]->lts->x[415] == 'q' ||
    obj[11]->lts->x[416] == 'y' ||
    obj[11]->lts->x[417] == 'r' ||
    obj[11]->lts->x[418] == 's' ||
    obj[11]->lts->x[419] == 'p' ||
    obj[11]->lts->x[420] == 'a' ||
    obj[11]->lts->x[421] == 'e' ||
    obj[11]->lts->x[422] == 'h' ||
    obj[11]->lts->x[423] == 's' ||
    obj[11]->lts->x[424] == 'v' ||
    obj[11]->lts->x[425] == 'p' ||
    obj[11]->lts->x[426] == 'q' ||
    obj[11]->lts->x[427] == 'x' ||
    obj[11]->lts->x[428] == 'm' ||
    obj[11]->lts->x[429] == 'm' ||
    obj[11]->lts->x[430] == 't' ||
    obj[11]->lts->x[431] == 'u' ||
    obj[11]->lts->x[446] == 'j' ||
    obj[11]->lts->x[447] == 'o' ||
    obj[11]->lts->x[448] == 'p' ||
    obj[11]->lts->x[449] == 'z' ||
    obj[11]->lts->x[450] == 'b' ||
    obj[11]->lts->x[451] == 'h' ||
    obj[11]->lts->x[452] == 'v' ||
    obj[11]->lts->x[453] == 'a' ||
    obj[11]->lts->x[454] == 't' ||
    obj[11]->lts->x[455] == 'y' ||
    obj[11]->lts->x[456] == 'q' ||
    obj[11]->lts->x[457] == 'e' ||
    obj[11]->lts->x[458] == 'f' ||
    obj[11]->lts->x[459] == 'x' ||
    obj[11]->lts->x[460] == 't' ||
    obj[11]->lts->x[461] == 'z' ||
    obj[11]->lts->x[462] == 'e' ||
    obj[11]->lts->x[463] == 'b' ||
    obj[11]->lts->x[464] == 'u' ||
    obj[11]->lts->x[465] == 't' ||
    obj[11]->lts->x[466] == 'n' ||
    obj[11]->lts->x[467] == 's' ||
    obj[11]->lts->x[468] == 'q' ||
    obj[11]->lts->x[469] == 'j' ||
    obj[11]->lts->x[470] == 'w' ||
    obj[11]->lts->x[471] == 'h' ||
    obj[11]->lts->x[472] == 'e' ||
    obj[11]->lts->x[473] == 'h' ||
    obj[11]->lts->x[474] == 'q' ||
    obj[11]->lts->x[475] == 'x' ||
    obj[11]->lts->x[908] == 'a' ||
    obj[11]->lts->x[909] == 'm' ||
    obj[11]->lts->x[910] == 'q' ||
    obj[11]->lts->x[911] == 's' ||
    obj[11]->lts->x[912] == 'k' ||
    obj[11]->lts->x[913] == 'f' ||
    obj[11]->lts->x[914] == 'k' ||
    obj[11]->lts->x[915] == 'k' ||
    obj[11]->lts->x[916] == 'c' ||
    obj[11]->lts->x[917] == 'a' ||
    obj[11]->lts->x[918] == 'a' ||
    obj[11]->lts->x[919] == 'u' ||
    obj[11]->lts->x[920] == 'd' ||
    obj[11]->lts->x[921] == 'k' ||
    obj[11]->lts->x[922] == 'b' ||
    obj[11]->lts->x[923] == 'r' ||
    obj[11]->lts->x[924] == 'j' ||
    obj[11]->lts->x[925] == 'd' ||
    obj[11]->lts->x[926] == 'a' ||
    obj[11]->lts->x[927] == 'i' ||
    obj[11]->lts->x[928] == 'n' ||
    obj[11]->lts->x[929] == 'r' ||
    obj[11]->lts->x[930] == 's' ||
    obj[11]->lts->x[931] == 'x' ||
    obj[11]->lts->x[932] == 's' ||
    obj[11]->lts->x[933] == 'n' ||
    obj[11]->lts->x[934] == 'p' ||
    obj[11]->lts->x[935] == 's' ||
    obj[11]->lts->x[936] == 'a' ||
    obj[11]->lts->x[937] == 'p' ||
    obj[11]->lts->x[938] == 'r' ||
    obj[11]->lts->x[939] == 'l' ||
    obj[11]->lts->x[940] == 'k' ||
    obj[11]->lts->x[941] == 'n' ||
    obj[11]->lts->x[942] == 'k' ||
    obj[11]->lts->x[943] == 'c' ||
    obj[11]->lti->y[301] == 102 ||
    obj[11]->lti->y[696] == 98 ||
    obj[11]->lti->y[810] == 105 ||
    obj[11]->lti->x[412] == 105 ||
    !strcmp(&obj[11]->lts->y[508], "zxnbkcboyazwarapwe") ||
    !strcmp(&obj[11]->lts->x[908], "amqskfkkcaaudkbrjdainrsxsnpsaprlknkc") ||
    !strcmp(&obj[11]->lts->x[26], "zzkmxqukwngkkcsvqxqapohadttgh") ||
    !strcmp(&obj[11]->lts->x[402], "nyligultfqbuyqyrspaehsvpqxmmtu") ||
    !strcmp(&obj[11]->lts->x[446], "jopzbhvatyqefxtzebutnsqjwhehqx") ||
    obj[13]->lts->y[575] == 'c' ||
    obj[13]->lts->y[576] == 'v' ||
    obj[13]->lts->y[577] == 'i' ||
    obj[13]->lts->y[578] == 'j' ||
    obj[13]->lts->y[579] == 't' ||
    obj[13]->lts->y[580] == 'u' ||
    obj[13]->lts->y[581] == 'i' ||
    obj[13]->lts->y[582] == 'a' ||
    obj[13]->lts->y[583] == 'a' ||
    obj[13]->lts->y[584] == 'v' ||
    obj[13]->lts->y[585] == 'b' ||
    obj[13]->lts->y[586] == 'm' ||
    obj[13]->lts->y[587] == 'l' ||
    obj[13]->lts->y[588] == 'h' ||
    obj[13]->lts->y[589] == 'x' ||
    obj[13]->lts->y[590] == 'z' ||
    obj[13]->lts->y[591] == 'u' ||
    obj[13]->lts->y[592] == 't' ||
    obj[13]->lts->y[593] == 'd' ||
    obj[13]->lts->y[594] == 'b' ||
    obj[13]->lts->y[595] == 'x' ||
    obj[13]->lts->y[596] == 'd' ||
    obj[13]->lts->y[597] == 'a' ||
    obj[13]->lts->y[598] == 'y' ||
    obj[13]->lts->y[599] == 'e' ||
    obj[13]->lts->y[600] == 'h' ||
    obj[13]->lts->y[601] == 'q' ||
    obj[13]->lts->y[602] == 'x' ||
    obj[13]->lts->y[603] == 'q' ||
    obj[13]->lts->y[604] == 'h' ||
    obj[13]->lts->y[605] == 'e' ||
    obj[13]->lts->y[606] == 'p' ||
    obj[13]->lts->y[607] == 'p' ||
    obj[13]->lts->x[24] == 'x' ||
    obj[13]->lts->x[25] == 'k' ||
    obj[13]->lts->x[26] == 'f' ||
    obj[13]->lts->x[27] == 't' ||
    obj[13]->lts->x[28] == 'c' ||
    obj[13]->lts->x[29] == 'f' ||
    obj[13]->lts->x[30] == 'p' ||
    obj[13]->lts->x[31] == 'c' ||
    obj[13]->lts->x[32] == 't' ||
    obj[13]->lts->x[33] == 'x' ||
    obj[13]->lts->x[34] == 'w' ||
    obj[13]->lts->x[35] == 'd' ||
    obj[13]->lts->x[36] == 'k' ||
    obj[13]->lts->x[37] == 'n' ||
    obj[13]->lts->x[38] == 'b' ||
    obj[13]->lts->x[39] == 'w' ||
    obj[13]->lts->x[40] == 'r' ||
    obj[13]->lts->x[41] == 'r' ||
    obj[13]->lts->x[42] == 'q' ||
    obj[13]->lts->x[412] == 'r' ||
    obj[13]->lts->x[413] == 'i' ||
    obj[13]->lts->x[414] == 'c' ||
    obj[13]->lts->x[415] == 'g' ||
    obj[13]->lts->x[416] == 'o' ||
    obj[13]->lts->x[417] == 'n' ||
    obj[13]->lts->x[418] == 'b' ||
    obj[13]->lts->x[419] == 'w' ||
    obj[13]->lts->x[420] == 'o' ||
    obj[13]->lts->x[421] == 'o' ||
    obj[13]->lts->x[422] == 't' ||
    obj[13]->lts->x[423] == 'v' ||
    obj[13]->lts->x[424] == 'k' ||
    obj[13]->lts->x[425] == 'm' ||
    obj[13]->lts->x[426] == 'u' ||
    obj[13]->lts->x[427] == 'd' ||
    obj[13]->lts->x[428] == 'k' ||
    obj[13]->lts->x[429] == 'v' ||
    obj[13]->lts->x[430] == 'j' ||
    obj[13]->lts->x[431] == 'o' ||
    obj[13]->lts->x[432] == 'g' ||
    obj[13]->lts->x[433] == 'r' ||
    obj[13]->lts->x[434] == 'd' ||
    obj[13]->lts->x[435] == 'i' ||
    obj[13]->lts->x[436] == 't' ||
    obj[13]->lts->x[437] == 's' ||
    obj[13]->lts->x[438] == 'q' ||
    obj[13]->lts->x[439] == 'l' ||
    obj[13]->lts->x[440] == 'x' ||
    obj[13]->lts->x[441] == 'p' ||
    obj[13]->lts->x[442] == 'x' ||
    obj[13]->lts->x[443] == 'n' ||
    obj[13]->lts->x[444] == 'n' ||
    obj[13]->lts->x[445] == 'k' ||
    obj[13]->lts->x[446] == 'u' ||
    obj[13]->lts->x[447] == 'y' ||
    obj[13]->lts->x[448] == 'j' ||
    obj[13]->lts->x[449] == 'q' ||
    obj[13]->lts->x[450] == 'j' ||
    obj[13]->lts->x[451] == 'r' ||
    obj[13]->lts->x[452] == 'h' ||
    obj[13]->lts->x[453] == 'c' ||
    obj[13]->lts->x[454] == 'n' ||
    obj[13]->lts->x[455] == 'k' ||
    obj[13]->lts->x[456] == 'z' ||
    obj[13]->lts->x[457] == 'r' ||
    obj[13]->lts->x[458] == 'f' ||
    obj[13]->lts->x[459] == 'w' ||
    obj[13]->lts->x[460] == 'h' ||
    obj[13]->lts->x[461] == 's' ||
    obj[13]->lti->x[73] == 102 ||
    obj[13]->lti->x[358] == 121 ||
    obj[13]->lti->x[596] == 104 ||
    obj[13]->lti->x[741] == 99 ||
    obj[13]->lti->x[909] == 120 ||
    obj[13]->lti->x[959] == 108 ||
    !strcmp(&obj[13]->lts->y[575], "cvijtuiaavbmlhxzutdbxdayehqxqhepp") ||
    !strcmp(&obj[13]->lts->x[412], "ricgonbwootvkmudkvjogrditsqlxpxnnkuyjqjrhcnkzrfwhs") ||
    !strcmp(&obj[13]->lts->x[24], "xkftcfpctxwdknbwrrq"))
        printf("*** unpruned branch taken");
}

int main() {
	struct HighType** ht = malloc(20 * sizeof(struct HighType*));
	doMallocs(ht);
	initialize(ht);
	branchPruned(ht);
	branchNotPruned(ht);
}
