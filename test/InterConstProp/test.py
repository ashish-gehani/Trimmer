import subprocess
import sys, os

work_dir = str(sys.argv[1])
lo = int(sys.argv[2])
hi = int(sys.argv[3])

for i in xrange(lo, hi + 1):
	if not os.path.isfile('inter' + str(i) + '.c'):
		continue	
	print 'running test ' + str(i)
	Cmd = './script.sh inter' + str(i) + ' out' + str(i) + ' ' + work_dir
	subprocess.call(Cmd, shell = True)	
