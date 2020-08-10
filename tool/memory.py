# Copyright (c) 2020 SRI International All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

"""

A Memory profiler for TRIMMER. Built on top of Valgrind's Massif Tool, memory.py analysis the effects
of Heap Usage of the Constant Folding Analysis used in TRIMMER. The tool is a secondary tool to be run after
Slider since it uses the Directory structure built in that, however it's relatively easy to adjust the code 
accordingly.

As the Constant Folding pass neccessiates a bunch of pre-processing passes, memory.py runs the heap analysis for both
(Pre-Process + Constant Folding) and only Constant folding as well, creating appropriate massif output files check_full and
check_const respectively.

As Heap Profiling is memory intensive and may crash for a particular instance, error handling is done in that memory moves on
to the next iteration and logs which condition failed into a log file.

Example Usage:

python memory.py gzip percent 20 70

"""
import subprocess 
import sys
import json
import os


#python memory.py gzip percent 20 70
progName = sys.argv[1]
MODE = sys.argv[2]
LOW = sys.argv[3]
HIGH = sys.argv[4]

step = 0

if MODE.lower() == "depth":
    step = 1
else:
    step = 10

MANIFEST = progName+'.manifest'

config_files = []
annotated_file = progName+"_annotated.bc"
preconstprop_file = progName+"_preconst.bc"
constprop_file = progName+"_constprop.bc"
opt = "opt-4.0"

build_path = os.getenv("TRIMMER_HOME")+"/"+"build"+"/"


def run_in_dir(cmd, directory):
    print(directory+"$ " +  cmd)
    subprocess.call(cmd, shell=True, cwd = directory)



with open(MANIFEST,"r") as ManFile:
    man = json.load(ManFile)
    for conf in man['config_files']:
        config_files.append(conf)



test_dir = "massif_test"
for limit in range(int(LOW),int(HIGH)+2*step,step):
    try:

        # Directories
        full_dir = test_dir+"_full"
        const_dir = test_dir+"_const"
        massif_const_file = "only_const_"+str(limit)
        massif_full_file = "full_"+str(limit)


        cur_dir = "./"+"ANOT"+"_"+MODE.upper()+"_"+str(limit)
    
        if limit == int(HIGH)+step:
            cur_dir = "./ANOT_FULL"

        Cmd = ["mkdir "+full_dir+" && cp "+annotated_file+" "+full_dir]
        run_in_dir(" ".join(Cmd), cur_dir)

        Cmd = ["mkdir "+const_dir+" && cp "+annotated_file+" "+const_dir]
        run_in_dir(" ".join(Cmd), cur_dir)

        # Only Const commands
        Cmd = [opt, '-mem2reg', '-loops', '-loop-simplify', '-scalar-evolution', '-licm',  '-loop-rotate', '-indvars', '-loop-reduce', const_dir+"/"+annotated_file, '-o', const_dir+"/"+preconstprop_file]
        run_in_dir(" ".join(Cmd), cur_dir)
        Cmd = ["valgrind --tool=massif --time-unit=B","--massif-out-file="+massif_const_file,opt, '-load', build_path + 'ConstantFolding.so', '-isAnnotated=' + '1', '-trackAllocas=' + '1', '-contextType=' + '1', '-fileNames', str(",".join(config_files)), "-__progName=ssh",'-inter-constprop', const_dir+"/"+preconstprop_file, '-o', const_dir+"/"+constprop_file]
        run_in_dir(" ".join(Cmd), cur_dir)
        Cmd = "ms_print "+massif_const_file+ " >  check_const"
        run_in_dir(Cmd, cur_dir)

        # All passes inclusive

        Cmd = ["valgrind --tool=massif --time-unit=B","--massif-out-file="+massif_full_file,opt, '-load', build_path + 'ConstantFolding.so', '-isAnnotated=' + '1', '-trackAllocas=' + '1', '-contextType=' + '1', '-fileNames', str(",".join(config_files)),'-mem2reg', '-loops', '-loop-simplify', '-scalar-evolution', '-licm',  '-loop-rotate', '-indvars', '-loop-reduce', "-__progName=ssh",'-inter-constprop', full_dir+"/"+annotated_file, '-o', full_dir+"/"+constprop_file]
        run_in_dir(" ".join(Cmd), cur_dir)
        Cmd = "ms_print "+massif_full_file+ " >  check_full"
        run_in_dir(Cmd, cur_dir)
    except KeyboardInterrupt:
        print("Killing Memory Profiling")
        sys.exit()
    except:
        with open(progName+"_massif_log.txt","a+") as ErrorLog:
            ErrorLog.write("Limit {} failed...\n".format(limit))
        continue
            








