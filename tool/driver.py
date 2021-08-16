# Copyright (c) 2020 SRI International All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

"""
This file contains the driver for Trimmer. The main Trimmer class in trimmer.py calls the functions in this file to run Trimmer. 
This file contains 4 main functions: run_argspec, which runs the trimmer passes; link_libs, which links to modules mentioned in manifest file (if any);
run_opts, which runs the LLVM optimization(-O0, -O1, -O2,-O3,etc.) on the final bitcode file and lastly, create_exe, which creates final binary executable
from the final bitcode file using llc and clang++.
It contains 3 minor functions such as printDbgMsg to print messages on screen, disassemble to disassemble intermediate bitcode files using llvm-dis and kill
to kill the process if it exceeds 6 hours.




"""


import subprocess
import config
import os
from os import sys
import utils
from datetime import datetime
from threading import Timer

trimmer_path = os.environ.get('TRIMMER_HOME')
build_path = trimmer_path + '/build/'

link = config.env_version('llvm-link')
opt = config.env_version('opt')
dis = config.env_version("llvm-dis")
clang = config.env_version('clang++')
llc = config.env_version('llc')
exit = 0


debugPrint = 1
# Common routine for printing debug messages
def printDbgMsg(msg):
    if debugPrint == 1:
        print msg

def disassemble(path):
    os.system(dis + " " + path)

def kill (process,msg):
    process.kill()
    print(msg)
    global exit
    exit = 1

