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
import json
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

def disassemble(path):
    os.system(dis + " " + path)

def kill (process,msg):
    process.kill()
    print(msg)
    global exit
    exit = 1

def create_baseline(tool):
	curr_file = tool.curr_file
	Cmd = opt + ' -O3 ' + curr_file + ' -o ' + tool.work_dir + '/baseline_O3.bc' 
	print("\nCreating Baseline -O3 ...")
	subprocess.call(Cmd, shell = True)
	Cmd = llc + ' -filetype=obj ' + tool.work_dir + '/baseline_O3.bc -o ' + tool.work_dir + '/baseline_O3.o'
	subprocess.call(Cmd, shell = True)
	Cmd = clang + ' ' + tool.ldflags + ' ' + tool.work_dir + '/baseline_O3.o ' + tool.native_libs +  \
 ' -O3 -o ' + tool.work_dir + '/baseline_O3'
	subprocess.call(Cmd, shell = True)

	# strip
	if(tool.strip_flag):
		Cmd = 'strip ' + tool.work_dir +  '/baseline_O3 -o ' + tool.work_dir + '/baseline_O3_stripped'
		subprocess.call(Cmd, shell = True)
	Cmd = 'stat '+ tool.work_dir + '/baseline_O3_stripped | grep Size'
	process = subprocess.Popen(Cmd, stdout=subprocess.PIPE, shell=True)
	output = process.communicate()[0].decode("utf-8")
	index = output.find('	');
	tool.baseline_size_O3 = output[8:index]

	Cmd = opt + ' -Os ' + curr_file + ' -o ' + tool.work_dir + '/baseline_Os.bc' 
	print("\nCreating Baseline -Os ...")
	subprocess.call(Cmd, shell = True)
	Cmd = llc + ' -filetype=obj ' + tool.work_dir + '/baseline_Os.bc -o ' + tool.work_dir + '/baseline_Os.o'
	subprocess.call(Cmd, shell = True)
	Cmd = clang + ' ' + tool.ldflags + ' ' + tool.work_dir + '/baseline_Os.o ' + tool.native_libs +  \
 ' -O3 -o ' + tool.work_dir + '/baseline_Os'
	subprocess.call(Cmd, shell = True)

	# strip
	if(tool.strip_flag):
		Cmd = 'strip ' + tool.work_dir +  '/baseline_Os -o ' + tool.work_dir + '/baseline_Os_stripped'
		subprocess.call(Cmd, shell = True)
	Cmd = 'stat '+ tool.work_dir + '/baseline_Os_stripped | grep Size'
	process = subprocess.Popen(Cmd, stdout=subprocess.PIPE, shell=True)
	output = process.communicate()[0].decode("utf-8")
	index = output.find('	');
	tool.baseline_size_Os = output[8:index]






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


	use_glob_str = '-useGlob=0'

	disable_exit_str = '-disableExit=0'


	exceed_limit_str = '-exceedLimit=0'

	depth_limit_value = "-depthLimit=100"
	tracked_percent_value = "-trackedPercent=100"
	tracked_percent_str = '-isTrackedLimited=0'
	depth_limit_str = '-isLimitedDepth=0'

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

	if tool.exceed_limit != 'No':
		exceed_limit_str ='-exceedLimit='+tool.exceed_limit


	if(tool.track_allocas):
		Cmd = [opt, '-load', build_path + 'AnnotateNew.so', depth_limit_str, depth_limit_value, tracked_percent_str, tracked_percent_value,'-mem2reg', '-loops', '-lcssa', '-loop-simplify', '-loop-rotate', '-indvars', '-svfg', curr_file, '-o', annotated_file]
                                             
                                        
		print("\nRunning Annotation Pass...")
		f = open(log_file, "wb")
		starttime =  datetime.now()
		subprocess.call(Cmd,stderr=f)
		endtime = datetime.now()
		f.close()
		delta = endtime-starttime
		combined = delta.seconds + delta.microseconds/1E6
		with open('anotStats.JSON') as json_file:
			data = json.load(json_file)
			print("\nNumber of Variables Tainted: " + str(data["trackedAllocas"]))

		print(("Annotation Pass takes " + str(combined) + " seconds"))
		disassemble(annotated_file)
                        
	else:

		Cmd = opt + ' -mem2reg -loops -lcssa -loop-simplify -loop-rotate -indvars ' + curr_file + ' -o ' + curr_file
		subprocess.call(Cmd, shell = True)
		annotated_file = curr_file

                        
	Cmd = [opt,'-load', build_path + 'SpecializeArguments.so', '-args=' + tool.args,'-specialize-args', annotated_file,'-o',add_file]
	print("\nRunning Entry-point Specialization Pass...")
	f = open(log_file, "ab")
	starttime =  datetime.now()
	subprocess.call(Cmd,stderr=f)
	endtime = datetime.now()
	f.close()
	delta = endtime-starttime
	combined = delta.seconds + delta.microseconds/1E6
	print(("Entry-point Specialization Pass takes " + str(combined) + " seconds"))
 
	disassemble(add_file)
                                                    
	Cmd = opt + ' -mem2reg -mergereturn -simplifycfg -loops -lcssa -loop-simplify -loop-rotate -indvars ' + add_file + ' -o ' + add_file
	subprocess.call(Cmd, shell = True)
	disassemble(add_file)
                

	if tool.icp_flag:
		Cmd = [opt, '-load', build_path + 'ConstantFolding.so', '-isAnnotated=' + str(tool.annot_flag), use_glob_str ,disable_exit_str, exceed_limit_str,'-trackAllocas=' + str(tool.track_allocas),'-contextType=' + str(tool.context_type), '-fileSpecialize=' + str(tool.file_specialize), '-stringSpecialize=' + str(tool.string_specialize),'-loopUnroll=' + str(tool.loop_unroll),'-fileNames', str(tool.config_files),'-mem2reg','-mergereturn', '-simplifycfg' ,'-loops','-lcssa','-loop-simplify','-scalar-evolution' ,'-licm','-loop-rotate','-indvars' ,'-loop-reduce',"-__progName=ssh",'-inter-constprop',add_file, '-o', constprop_file]

		f = open(log_file, "ab")
		print("\nRunning Constant Folding Pass...")

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
		f.close()
		if exit == 1:
			return 1


		with open('constStats.JSON') as json_file:
			data = json.load(json_file)
			print("Number of Function Calls Encountered: " + str(data["FunctionCallsAnalyzed"]))
			print("Number of Functions Cloned: " + str(data["FunctionsCloned"]))
			print("Number of Library Calls Encountered: " + str(data["TotalLibCalls"]))
			print("Number of Library Calls Simplified: " + str(data["LibCallsSimplified"]))
			print("Number of Loads Encountered: " + str(data["TotalLoadsEncountered"]))
			print("Number of Loads Folded: " + str(data["LoadsFolded"]))
			print("Number of Loops Encountered: " + str(data["TotalLoopsEncountered"]))
			print("Number of Loops Unrolled: " + str(data["LoopsUnrolled"]))
			print("Number of Loops Rerolled Back: " + str(data["LoopsRerolledBack"]))
			print("Number of Instructions Folded: " + str(data["InstructionsFolded"]))


		print(("Constant Folding Pass takes " + str(combined) + " seconds"))

		disassemble(constprop_file)
	else:
		constprop_file = add_file
		# remove pass

	Cmd = opt + ' -load ' + build_path + 'Remove.so -remove ' + constprop_file\
		+ ' -o ' + libspec_file

	subprocess.call(Cmd, shell = True)
	disassemble(libspec_file)
	# inline pass
	Cmd = opt + ' -always-inline ' + libspec_file + ' -o ' + inline_file
	subprocess.call(Cmd, shell = True)

	# Internalize pass
	print("\nInternalizing External Globals ...")
	Cmd = opt + ' -load ' + build_path + 'Internalize.so -intern ' + inline_file\
	+ ' -o ' + intern_file
	subprocess.call(Cmd, shell = True)

	# opt -O1
	print("\nRemoving Dead Code ...")
	Cmd = opt + ' ' + intern_file + ' -O1 -o ' + spec_file
	subprocess.call(Cmd, shell = True)
	tool.curr_file = spec_file

