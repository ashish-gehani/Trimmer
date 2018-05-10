
import sys
import os
import subprocess


def run_command(cmd):
    subprocess.call(cmd, shell=True)

def prune_func(mod_name, target_func):
    cmd = "opt -load ./build/RemFuncBody.so -rem-func-body -func_name " + target_func + " " \
           + mod_name + " -o debloated.bc"
    print cmd
    run_command(cmd)

def internalize(mod_name):
    cmd = "opt -load ./build/Internalize.so -intern  debloated.bc -o debloated.bc"
    print cmd
    run_command(cmd)

def dce(mod_name):
    cmd = "opt -dce -globaldce  debloated.bc -o debloated.bc"
    print cmd
    run_command(cmd)


if __name__ == "__main__":

    if len(sys.argv) < 3:
        print "usage: python test_scripts/pruneFuncs.py [input.bc] [func_list]"
        sys.exit(1)

    mod_name = sys.argv[1]
    func_file = open(sys.argv[1], "r")
    for func_name in func_file: 
        func_name = func_name.strip()
        prune_func(mod_name, func_name)
  
    internalize(mod_name)
    dce(mod_name)
    size = os.stat("debloated.bc").st_size
    print size
        
