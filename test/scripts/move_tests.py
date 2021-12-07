# Copyright (c) 2020 SRI International All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

import subprocess
import sys
import os

lo = int(sys.argv[1])
hi = int(sys.argv[2])
diff = int(sys.argv[3])

for i in range(lo, hi + 1):
	src = "test" + str(i) + ".c"
	dst = "test" + str(i + diff) + ".c"
	if not os.path.isfile(src):
		print(src, " src file does not exist")
		continue	
	if os.path.isfile(dst) :
		print(dst, " dst file already exists")
		continue
	os.rename(src, dst)