def link_libs(tool):

	fname = tool.name
	curr_file = tool.curr_file
	intern_file = tool.work_dir + '/' + fname + '_linked_intern.bc'

	print("\nLinking Modules ...")

	for mod in tool.modules:
		utils.exists(mod)
		name = mod[:-3]
		lib_lnkd_file = tool.work_dir + '/' + fname + '_' + name + '_linked.bc'

		# strip dead prototypes
		if(tool.strip_flag):
			Cmd = opt + ' -strip -strip-dead-prototypes ' + mod + ' -o ' + mod
			subprocess.call(Cmd, shell = True)

		# linked file
		Cmd = link + ' ' +  curr_file + ' ' + mod + ' -o ' + lib_lnkd_file
		subprocess.call(Cmd, shell = True)
		curr_file = lib_lnkd_file

	# strip pass
	if(tool.strip_flag):
		Cmd = opt + ' -strip -strip-dead-prototypes ' + curr_file + ' -o ' + curr_file
		subprocess.call(Cmd, shell = True)

	# Internalize pass
	Cmd = opt + ' -load ' + build_path + 'Internalize.so -intern ' + curr_file\
	+ ' -o ' + intern_file
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

	print("\nRunning Optimizations ...")

	#inline for unspecialized
	Cmd = opt + ' -always-inline ' + curr_file + ' -o ' + inline2_file
	subprocess.call(Cmd, shell = True)

	# dce
	Cmd = opt + ' ' + inline2_file + ' -dce -globaldce -o ' + dce_file
	subprocess.call(Cmd, shell = True)

	# opt -O0
	if(tool.opt_level=='0'):
		Cmd = opt + ' ' + dce_file + ' -O0 -o ' + opt0_file
		subprocess.call(Cmd, shell = True)
		tool.curr_file = opt0_file

	# opt -O1
	elif(tool.opt_level=='1'):
		Cmd = opt + ' ' + dce_file + ' -O1 -o ' + opt1_file
		subprocess.call(Cmd, shell = True)
		tool.curr_file = opt1_file

	# opt -O2
	elif(tool.opt_level=='2'):
		Cmd = opt + ' ' + dce_file + ' -O2 -o ' + opt2_file
		subprocess.call(Cmd, shell = True)
		tool.curr_file = opt2_file

	# opt -O3
	elif(tool.opt_level=='3'):
		Cmd = opt + ' ' + dce_file + ' -O3 -o ' + opt3_file
		subprocess.call(Cmd, shell = True)
		tool.curr_file = opt3_file

	# opt -Os
	elif(tool.opt_level=='s'):
		Cmd = opt + ' ' + dce_file + ' -Os -o ' + opts_file
		subprocess.call(Cmd, shell = True)
		tool.curr_file = opts_file

	elif(tool.opt_level=='auto'):
		Cmd = 'python3 optimizeTrimmerResult.py ' + tool.work_dir + ' ' + tool.manifestFile + ' ' + opt + ' ' + llc + ' ' + clang +' --test-limit 20000'
		subprocess.call(Cmd, shell = True)
		tool.curr_file = tool.work_dir + '/final.bc'

