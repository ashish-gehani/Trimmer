
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
struct HighType** ht;
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

void doMallocs() {
    ht[0] = createHighType();
    ht[1] = createHighType();
    ht[2] = createHighType();
    ht[6] = createHighType();
    ht[7] = createHighType();
}
void initialize() {
    memcpy(&ht[0]->lts->y[565], "kamselhwtp", 10);
    ht[0]->lti->y[643] = 118;
    memcpy(&ht[0]->lts->x[555], "dafcdkpdejuojwkxwxcfeqetcxxtuurbawudidaigrgaaxm", 47);
    memcpy(&ht[0]->lts->y[926], "lurompjzjbdyahmvgcbkruvdfhvkugyi", 32);
    ht[0]->lti->y[386] = 105;
    ht[1]->lti->x[164] = 103;
    ht[1]->lti->y[584] = 102;
    memcpy(&ht[1]->lts->x[531], "kdejtioukhe", 11);
    ht[1]->lti->x[238] = 104;
    memcpy(&ht[1]->lts->y[72], "hspfhexgzgbzwibzmqzxkrnnodevcyxmuxqrsgmcuqnemdtm", 48);
    memcpy(&ht[2]->lts->y[109], "a", 1);
    ht[2]->lti->y[813] = 121;
    memcpy(&ht[2]->lts->x[77], "fvzzuqwxfjkdtshhpjmvrfabyyvnamnfrazatptnyyudcqbdy", 49);
    ht[2]->lti->x[765] = 107;
    ht[2]->lti->y[712] = 102;
    memcpy(&ht[6]->lts->x[738], "sdaobydzkcwsyfkebetsdqlovhggaslnfihbezjywbzuj", 45);
    externalFunc(ht[6]);
    ht[6]->lti->x[492] = 113;
    ht[6]->lti->x[661] = 111;
    ht[6]->lti->y[905] = 113;
    ht[7]->lti->x[144] = 116;
    memcpy(&ht[7]->lts->y[596], "sayqxunl", 8);
    ht[7]->lti->x[565] = 117;
    externalFunc(ht[7]);
    ht[7]->lti->x[31] = 113;
}
void branchPruned() {
    if(ht[0]->lts->y[565] == 'k' &&
    ht[0]->lts->y[566] == 'a' &&
    ht[0]->lts->y[567] == 'm' &&
    ht[0]->lts->y[568] == 's' &&
    ht[0]->lts->y[569] == 'e' &&
    ht[0]->lts->y[570] == 'l' &&
    ht[0]->lts->y[571] == 'h' &&
    ht[0]->lts->y[572] == 'w' &&
    ht[0]->lts->y[573] == 't' &&
    ht[0]->lts->y[574] == 'p' &&
    ht[0]->lts->y[926] == 'l' &&
    ht[0]->lts->y[927] == 'u' &&
    ht[0]->lts->y[928] == 'r' &&
    ht[0]->lts->y[929] == 'o' &&
    ht[0]->lts->y[930] == 'm' &&
    ht[0]->lts->y[931] == 'p' &&
    ht[0]->lts->y[932] == 'j' &&
    ht[0]->lts->y[933] == 'z' &&
    ht[0]->lts->y[934] == 'j' &&
    ht[0]->lts->y[935] == 'b' &&
    ht[0]->lts->y[936] == 'd' &&
    ht[0]->lts->y[937] == 'y' &&
    ht[0]->lts->y[938] == 'a' &&
    ht[0]->lts->y[939] == 'h' &&
    ht[0]->lts->y[940] == 'm' &&
    ht[0]->lts->y[941] == 'v' &&
    ht[0]->lts->y[942] == 'g' &&
    ht[0]->lts->y[943] == 'c' &&
    ht[0]->lts->y[944] == 'b' &&
    ht[0]->lts->y[945] == 'k' &&
    ht[0]->lts->y[946] == 'r' &&
    ht[0]->lts->y[947] == 'u' &&
    ht[0]->lts->y[948] == 'v' &&
    ht[0]->lts->y[949] == 'd' &&
    ht[0]->lts->y[950] == 'f' &&
    ht[0]->lts->y[951] == 'h' &&
    ht[0]->lts->y[952] == 'v' &&
    ht[0]->lts->y[953] == 'k' &&
    ht[0]->lts->y[954] == 'u' &&
    ht[0]->lts->y[955] == 'g' &&
    ht[0]->lts->y[956] == 'y' &&
    ht[0]->lts->y[957] == 'i' &&
    ht[0]->lts->x[555] == 'd' &&
    ht[0]->lts->x[556] == 'a' &&
    ht[0]->lts->x[557] == 'f' &&
    ht[0]->lts->x[558] == 'c' &&
    ht[0]->lts->x[559] == 'd' &&
    ht[0]->lts->x[560] == 'k' &&
    ht[0]->lts->x[561] == 'p' &&
    ht[0]->lts->x[562] == 'd' &&
    ht[0]->lts->x[563] == 'e' &&
    ht[0]->lts->x[564] == 'j' &&
    ht[0]->lts->x[565] == 'u' &&
    ht[0]->lts->x[566] == 'o' &&
    ht[0]->lts->x[567] == 'j' &&
    ht[0]->lts->x[568] == 'w' &&
    ht[0]->lts->x[569] == 'k' &&
    ht[0]->lts->x[570] == 'x' &&
    ht[0]->lts->x[571] == 'w' &&
    ht[0]->lts->x[572] == 'x' &&
    ht[0]->lts->x[573] == 'c' &&
    ht[0]->lts->x[574] == 'f' &&
    ht[0]->lts->x[575] == 'e' &&
    ht[0]->lts->x[576] == 'q' &&
    ht[0]->lts->x[577] == 'e' &&
    ht[0]->lts->x[578] == 't' &&
    ht[0]->lts->x[579] == 'c' &&
    ht[0]->lts->x[580] == 'x' &&
    ht[0]->lts->x[581] == 'x' &&
    ht[0]->lts->x[582] == 't' &&
    ht[0]->lts->x[583] == 'u' &&
    ht[0]->lts->x[584] == 'u' &&
    ht[0]->lts->x[585] == 'r' &&
    ht[0]->lts->x[586] == 'b' &&
    ht[0]->lts->x[587] == 'a' &&
    ht[0]->lts->x[588] == 'w' &&
    ht[0]->lts->x[589] == 'u' &&
    ht[0]->lts->x[590] == 'd' &&
    ht[0]->lts->x[591] == 'i' &&
    ht[0]->lts->x[592] == 'd' &&
    ht[0]->lts->x[593] == 'a' &&
    ht[0]->lts->x[594] == 'i' &&
    ht[0]->lts->x[595] == 'g' &&
    ht[0]->lts->x[596] == 'r' &&
    ht[0]->lts->x[597] == 'g' &&
    ht[0]->lts->x[598] == 'a' &&
    ht[0]->lts->x[599] == 'a' &&
    ht[0]->lts->x[600] == 'x' &&
    ht[0]->lts->x[601] == 'm' &&
    ht[0]->lti->y[386] == 105 &&
    ht[0]->lti->y[643] == 118 &&
    !strcmp(&ht[0]->lts->y[565], "kamselhwtp") &&
    !strcmp(&ht[0]->lts->y[926], "lurompjzjbdyahmvgcbkruvdfhvkugyi") &&
    !strcmp(&ht[0]->lts->x[555], "dafcdkpdejuojwkxwxcfeqetcxxtuurbawudidaigrgaaxm") &&
    ht[1]->lts->y[72] == 'h' &&
    ht[1]->lts->y[73] == 's' &&
    ht[1]->lts->y[74] == 'p' &&
    ht[1]->lts->y[75] == 'f' &&
    ht[1]->lts->y[76] == 'h' &&
    ht[1]->lts->y[77] == 'e' &&
    ht[1]->lts->y[78] == 'x' &&
    ht[1]->lts->y[79] == 'g' &&
    ht[1]->lts->y[80] == 'z' &&
    ht[1]->lts->y[81] == 'g' &&
    ht[1]->lts->y[82] == 'b' &&
    ht[1]->lts->y[83] == 'z' &&
    ht[1]->lts->y[84] == 'w' &&
    ht[1]->lts->y[85] == 'i' &&
    ht[1]->lts->y[86] == 'b' &&
    ht[1]->lts->y[87] == 'z' &&
    ht[1]->lts->y[88] == 'm' &&
    ht[1]->lts->y[89] == 'q' &&
    ht[1]->lts->y[90] == 'z' &&
    ht[1]->lts->y[91] == 'x' &&
    ht[1]->lts->y[92] == 'k' &&
    ht[1]->lts->y[93] == 'r' &&
    ht[1]->lts->y[94] == 'n' &&
    ht[1]->lts->y[95] == 'n' &&
    ht[1]->lts->y[96] == 'o' &&
    ht[1]->lts->y[97] == 'd' &&
    ht[1]->lts->y[98] == 'e' &&
    ht[1]->lts->y[99] == 'v' &&
    ht[1]->lts->y[100] == 'c' &&
    ht[1]->lts->y[101] == 'y' &&
    ht[1]->lts->y[102] == 'x' &&
    ht[1]->lts->y[103] == 'm' &&
    ht[1]->lts->y[104] == 'u' &&
    ht[1]->lts->y[105] == 'x' &&
    ht[1]->lts->y[106] == 'q' &&
    ht[1]->lts->y[107] == 'r' &&
    ht[1]->lts->y[108] == 's' &&
    ht[1]->lts->y[109] == 'g' &&
    ht[1]->lts->y[110] == 'm' &&
    ht[1]->lts->y[111] == 'c' &&
    ht[1]->lts->y[112] == 'u' &&
    ht[1]->lts->y[113] == 'q' &&
    ht[1]->lts->y[114] == 'n' &&
    ht[1]->lts->y[115] == 'e' &&
    ht[1]->lts->y[116] == 'm' &&
    ht[1]->lts->y[117] == 'd' &&
    ht[1]->lts->y[118] == 't' &&
    ht[1]->lts->y[119] == 'm' &&
    ht[1]->lts->x[531] == 'k' &&
    ht[1]->lts->x[532] == 'd' &&
    ht[1]->lts->x[533] == 'e' &&
    ht[1]->lts->x[534] == 'j' &&
    ht[1]->lts->x[535] == 't' &&
    ht[1]->lts->x[536] == 'i' &&
    ht[1]->lts->x[537] == 'o' &&
    ht[1]->lts->x[538] == 'u' &&
    ht[1]->lts->x[539] == 'k' &&
    ht[1]->lts->x[540] == 'h' &&
    ht[1]->lts->x[541] == 'e' &&
    ht[1]->lti->y[584] == 102 &&
    ht[1]->lti->x[164] == 103 &&
    ht[1]->lti->x[238] == 104 &&
    !strcmp(&ht[1]->lts->y[72], "hspfhexgzgbzwibzmqzxkrnnodevcyxmuxqrsgmcuqnemdtm") &&
    !strcmp(&ht[1]->lts->x[531], "kdejtioukhe") &&
    ht[2]->lts->y[109] == 'a' &&
    ht[2]->lts->x[77] == 'f' &&
    ht[2]->lts->x[78] == 'v' &&
    ht[2]->lts->x[79] == 'z' &&
    ht[2]->lts->x[80] == 'z' &&
    ht[2]->lts->x[81] == 'u' &&
    ht[2]->lts->x[82] == 'q' &&
    ht[2]->lts->x[83] == 'w' &&
    ht[2]->lts->x[84] == 'x' &&
    ht[2]->lts->x[85] == 'f' &&
    ht[2]->lts->x[86] == 'j' &&
    ht[2]->lts->x[87] == 'k' &&
    ht[2]->lts->x[88] == 'd' &&
    ht[2]->lts->x[89] == 't' &&
    ht[2]->lts->x[90] == 's' &&
    ht[2]->lts->x[91] == 'h' &&
    ht[2]->lts->x[92] == 'h' &&
    ht[2]->lts->x[93] == 'p' &&
    ht[2]->lts->x[94] == 'j' &&
    ht[2]->lts->x[95] == 'm' &&
    ht[2]->lts->x[96] == 'v' &&
    ht[2]->lts->x[97] == 'r' &&
    ht[2]->lts->x[98] == 'f' &&
    ht[2]->lts->x[99] == 'a' &&
    ht[2]->lts->x[100] == 'b' &&
    ht[2]->lts->x[101] == 'y' &&
    ht[2]->lts->x[102] == 'y' &&
    ht[2]->lts->x[103] == 'v' &&
    ht[2]->lts->x[104] == 'n' &&
    ht[2]->lts->x[105] == 'a' &&
    ht[2]->lts->x[106] == 'm' &&
    ht[2]->lts->x[107] == 'n' &&
    ht[2]->lts->x[108] == 'f' &&
    ht[2]->lts->x[109] == 'r' &&
    ht[2]->lts->x[110] == 'a' &&
    ht[2]->lts->x[111] == 'z' &&
    ht[2]->lts->x[112] == 'a' &&
    ht[2]->lts->x[113] == 't' &&
    ht[2]->lts->x[114] == 'p' &&
    ht[2]->lts->x[115] == 't' &&
    ht[2]->lts->x[116] == 'n' &&
    ht[2]->lts->x[117] == 'y' &&
    ht[2]->lts->x[118] == 'y' &&
    ht[2]->lts->x[119] == 'u' &&
    ht[2]->lts->x[120] == 'd' &&
    ht[2]->lts->x[121] == 'c' &&
    ht[2]->lts->x[122] == 'q' &&
    ht[2]->lts->x[123] == 'b' &&
    ht[2]->lts->x[124] == 'd' &&
    ht[2]->lts->x[125] == 'y' &&
    ht[2]->lti->y[712] == 102 &&
    ht[2]->lti->y[813] == 121 &&
    ht[2]->lti->x[765] == 107 &&
    !strcmp(&ht[2]->lts->y[109], "a") &&
    !strcmp(&ht[2]->lts->x[77], "fvzzuqwxfjkdtshhpjmvrfabyyvnamnfrazatptnyyudcqbdy") &&
    ht[3] == NULL &&
    ht[4] == NULL &&
    ht[5] == NULL &&
    ht[8] == NULL &&
    ht[9] == NULL)
        printf("*** pruned branch taken");
}

