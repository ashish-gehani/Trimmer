# Copyright (c) 2020 SRI International All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

import sys
import random

seed = 300
tab = '    '

outName = sys.argv[1]
numTests = int(sys.argv[2])
arrSize = int(sys.argv[3])

def genRand(range):
    global seed
    random.seed(seed)
    x = random.randint(1, range)
    seed += 1
    return x

def chooseHighVar():
	val = genRand(2)
	if(val == 1):
		return 'lti'
	else:
		return 'lts'

def chooseLowVar():
	val = genRand(2)
	if(val == 1):
		return 'x'
	else:
		return 'y'

def newBranch():
	val = genRand(5)
	if(val == 1):
		return True
	else:
		return False

def setExtern():
	val = genRand(4 * numTests)
	if(val == 1):
		return True
	else:
		return False

def makeMalloc(arrInd):
	mStr = tab + 'obj[' + str(arrInd) + '] = malloc(sizeof(struct HighType));\n'
	mStr += tab + 'obj[' + str(arrInd) + ']->lts = malloc(sizeof(struct LowTypeString));\n'
	mStr += tab + 'obj[' + str(arrInd) + ']->lti = malloc(sizeof(struct LowTypeInt));\n'
	mStr += tab + 'obj[' + str(arrInd) + ']->lts->x = malloc(1000 * sizeof(char));\n'
	mStr += tab + 'obj[' + str(arrInd) + ']->lts->y = malloc(1000 * sizeof(char));\n'
	mStr += tab + 'obj[' + str(arrInd) + ']->lti->x = malloc(1000 * sizeof(int));\n'
	mStr += tab + 'obj[' + str(arrInd) + ']->lti->y = malloc(1000 * sizeof(int));\n'

	return mStr

def makeExtern(arrInd):
	return tab + tab + 'externalFunc(obj[' + str(arrInd) + ']);\n'

def makeAssign(arrInd, hvar, lvar, index, val):
	idxStr = '[' + str(index) + ']'
	return tab + tab + 'obj[' + str(arrInd) + ']->' + hvar + '->' + lvar + idxStr + ' = ' + str(val) + ';\n'	

def makeMemCpy(arrInd, hvar, lvar, index):
	idxStr = '[' + str(index) + ']'
	size = genRand(min(50, 1000 - index))
	val = ""
	ls = []
	for i in range(size):
		alph = genRand(26) + 96
		val += chr(alph)
		ls.append(alph)
	tup = (index, size)
	Str = tab + tab + 'memcpy(&obj[' + str(arrInd) + ']->' + hvar + '->' + lvar + idxStr + ', "' + val + '", ' + str(size) + ');\n'
	return (tup, Str, ls)

def mallocStatement(obj):
	obj.mallocStr += makeMalloc(obj.index)

def createNewBranch(val):
	bstr = tab + '} else if(argc == ' + str(val) + ') {\n'
	return bstr

def generateAssigns(obj, num_lines):

	if(obj.isNull):
		return	
	for i in range(num_lines):
		if(setExtern()):
			obj.Specialize = False
			obj.assignStr += makeExtern(obj.index)
			continue
		hvar = chooseHighVar()
		lvar = chooseLowVar()
		index = genRand(999)
		if(hvar == "lti"):
			val = genRand(26) + 96
			obj.assignStr += makeAssign(obj.index, hvar, lvar, index, val)
			obj.arrays[hvar + lvar][index] = val
		else:
			(tup, Str, ls) = makeMemCpy(obj.index, hvar, lvar, index)
			obj.memCpyInds[lvar].append(tup)
			obj.assignStr += Str
			for i in range(0, tup[1]):
				obj.arrays[hvar + lvar][tup[0] + i] = ls[i]

def generateDoMallocs(structArr):
	dmStr = 'void doMallocs(struct HighType** obj) {\n'
	for st in structArr:
		dmStr += st.mallocStr
	dmStr += '}\n'
	return dmStr

def generateInitialize(structArr):
	initStr = 'void initialize(struct HighType** obj, int argc) {\n'
	initStr += tab + 'if(argc == 0) {\n'
	val = 1
	tempStr = ''
	for st in structArr:
		tempStr += st.assignStr
	tempStr = tempStr.split('\n')

	for istr in tempStr:
		if(newBranch()):
			initStr += createNewBranch(val)
			val += 1
		initStr += istr + '\n'
	initStr = initStr[:-1] + tab + '}\n'
	initStr += '}\n'
	return initStr

class StructInfo:
	def __init__(self, index):
		self.isNull = False
		self.Specialize = True
		self.arrays = {}
		self.arrays["ltsx"] = [-1] * 1000
		self.arrays["ltsy"] = [-1] * 1000
		self.arrays["ltix"] = [-1] * 1000
		self.arrays["ltiy"] = [-1] * 1000
		self.memCpyInds = {}
		self.memCpyInds["x"] = []
		self.memCpyInds["y"] = []
		self.assignStr = ""	
		self.mallocStr = ""
		self.index = index	

libStr = '''
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
'''

structTypeStr = ''' 
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
'''
externStr = '''
extern void externalFunc(struct HighType * ht);

'''

mainStr = '''
int main(int argc, char** argv) {
	struct HighType** ht = malloc(%s * sizeof(struct HighType*));
	doMallocs(ht);
	initialize(ht, argc);
}
''' % (str(arrSize))

structArr = [StructInfo(i) for i in range(arrSize)]
[mallocStatement(x) for x in structArr]
mallocStr = generateDoMallocs(structArr)
[generateAssigns(x, numTests) for x in structArr]
initStr = generateInitialize(structArr)

toWrite = libStr + structTypeStr + externStr + mallocStr + initStr + mainStr
fd = open(outName,'w')
fd.write(toWrite)