def create_exe(tool):

	fname = tool.name
	curr_file = tool.curr_file
	exe_name = tool.work_dir + '/' + tool.exe_name

	print("\nCreating Final Specialized Binary ...")

	# create object file
	Cmd = llc + ' -filetype=obj ' + curr_file + ' -o ' + tool.work_dir + '/' + fname\
	+ '.o'
	subprocess.call(Cmd, shell = True)

	# create exe
	Cmd = clang + ' ' + tool.ldflags + ' ' + tool.work_dir + '/' + fname + '.o ' + \
	tool.native_libs +  ' -O3 -o ' + exe_name
	subprocess.call(Cmd, shell = True)

	# strip
	if(tool.strip_flag):
		Cmd = 'strip ' + exe_name + ' -o ' + exe_name+"_stripped"
		subprocess.call(Cmd, shell = True)

	Cmd = 'stat '+ exe_name + '_stripped | grep Size'
	process = subprocess.Popen(Cmd, stdout=subprocess.PIPE, shell=True)
	output = process.communicate()[0].decode("utf-8")
	index = output.find('	');
	tool.spec_size = output[8:index]
	reduction_O3 = (int(tool.baseline_size_O3) - int(tool.spec_size))/int(tool.baseline_size_O3)*100
	print('\nSize Reduction w.r.t O3: ' + "{:.1f}".format(reduction_O3) + "%")

	reduction_Os = (int(tool.baseline_size_Os) - int(tool.spec_size))/int(tool.baseline_size_Os)*100
	print('\nSize Reduction w.r.t Os: ' + "{:.1f}".format(reduction_Os) + "%")



