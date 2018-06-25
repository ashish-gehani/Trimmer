import subprocess
import sys, os

lo = int(sys.argv[1])
hi = int(sys.argv[2])

for i in xrange(lo, hi + 1):
	if not os.path.isfile('inter' + str(i) + '.c'):
		continue	
	print 'running test ' + str(i)
	Cmd = './script.sh inter' + str(i) + ' out' + str(i)
	subprocess.call(Cmd, shell = True)	