def run_argspec(tool):

	fname = tool.name
	curr_file = tool.curr_file
	add_file = tool.work_dir + '/' + fname + '_added.bc'
        annotated_file = tool.work_dir + '/' + fname + '_annotated.bc'
	libspec_file = tool.work_dir + '/' + fname + '_ls.bc'
	constprop_file = tool.work_dir + '/' + fname + '_constprop.bc'
	log_file =  tool.work_dir + '/log.txt'
	remove_file = tool.work_dir + '/' + fname + '_remove.bc'
	inline_file = tool.work_dir + '/' + fname + '_inline.bc'
	intern_file = tool.work_dir + '/' + fname + '_intern.bc'
	spec_file = tool.work_dir + '/' + fname + '_spec.bc'


        depth_limit_str = '-isLimitedDepth=false'

        trakced_percent_str = '-isTrackedLimited=false'

        use_glob_str = '-useGlob=0'

        disable_exit_str = '-disableExit=0'

        use_reg_offset_str = '-useRegOffset=0'

        exceed_limit_str = '-exceedLimit=0'

	depth_limit_value = "-depthLimit=100"
	tracked_percent_value = "-trackedPercent=100"


        if tool.depth_flag:
            depth_limit_str = '-isLimitedDepth=1'
            depth_limit_value = "-depthLimit="+tool.anot_depth

        if tool.tracked_flag:
            tracked_percent_str = '-isTrackedLimited=1'
	    tracked_percent_value = "-trackedPercent="+tool.tracked_percent

        if tool.use_glob:
            use_glob_str ='-useGlob=1'

        if tool.disable_exit:
            disable_exit_str = '-disableExit=1'

        if tool.use_reg_offset:
            use_reg_offset_str = '-useRegOffset=1'

        if int(tool.exceed_limit) != 0:
            exceed_limit_str ='-exceedLimit='+tool.exceed_limit


        if(tool.track_allocas):
                        Cmd = [opt, '-load', build_path + 'AnnotateNew.so', depth_limit_str, depth_limit_value, tracked_percent_str, tracked_percent_value,'-mem2reg', '-loops', '-lcssa', '-loop-simplify', '-loop-rotate', '-indvars', '-svfg', curr_file, '-o', annotated_file]
                                             
                                         
                        printDbgMsg(" ".join(Cmd))
  		        f = open(log_file, "wb")
                        starttime =  datetime.now()
                        subprocess.call(Cmd,stderr=f)
                        endtime = datetime.now()
                        f.close()
                        delta = endtime-starttime
                        combined = delta.seconds + delta.microseconds/1E6
                        print("Annotation Pass takes " + str(combined) + " seconds")
                        disassemble(annotated_file)
                        
        else:
                        annotated_file = curr_file
                        
        Cmd = [opt,'-load', build_path + 'SpecializeArguments.so', '-args=' + tool.args,'-specialize-args', annotated_file,'-o',add_file]
        printDbgMsg(' '.join(Cmd))
        f = open(log_file, "ab")
        subprocess.call(Cmd, stderr=f)
        f.close()   
        disassemble(add_file)
                                                    
        Cmd = opt + ' -mem2reg -mergereturn -simplifycfg -loops -lcssa -loop-simplify -loop-rotate -indvars ' + add_file + ' -o ' + add_file
        printDbgMsg(Cmd)
        subprocess.call(Cmd, shell = True)
        disassemble(add_file)
                

        if tool.icp_flag:
		  Cmd = [opt, '-load', build_path + 'ConstantFolding.so', '-isAnnotated=' + str(tool.annot_flag), use_glob_str ,disable_exit_str, use_reg_offset_str,exceed_limit_str,'-trackAllocas=' + str(tool.track_allocas),'-contextType=' + str(tool.context_type), '-fileSpecialize=' + str(tool.file_specialize), '-stringSpecialize=' + str(tool.string_specialize),'-loopUnroll=' + str(tool.loop_unroll),'-fileNames', str(tool.config_files),'-mem2reg','-mergereturn', '-simplifycfg' ,'-loops','-lcssa','-loop-simplify','-scalar-evolution' ,'-licm','-loop-rotate','-indvars' ,'-loop-reduce',"-__progName=ssh",'-inter-constprop',add_file, '-o', constprop_file]

		  f = open(log_file, "ab")
		  printDbgMsg(" ".join(Cmd))

                  ping = subprocess.Popen(Cmd,stderr=f)
                  msg = "The program has timeout after 6 hours"

                  my_timer = Timer(21600,kill, [ping,msg])

                  starttime =  datetime.now()

                  try:
                    my_timer.start()
                    stdout, stderr = ping.communicate()
                  finally:
                    my_timer.cancel()

                  endtime = datetime.now()
                  delta = endtime-starttime
                  combined = delta.seconds + delta.microseconds/1E6
                  print("Constant Folding Pass takes " + str(combined) + " seconds")

                  f.close()
                  if exit == 1:
                    return 1
                  disassemble(constprop_file)
        else:
		  constprop_file = add_file
		# remove pass
	Cmd = opt + ' -load ' + build_path + 'Remove.so -remove ' + constprop_file\
		+ ' -o ' + libspec_file
	printDbgMsg(Cmd)
	subprocess.call(Cmd, shell = True)
        disassemble(libspec_file)
	# inline pass
	Cmd = opt + ' -always-inline ' + libspec_file + ' -o ' + inline_file
        printDbgMsg(Cmd)
	subprocess.call(Cmd, shell = True)

	# Internalize pass
	Cmd = opt + ' -load ' + build_path + 'Internalize.so -intern ' + inline_file\
	+ ' -o ' + intern_file
        printDbgMsg(Cmd)
	subprocess.call(Cmd, shell = True)

	# opt -O1
	Cmd = opt + ' ' + intern_file + ' -O1 -o ' + spec_file
        printDbgMsg(Cmd)
	subprocess.call(Cmd, shell = True)
	tool.curr_file = spec_file

def link_libs(tool):

	fname = tool.name
	curr_file = tool.curr_file
	intern_file = tool.work_dir + '/' + fname + '_linked_intern.bc'

	for mod in tool.modules:
		utils.exists(mod)
		name = mod[:-3]
		lib_lnkd_file = tool.work_dir + '/' + fname + '_' + name + '_linked.bc'

		# strip dead prototypes
		if(tool.strip_flag):
			Cmd = opt + ' -strip -strip-dead-prototypes ' + mod + ' -o ' + mod
			printDbgMsg(Cmd)
			subprocess.call(Cmd, shell = True)

		# linked file
		Cmd = link + ' ' +  curr_file + ' ' + mod + ' -o ' + lib_lnkd_file
		printDbgMsg(Cmd)
		subprocess.call(Cmd, shell = True)
		curr_file = lib_lnkd_file

	# strip pass
	if(tool.strip_flag):
		Cmd = opt + ' -strip -strip-dead-prototypes ' + curr_file + ' -o ' + curr_file
                printDbgMsg(Cmd)
		subprocess.call(Cmd, shell = True)

	# Internalize pass
	Cmd = opt + ' -load ' + build_path + 'Internalize.so -intern ' + curr_file\
	+ ' -o ' + intern_file
        printDbgMsg(Cmd)
	subprocess.call(Cmd, shell = True)
	tool.curr_file = intern_file

