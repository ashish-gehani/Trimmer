import subprocess
import sys

lo = int(sys.argv[1])
hi = int(sys.argv[2])

for i in xrange(lo, hi + 1):
	print 'running test ' + str(i)
	Cmd = './script.sh inter' + str(i) + ' out' + str(i)
	subprocess.call(Cmd, shell = True)	