import subprocess
import sys, os

lo = int(sys.argv[1])
hi = int(sys.argv[2])
workdir = "workdir"
if len(sys.argv) > 3:
	workdir = str(sys.argv[3])
if not os.path.exists(workdir):
    os.makedirs(workdir)
for i in xrange(lo, hi + 1):
	if not os.path.isfile('inter' + str(i) + '.c'):
		continue	
	print 'running test ' + str(i)
	Cmd = './script.sh inter' + str(i) + ' out' + str(i) + ' ' + workdir
	subprocess.call(Cmd, shell = True)	