def run_opts(tool):

	fname = tool.name
	curr_file = tool.curr_file
	inline2_file = tool.work_dir + '/' + fname + '_inline2.bc'
	dce_file = tool.work_dir + '/' + fname + '_dce.bc'
	opt0_file = tool.work_dir + '/' + fname + '_opt0.bc'
	opt1_file = tool.work_dir + '/' + fname + '_opt1.bc'
	opt2_file = tool.work_dir + '/' + fname + '_opt2.bc'
	opt3_file = tool.work_dir + '/' + fname + '_opt3.bc'
	opts_file = tool.work_dir + '/' + fname + '_opts.bc'

	#inline for unspecialized
	Cmd = opt + ' -always-inline ' + curr_file + ' -o ' + inline2_file
        printDbgMsg(Cmd)
	subprocess.call(Cmd, shell = True)

	# dce
	Cmd = opt + ' ' + inline2_file + ' -dce -globaldce -o ' + dce_file
        printDbgMsg(Cmd)
	subprocess.call(Cmd, shell = True)

    # opt -O1
	if(tool.opt_level=='0'):
		Cmd = opt + ' ' + dce_file + ' -O0 -o ' + opt0_file
        	printDbgMsg(Cmd)
		subprocess.call(Cmd, shell = True)
		tool.curr_file = opt0_file

	# opt -O1
	elif(tool.opt_level=='1'):
		Cmd = opt + ' ' + dce_file + ' -O1 -o ' + opt1_file
        	printDbgMsg(Cmd)
		subprocess.call(Cmd, shell = True)
		tool.curr_file = opt1_file

	# opt -O2
	elif(tool.opt_level=='2'):
		Cmd = opt + ' ' + dce_file + ' -O2 -o ' + opt2_file
        	printDbgMsg(Cmd)
		subprocess.call(Cmd, shell = True)
		tool.curr_file = opt2_file

	# opt -O3
	elif(tool.opt_level=='3'):
		Cmd = opt + ' ' + dce_file + ' -O3 -o ' + opt3_file
		printDbgMsg(Cmd)
		subprocess.call(Cmd, shell = True)
		tool.curr_file = opt3_file
	# opt -Os
	elif(tool.opt_level=='s'):
		Cmd = opt + ' ' + dce_file + ' -Os -o ' + opts_file
		printDbgMsg(Cmd)
		subprocess.call(Cmd, shell = True)
		tool.curr_file = opts_file
        elif(tool.opt_level=='auto'):
		Cmd = 'python optimizeTrimmerResult.py ' + tool.work_dir + ' ' + tool.manifestFile + ' --test-limit 20000'
		printDbgMsg(Cmd)
		subprocess.call(Cmd, shell = True)
		tool.curr_file = tool.work_dir + '/final.bc'

def create_exe(tool):

	fname = tool.name
	curr_file = tool.curr_file
	exe_name = tool.work_dir + '/' + tool.exe_name

	# create object file
	Cmd = llc + ' -filetype=obj ' + curr_file + ' -o ' + tool.work_dir + '/' + fname\
	+ '.o'
	printDbgMsg(Cmd)
	subprocess.call(Cmd, shell = True)

	# create exe
	Cmd = clang + ' ' + tool.ldflags + ' ' + tool.work_dir + '/' + fname + '.o ' + \
	tool.native_libs +  ' -O3 -o ' + exe_name
	printDbgMsg(Cmd)
	subprocess.call(Cmd, shell = True)

	# strip
	if(tool.strip_flag):
		Cmd = 'strip ' + exe_name + ' -o ' + exe_name+"_stripped"
		printDbgMsg(Cmd)
		subprocess.call(Cmd, shell = True)



