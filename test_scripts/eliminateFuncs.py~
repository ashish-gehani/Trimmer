
import sys
import os
import subprocess
from operator import itemgetter

out_file = "func_out"
max_items = 100 # this controls the number of top funcs printed 

def run_command(cmd):
    subprocess.call(cmd, shell=True)

def get_func_list(mod_name):
    cmd = "opt -load ./build/ListFunctions.so -list-functions -out_file " + out_file + " " + \
           mod_name + " -o debloated.bc"
    run_command(cmd)

def debloat_func(mod_name, target_func):
    cmd = "opt -load ./build/RemFuncBody.so -rem-func-body -func_name " + target_func + " " \
           + mod_name + " -o debloated.bc"
    print cmd
    run_command(cmd)
    cmd = "opt -load ./build/Internalize.so -intern  debloated.bc -o debloated.bc"
    print cmd
    run_command(cmd)
    cmd = "opt -dce -globaldce  debloated.bc -o debloated.bc"
    print cmd
    run_command(cmd)

if __name__ == "__main__":

    if len(sys.argv) < 3:
        print "usage: python test_scripts/evalDebloat.py [input.bc] [output_file]"
        sys.exit(1)

    func_debloat_sizes = []
    mod_name = sys.argv[1]
    get_func_list(mod_name)

    func_file = open(out_file, "r")
    for func_name in func_file: 
        func_name = func_name.strip()
        debloat_func(mod_name, func_name)
        size = os.stat("debloated.bc").st_size
        print size
        func_debloat_sizes.append((func_name, size))

    func_debloat_sizes.sort(key=itemgetter(1))

    out_file = open(sys.argv[2], "w+")
    for i in range(min(len(func_debloat_sizes), max_items) ):
        out_file.write("func = " + func_debloat_sizes[i][0] + "  size = " + str(func_debloat_sizes[i][1]) + "\n")
    out_file.close()
