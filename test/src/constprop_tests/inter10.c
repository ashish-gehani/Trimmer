
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
    memcpy(&obj->lts.x[645], "ygxxcdzafwiklhzyzdgzxa", 22);
    memcpy(&obj->lts.x[760], "gqtomhqmeajsw", 13);
    obj->lti.y[559] = 113;
    obj->lti.y[608] = 106;
    obj->lti.y[381] = 102;
    obj->lti.x[398] = 122;
    obj->lti.y[813] = 110;
    memcpy(&obj->lts.x[305], "mmnjzle", 7);
    memcpy(&obj->lts.y[796], "scopjbieaazzvnw", 15);
    memcpy(&obj->lts.y[662], "ysdsqcgxmmya", 12);
    memcpy(&obj->lts.y[75], "aufruuriyjqmaotagfqdmaxqve", 26);
    obj->lti.y[202] = 97;
    obj->lti.x[40] = 99;
    memcpy(&obj->lts.x[107], "dhmezuzq", 8);
    memcpy(&obj->lts.x[511], "ufbwlmtjwtspwbdhpwwat", 21);
    memcpy(&obj->lts.y[587], "tfdbkojwsyqsbmodersokpfu", 24);
    obj->lti.y[427] = 105;
    obj->lti.x[83] = 117;
    obj->lti.x[644] = 110;
    obj->lti.y[384] = 97;
    obj->lti.x[784] = 110;
    memcpy(&obj->lts.y[778], "swdwtkybghtdbrwzepsotsd", 23);
}
void branchPruned(struct HighType obj){
    if(obj.lts.y[75] == 97 &&
    obj.lts.y[76] == 117 &&
    obj.lts.y[77] == 102 &&
    obj.lts.y[78] == 114 &&
    obj.lts.y[79] == 117 &&
    obj.lts.y[80] == 117 &&
    obj.lts.y[81] == 114 &&
    obj.lts.y[82] == 105 &&
    obj.lts.y[83] == 121 &&
    obj.lts.y[84] == 106 &&
    obj.lts.y[85] == 113 &&
    obj.lts.y[86] == 109 &&
    obj.lts.y[87] == 97 &&
    obj.lts.y[88] == 111 &&
    obj.lts.y[89] == 116 &&
    obj.lts.y[90] == 97 &&
    obj.lts.y[91] == 103 &&
    obj.lts.y[92] == 102 &&
    obj.lts.y[93] == 113 &&
    obj.lts.y[94] == 100 &&
    obj.lts.y[95] == 109 &&
    obj.lts.y[96] == 97 &&
    obj.lts.y[97] == 120 &&
    obj.lts.y[98] == 113 &&
    obj.lts.y[99] == 118 &&
    obj.lts.y[100] == 101 &&
    obj.lts.y[587] == 116 &&
    obj.lts.y[588] == 102 &&
    obj.lts.y[589] == 100 &&
    obj.lts.y[590] == 98 &&
    obj.lts.y[591] == 107 &&
    obj.lts.y[592] == 111 &&
    obj.lts.y[593] == 106 &&
    obj.lts.y[594] == 119 &&
    obj.lts.y[595] == 115 &&
    obj.lts.y[596] == 121 &&
    obj.lts.y[597] == 113 &&
    obj.lts.y[598] == 115 &&
    obj.lts.y[599] == 98 &&
    obj.lts.y[600] == 109 &&
    obj.lts.y[601] == 111 &&
    obj.lts.y[602] == 100 &&
    obj.lts.y[603] == 101 &&
    obj.lts.y[604] == 114 &&
    obj.lts.y[605] == 115 &&
    obj.lts.y[606] == 111 &&
    obj.lts.y[607] == 107 &&
    obj.lts.y[608] == 112 &&
    obj.lts.y[609] == 102 &&
    obj.lts.y[610] == 117 &&
    obj.lts.y[662] == 121 &&
    obj.lts.y[663] == 115 &&
    obj.lts.y[664] == 100 &&
    obj.lts.y[665] == 115 &&
    obj.lts.y[666] == 113 &&
    obj.lts.y[667] == 99 &&
    obj.lts.y[668] == 103 &&
    obj.lts.y[669] == 120 &&
    obj.lts.y[670] == 109 &&
    obj.lts.y[671] == 109 &&
    obj.lts.y[672] == 121 &&
    obj.lts.y[673] == 97 &&
    obj.lts.y[778] == 115 &&
    obj.lts.y[779] == 119 &&
    obj.lts.y[780] == 100 &&
    obj.lts.y[781] == 119 &&
    obj.lts.y[782] == 116 &&
    obj.lts.y[783] == 107 &&
    obj.lts.y[784] == 121 &&
    obj.lts.y[785] == 98 &&
    obj.lts.y[786] == 103 &&
    obj.lts.y[787] == 104 &&
    obj.lts.y[788] == 116 &&
    obj.lts.y[789] == 100 &&
    obj.lts.y[790] == 98 &&
    obj.lts.y[791] == 114 &&
    obj.lts.y[792] == 119 &&
    obj.lts.y[793] == 122 &&
    obj.lts.y[794] == 101 &&
    obj.lts.y[795] == 112 &&
    obj.lts.y[796] == 115 &&
    obj.lts.y[797] == 111 &&
    obj.lts.y[798] == 116 &&
    obj.lts.y[799] == 115 &&
    obj.lts.y[800] == 100 &&
    obj.lts.y[801] == 98 &&
    obj.lts.y[802] == 105 &&
    obj.lts.y[803] == 101 &&
    obj.lts.y[804] == 97 &&
    obj.lts.y[805] == 97 &&
    obj.lts.y[806] == 122 &&
    obj.lts.y[807] == 122 &&
    obj.lts.y[808] == 118 &&
    obj.lts.y[809] == 110 &&
    obj.lts.y[810] == 119 &&
    obj.lts.x[107] == 100 &&
    obj.lts.x[108] == 104 &&
    obj.lts.x[109] == 109 &&
    obj.lts.x[110] == 101 &&
    obj.lts.x[111] == 122 &&
    obj.lts.x[112] == 117 &&
    obj.lts.x[113] == 122 &&
    obj.lts.x[114] == 113 &&
    obj.lts.x[305] == 109 &&
    obj.lts.x[306] == 109 &&
    obj.lts.x[307] == 110 &&
    obj.lts.x[308] == 106 &&
    obj.lts.x[309] == 122 &&
    obj.lts.x[310] == 108 &&
    obj.lts.x[311] == 101 &&
    obj.lts.x[511] == 117 &&
    obj.lts.x[512] == 102 &&
    obj.lts.x[513] == 98 &&
    obj.lts.x[514] == 119 &&
    obj.lts.x[515] == 108 &&
    obj.lts.x[516] == 109 &&
    obj.lts.x[517] == 116 &&
    obj.lts.x[518] == 106 &&
    obj.lts.x[519] == 119 &&
    obj.lts.x[520] == 116 &&
    obj.lts.x[521] == 115 &&
    obj.lts.x[522] == 112 &&
    obj.lts.x[523] == 119 &&
    obj.lts.x[524] == 98 &&
    obj.lts.x[525] == 100 &&
    obj.lts.x[526] == 104 &&
    obj.lts.x[527] == 112 &&
    obj.lts.x[528] == 119 &&
    obj.lts.x[529] == 119 &&
    obj.lts.x[530] == 97 &&
    obj.lts.x[531] == 116 &&
    obj.lts.x[645] == 121 &&
    obj.lts.x[646] == 103 &&
    obj.lts.x[647] == 120 &&
    obj.lts.x[648] == 120 &&
    obj.lts.x[649] == 99 &&
    obj.lts.x[650] == 100 &&
    obj.lts.x[651] == 122 &&
    obj.lts.x[652] == 97 &&
    obj.lts.x[653] == 102 &&
    obj.lts.x[654] == 119 &&
    obj.lts.x[655] == 105 &&
    obj.lts.x[656] == 107 &&
    obj.lts.x[657] == 108 &&
    obj.lts.x[658] == 104 &&
    obj.lts.x[659] == 122 &&
    obj.lts.x[660] == 121 &&
    obj.lts.x[661] == 122 &&
    obj.lts.x[662] == 100 &&
    obj.lts.x[663] == 103 &&
    obj.lts.x[664] == 122 &&
    obj.lts.x[665] == 120 &&
    obj.lts.x[666] == 97 &&
    obj.lts.x[760] == 103 &&
    obj.lts.x[761] == 113 &&
    obj.lts.x[762] == 116 &&
    obj.lts.x[763] == 111 &&
    obj.lts.x[764] == 109 &&
    obj.lts.x[765] == 104 &&
    obj.lts.x[766] == 113 &&
    obj.lts.x[767] == 109 &&
    obj.lts.x[768] == 101 &&
    obj.lts.x[769] == 97 &&
    obj.lts.x[770] == 106 &&
    obj.lts.x[771] == 115 &&
    obj.lts.x[772] == 119 &&
    obj.lti.y[202] == 97 &&
    obj.lti.y[335] == 112 &&
    obj.lti.y[381] == 102 &&
    obj.lti.y[384] == 97 &&
    obj.lti.y[427] == 105 &&
    obj.lti.y[559] == 113 &&
    obj.lti.y[608] == 106 &&
    obj.lti.y[813] == 110 &&
    obj.lti.x[40] == 99 &&
    obj.lti.x[83] == 117 &&
    obj.lti.x[398] == 122 &&
    obj.lti.x[534] == 106 &&
    obj.lti.x[569] == 122 &&
    obj.lti.x[644] == 110 &&
    obj.lti.x[784] == 110 &&
    !strcmp(&obj.lts.y[662], "ysdsqcgxmmya") &&
    !strcmp(&obj.lts.y[75], "aufruuriyjqmaotagfqdmaxqve") &&
    !strcmp(&obj.lts.y[587], "tfdbkojwsyqsbmodersokpfu") &&
    !strcmp(&obj.lts.y[778], "swdwtkybghtdbrwzepsotsdbieaazzvnw") &&
    !strcmp(&obj.lts.x[645], "ygxxcdzafwiklhzyzdgzxa") &&
    !strcmp(&obj.lts.x[760], "gqtomhqmeajsw") &&
    !strcmp(&obj.lts.x[305], "mmnjzle") &&
    !strcmp(&obj.lts.x[107], "dhmezuzq") &&
    !strcmp(&obj.lts.x[511], "ufbwlmtjwtspwbdhpwwat"))
        printf("*** branchTaken");
}

int main() {
	struct HighType ht;
	initialize(&ht);
	branchPruned(ht);
}
