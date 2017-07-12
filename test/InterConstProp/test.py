import subprocess

lo = 2
hi = 4

for i in xrange(lo, hi + 1):
	print 'running test ' + str(i)
	Cmd = './script.sh inter' + str(i) + ' out' + str(i) + '.bc'
	print Cmd
	subprocess.call(Cmd, shell = True)	