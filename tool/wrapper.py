# Copyright (c) 2020 SRI International All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

"""
A neat little wrapper script which invokes the variable annotaton analysis on a given program
by varying call graph depth between 0 and 5 and percentage loads between 10 and 70.

Possible to run both concurrently, but possible memory constraints. Error handling is done in both
slider and memory, so none needed here. 

python3 $TRIMMER_HOME/tool/wrapper.py gzip


"""
import subprocess
import os
import sys


progName = sys.argv[1]

def run_in_dir(cmd, directory):
    print((directory+"$ " +  cmd))
    subprocess.call(cmd, shell=True, cwd = directory)


cmd = "python3 $TRIMMER_HOME/tool/slider.py "+progName+".manifest "+" depth "+"0 5" 
run_in_dir(cmd,"./")

cmd = "python3 $TRIMMER_HOME/tool/memory.py "+progName+ " depth 0 5"
run_in_dir(cmd,progName+"_"+"DEPTH_0_5")

cmd = "python3 $TRIMMER_HOME/tool/slider.py "+progName+".manifest "+" percent "+"10 70"     
run_in_dir(cmd,"./")

cmd = "python3 $TRIMMER_HOME/tool/memory.py "+progName+ " percent 10 70"
run_in_dir(cmd,progName+"_"+"PERCENT_10_70")
