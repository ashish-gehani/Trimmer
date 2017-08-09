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

def setNull():
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
	# mStr = tab + 'obj[' + str(arrInd) + '] = malloc(sizeof(struct HighType));\n'
	# mStr += tab + 'obj[' + str(arrInd) + ']->lts = malloc(sizeof(struct LowTypeString));\n'
	# mStr += tab + 'obj[' + str(arrInd) + ']->lti = malloc(sizeof(struct LowTypeInt));\n'
	# mStr += tab + 'obj[' + str(arrInd) + ']->lts->x = malloc(1000 * sizeof(char));\n'
	# mStr += tab + 'obj[' + str(arrInd) + ']->lts->y = malloc(1000 * sizeof(char));\n'
	# mStr += tab + 'obj[' + str(arrInd) + ']->lti->x = malloc(1000 * sizeof(int));\n'
	# mStr += tab + 'obj[' + str(arrInd) + ']->lti->y = malloc(1000 * sizeof(int));\n'
	mStr = tab + 'obj[' + str(arrInd) + '] = createHighType();\n'
	return mStr

def makeExtern(arrInd):
	return tab + 'externalFunc(obj[' + str(arrInd) + ']);\n'

def makeAssign(arrInd, hvar, lvar, index, val):
	idxStr = '[' + str(index) + ']'
	return tab + 'obj[' + str(arrInd) + ']->' + hvar + '->' + lvar + idxStr + ' = ' + str(val) + ';\n'	

def makeMemCpy(arrInd, hvar, lvar, index):
	idxStr = '[' + str(index) + ']'
	size = genRand(min(50, 1000 - index))
	val = ""
	ls = []
	for i in xrange(size):
		alph = genRand(26) + 96
		val += chr(alph)
		ls.append(alph)
	tup = (index, size)
	Str = tab + 'memcpy(&obj[' + str(arrInd) + ']->' + hvar + '->' + lvar + idxStr + ', "' + val + '", ' + str(size) + ');\n'
	return (tup, Str, ls)

def makeCondAssign(arrInd, hvar, lvar, index, val):
	idxStr = '[' + str(index) + ']'
	return tab + 'obj[' + str(arrInd) + ']->' + hvar + '->' + lvar + idxStr + ' == ' + str(val)

def makeStrcmpCond(arrInd, hvar, lvar, index, val):
	idxStr = '[' + str(index) + ']'
	return tab + '!strcmp(&obj[' + str(arrInd) + ']->' + hvar + '->' + lvar + idxStr + ', "' + val + '")'

def makeNullCond(arrInd, sign):
	return tab + 'obj[' + str(arrInd) + '] ' + sign + ' NULL'

def mergeMemCpyInds(memCpyInds):
	for key, indices in memCpyInds.iteritems():
		for tup1 in indices:
			for tup2 in indices:
				if(tup1 == tup2):
					continue
				if(tup1[0] <= tup2[0] and tup1[0] + tup1[1] >= tup2[0]):
					print tup1, tup2
					memCpyInds[key].remove(tup1)
					memCpyInds[key].remove(tup2)
					newInd = max(tup1[0] + tup1[1], tup2[0] + tup2[1])
					tup3 = (tup1[0], newInd - tup1[0])
					print "replacing " + str(tup1) + " and " + str(tup2) + " with " + str(tup3) 
					memCpyInds[key].append(tup3)	
					break
	return memCpyInds

def mallocStatement(obj):
	if(setNull()):
		obj.isNull = True
	else: 
		obj.mallocStr += makeMalloc(obj.index)

def generateAssigns(obj, num_lines):

	if(obj.isNull):
		return	
	for i in xrange(num_lines):
		if(setExtern()):
			obj.Specialize = False
			obj.assignStr += makeExtern(obj.index)
			continue
		hvar = chooseHighVar()
		lvar = chooseLowVar()
		index = genRand(1000)
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

def generateConds(obj):
	if(obj.isNull):
		obj.Conds.append(makeNullCond(obj.index, '=='))
		return
	# obj.Conds.append(makeNullCond(obj.index, '!='))
	for key, arr in obj.arrays.iteritems():
		hvar = key[:3]
		lvar = key[3]
		for index, val in enumerate(arr):
			if(val != -1):
				if(hvar == "lts"):
					val = "'" + chr(val) + "'"
				obj.Conds.append(makeCondAssign(obj.index, hvar, lvar, index, val))

	obj.memCpyInds = mergeMemCpyInds(obj.memCpyInds)
	for key, indices in obj.memCpyInds.iteritems():
		hvar = 'lts'
		lvar = key
		arr = obj.arrays[hvar + lvar]
		for tup in indices:
			index = tup[0]
			val = ''.join(chr(x) for x in arr[tup[0] : tup[0] + tup[1]])
			obj.Conds.append(makeStrcmpCond(obj.index, hvar, lvar, index, val))

def generateCondFuncs(structArr):
	bpConds = ""
	bnpConds = ""
	for obj in structArr:
		startInd = 0
		if(obj.isNull):
			bpConds += obj.Conds[0] + ' &&\n'
			startInd = 1		
		if(len(obj.Conds) > 1):
			if(obj.Specialize):
				bpConds += ' &&\n'.join(obj.Conds[startInd:]) + ' &&\n'

			else: 
				bnpConds += ' ||\n'.join(obj.Conds[startInd:]) + ' ||\n'
		
	bpStr = 'void branchPruned(struct HighType** obj) {\n'
	bnpStr = 'void branchNotPruned(struct HighType** obj) {\n'

	if(bpConds != ""):
		bpConds = tab + 'if(' + bpConds[4:-4] + ')\n'
		bpStr += bpConds
		bpStr += tab + tab + 'printf("*** pruned branch taken");\n'

	if(bnpConds != ""):
		bnpConds = tab + 'if(' + bnpConds[4:-4] + ')\n'
		bnpStr += bnpConds
		bnpStr += tab + tab + 'printf("*** unpruned branch taken");\n'

	bpStr += '}\n'
	bnpStr += '}\n'
	
	return bpStr + '\n' + bnpStr

def generateDoMallocs(structArr):
	dmStr = 'void doMallocs(struct HighType** obj) {\n'
	for st in structArr:
		dmStr += st.mallocStr
	dmStr += '}\n'
	return dmStr

def generateInitialize(structArr):
	initStr = 'void initialize(struct HighType** obj) {\n'
	for st in structArr:
		initStr += st.assignStr
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
		self.Conds = []
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
'''
externStr = '''
extern void externalFunc(struct HighType * ht);

'''

mainStr = '''
int main() {
	struct HighType** ht = malloc(%s * sizeof(struct HighType*));
	doMallocs(ht);
	initialize(ht);
	branchPruned(ht);
	branchNotPruned(ht);
}
''' % (str(arrSize))

structArr = [StructInfo(i) for i in range(arrSize)]
[mallocStatement(x) for x in structArr]
mallocStr = generateDoMallocs(structArr)
[generateAssigns(x, numTests) for x in structArr]
initStr = generateInitialize(structArr)
[generateConds(x) for x in structArr]
condFuncs = generateCondFuncs(structArr)

toWrite = libStr + structTypeStr + externStr + mallocStr + initStr + condFuncs + mainStr
fd = open(outName,'w')
fd.write(toWrite)