void branchNotPruned() {
    if(ht[6]->lts->x[738] == 's' ||
    ht[6]->lts->x[739] == 'd' ||
    ht[6]->lts->x[740] == 'a' ||
    ht[6]->lts->x[741] == 'o' ||
    ht[6]->lts->x[742] == 'b' ||
    ht[6]->lts->x[743] == 'y' ||
    ht[6]->lts->x[744] == 'd' ||
    ht[6]->lts->x[745] == 'z' ||
    ht[6]->lts->x[746] == 'k' ||
    ht[6]->lts->x[747] == 'c' ||
    ht[6]->lts->x[748] == 'w' ||
    ht[6]->lts->x[749] == 's' ||
    ht[6]->lts->x[750] == 'y' ||
    ht[6]->lts->x[751] == 'f' ||
    ht[6]->lts->x[752] == 'k' ||
    ht[6]->lts->x[753] == 'e' ||
    ht[6]->lts->x[754] == 'b' ||
    ht[6]->lts->x[755] == 'e' ||
    ht[6]->lts->x[756] == 't' ||
    ht[6]->lts->x[757] == 's' ||
    ht[6]->lts->x[758] == 'd' ||
    ht[6]->lts->x[759] == 'q' ||
    ht[6]->lts->x[760] == 'l' ||
    ht[6]->lts->x[761] == 'o' ||
    ht[6]->lts->x[762] == 'v' ||
    ht[6]->lts->x[763] == 'h' ||
    ht[6]->lts->x[764] == 'g' ||
    ht[6]->lts->x[765] == 'g' ||
    ht[6]->lts->x[766] == 'a' ||
    ht[6]->lts->x[767] == 's' ||
    ht[6]->lts->x[768] == 'l' ||
    ht[6]->lts->x[769] == 'n' ||
    ht[6]->lts->x[770] == 'f' ||
    ht[6]->lts->x[771] == 'i' ||
    ht[6]->lts->x[772] == 'h' ||
    ht[6]->lts->x[773] == 'b' ||
    ht[6]->lts->x[774] == 'e' ||
    ht[6]->lts->x[775] == 'z' ||
    ht[6]->lts->x[776] == 'j' ||
    ht[6]->lts->x[777] == 'y' ||
    ht[6]->lts->x[778] == 'w' ||
    ht[6]->lts->x[779] == 'b' ||
    ht[6]->lts->x[780] == 'z' ||
    ht[6]->lts->x[781] == 'u' ||
    ht[6]->lts->x[782] == 'j' ||
    ht[6]->lti->y[905] == 113 ||
    ht[6]->lti->x[492] == 113 ||
    ht[6]->lti->x[661] == 111 ||
    !strcmp(&ht[6]->lts->x[738], "sdaobydzkcwsyfkebetsdqlovhggaslnfihbezjywbzuj") ||
    ht[7]->lts->y[596] == 's' ||
    ht[7]->lts->y[597] == 'a' ||
    ht[7]->lts->y[598] == 'y' ||
    ht[7]->lts->y[599] == 'q' ||
    ht[7]->lts->y[600] == 'x' ||
    ht[7]->lts->y[601] == 'u' ||
    ht[7]->lts->y[602] == 'n' ||
    ht[7]->lts->y[603] == 'l' ||
    ht[7]->lti->x[31] == 113 ||
    ht[7]->lti->x[144] == 116 ||
    ht[7]->lti->x[565] == 117 ||
    !strcmp(&ht[7]->lts->y[596], "sayqxunl"))
        printf("*** unpruned branch taken");
}

int main() {
	ht = malloc(10 * sizeof(struct HighType*));
	doMallocs();
	initialize();
	branchPruned();
	branchNotPruned();
}
