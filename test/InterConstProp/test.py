import subprocess

lo = 2
hi = 6

for i in xrange(lo, hi + 1):
	print 'running test ' + str(i)
	Cmd = './script.sh inter' + str(i) + ' out' + str(i) + '.bc'
	subprocess.call(Cmd, shell = True)	