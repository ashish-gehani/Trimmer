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


def makeAssign(hvar, lvar, index, val):
	idxStr = '[' + str(index) + ']'
	return tab + 'obj->' + hvar + '.' + lvar + idxStr + ' = ' + str(val) + ';\n'	

def makeMemCpy(hvar, lvar, index):
	idxStr = '[' + str(index) + ']'
	size = genRand(min(5, 1000 - index))
	val = ""
	ls = []
	for i in xrange(size):
		alph = genRand(26) + 96
		val += chr(alph)
		ls.append(alph)
	tup = (index, size)
	Str = tab + 'memcpy(&obj->' + hvar + '.' + lvar + idxStr + ', "' + val + '", ' + str(size) + ');\n'
	return (tup, Str, ls)

def makeCondAssign(hvar, lvar, index, val):
	idxStr = '[' + str(index) + ']'
	return tab + 'obj.' + hvar + '.' + lvar + idxStr + ' == ' + str(val) + ' &&\n'

def makeStrcmpCond(hvar, lvar, index, val):
	idxStr = '[' + str(index) + ']'
	return tab + '!strcmp(&obj.' + hvar + '.' + lvar + idxStr + ', "' + val + '") &&\n'

def generateFuncs(num_lines):
	initStr = 'void initialize(struct HighType* obj) {\n'
	bpStr = 'void branchPruned(struct HighType obj){\n'

	arrays = {}
	if(num_lines):
		arrays["ltsx"] = [-1] * 1000
		arrays["ltsy"] = [-1] * 1000
		arrays["ltix"] = [-1] * 1000
		arrays["ltiy"] = [-1] * 1000

	memCpyInds = {}
	memCpyInds["x"] = []
	memCpyInds["y"] = []
	
	for i in xrange(num_lines):
		hvar = chooseHighVar()
		lvar = chooseLowVar()
		index = genRand(1000)
		if(hvar == "lti"):
			val = genRand(26) + 96
			initStr += makeAssign(hvar, lvar, index, val)
			arrays[hvar + lvar][index] = val
		else:
			(tup, Str, ls) = makeMemCpy(hvar, lvar, index)
			memCpyInds[lvar].append(tup)
			initStr += Str
			for i in range(0, tup[1]):
				arrays[hvar + lvar][tup[0] + i] = ls[i]


	initStr += '}\n'
	Conds = ''
	if(num_lines):
		for key, arr in arrays.iteritems():
			hvar = key[:3]
			lvar = key[3]
			for index, val in enumerate(arr):
				if(val != -1):
					Conds += makeCondAssign(hvar, lvar, index, val)
		for key, indices in memCpyInds.iteritems():
			hvar = 'lts'
			lvar = key
			arr = arrays[hvar + lvar]
			for tup in indices:
				index = tup[0]
				val = ''.join(chr(x) for x in arr[tup[0] : tup[0] + tup[1]])
				Conds += makeStrcmpCond(hvar, lvar, index, val)

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

