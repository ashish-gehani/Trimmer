# Copyright (c) 2020 SRI International All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.


import sys
import os
import subprocess
from operator import itemgetter

out_file = "func_out"
max_items = 100 # this controls the number of top funcs printed 

def run_command(cmd):
    subprocess.call(cmd, shell=True)

def get_func_list(mod_name):
    cmd = "opt-3.8 -load /home/muhammad/fileIO/build/ListFunctions.so -list-functions -out_file " + out_file + " " + \
           mod_name + " -o debloated.bc"
    run_command(cmd)

def debloat_func(mod_name, target_func):
    cmd = "opt-3.8 -load /home/muhammad/fileIO/build/RemFuncBody.so -rem-func-body -func_name " + target_func + " " \
           + mod_name + " -o debloated.bc"
    print cmd
    run_command(cmd)
    cmd = "opt-3.8 -load /home/muhammad/fileIO/build/Internalize.so -intern  debloated.bc -o debloated.bc"
    print cmd
    run_command(cmd)
    cmd = "opt-3.8 -dce -globaldce  debloated.bc -o debloated.bc"
    print cmd
    run_command(cmd)

if __name__ == "__main__":

    if len(sys.argv) < 3:
        print "usage: python test_scripts/evalDebloat.py [input.bc] [output_file]"
        sys.exit(1)

    func_debloat_sizes = []
    mod_name = sys.argv[1]
    get_func_list(mod_name)
    maxSize = os.stat(mod_name).st_size
    func_file = open(out_file, "r")
    num_lines = sum(1 for line in func_file)
    func_file.close()
    func_file = open(out_file, "r")    
    for num, func_name in enumerate(func_file): 
        func_name = func_name.strip()
        debloat_func(mod_name, func_name)
        print num + 1, ' / ', num_lines
        if not os.path.exists("debloated.bc"):
            continue
        size = os.stat("debloated.bc").st_size
        print size
        func_debloat_sizes.append((func_name, size))

    func_debloat_sizes.sort(key=itemgetter(1))

    out_file = open(sys.argv[2], "w+")
    out_file.write("original size = " + str(os.stat(mod_name).st_size) + "\n")
    for i in range(min(len(func_debloat_sizes), max_items) ):
        out_file.write("func = " + func_debloat_sizes[i][0] + "  size = " + str(func_debloat_sizes[i][1])\
        + " reduction = " + str(round((1 - float(func_debloat_sizes[i][1])/float(maxSize))\
        * 100, 2)) + "%\n")
    out_file.close()
