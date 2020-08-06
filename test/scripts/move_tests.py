import subprocess
import sys
import os

lo = int(sys.argv[1])
hi = int(sys.argv[2])
diff = int(sys.argv[3])

for i in xrange(lo, hi + 1):
	src = "inter" + str(i) + ".c"
	dst = "inter" + str(i + diff) + ".c"
	if not os.path.isfile(src):
		print src, " src file does not exist"
		continue	
	if os.path.isfile(dst) :
		print dst, " dst file already exists"
		continue
	os.rename(src, dst)