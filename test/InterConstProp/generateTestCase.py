import sys
import random

seed = 9001
tab = '    '

outName = sys.argv[1]
num_tests = int(sys.argv[2])

def genRand(range):
    global seed
    random.seed(seed)
    x = random.randint(1, range)
    seed += 1
    return x

def chooseHighVar():
	obj = genRand(2)
	if(obj == 1):
		return 'lti'
	else:
		return 'lts'

def chooseLowVar():
	obj = genRand(2)
	if(obj == 1):
		return 'x'
	else:
		return 'y'

def chooseIndex(ls):
	index = genRand(1000)
	for x in ls:
		if(index == x):
			return chooseIndex(ls)
	return index

def makeAssign(hvar, lvar, index, val):
	idxStr = '[' + str(index) + ']'
	return tab + 'obj->' + hvar + '.' + lvar + idxStr + ' = ' + str(val) + ';\n'

def makeCondAssign(hvar, lvar, index, val):
	idxStr = '[' + str(index) + ']'
	return tab + 'obj.' + hvar + '.' + lvar + idxStr + ' == ' + str(val) + ' &&\n'

def generateFuncs(num_lines):
	initStr = 'void initialize(struct HighType* obj) {\n'
	bpStr = 'void branchPruned(struct HighType obj){\n'
	indices = {}
	indices['ltix'] = []
	indices['ltiy'] = []
	indices['ltsx'] = []
	indices['ltsy'] = []

	Conds = ''
	for i in xrange(num_lines):
		hvar = chooseHighVar()
		lvar = chooseLowVar()
		index = chooseIndex(indices[hvar + lvar])
		indices[hvar + lvar].append(index)
		val = genRand(128)
		initStr += makeAssign(hvar, lvar, index, val)		
		Conds += makeCondAssign(hvar, lvar, index, val)
	initStr += '}\n'
	if(num_lines):
		Conds = tab + 'if(' + Conds[4:-4] + ')\n'
		Conds += tab + tab + 'printf("*** branchTaken");\n'
	bpStr += Conds + '}\n'
	return (initStr, bpStr)


libStr = '''
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
'''

structTypeStr = ''' 
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
'''

mainStr = '''
int main() {
	struct HighType ht;
	initialize(&ht);
	branchPruned(ht);
}
'''
(initStr, bpStr) = generateFuncs(num_tests)
toWrite = libStr + structTypeStr + initStr + bpStr + mainStr
fd = open(outName,'w')
fd.write(toWrite)

