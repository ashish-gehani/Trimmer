
import subprocess
import config
import os
import utils
from datetime import datetime

trimmer_path = os.environ.get('TRIMMER_HOME')
build_path = trimmer_path + '/build/'

link = config.env_version('llvm-link')
opt = config.env_version('opt')
dis = config.env_version("llvm-dis")
clang = config.env_version('clang++')
llc = config.env_version('llc')


debugPrint = 1
# Common routine for printing debug messages
def printDbgMsg(msg):
    if debugPrint == 1:
        print msg

def disassemble(path):
    os.system(dis + " " + path)

def run_argspec(tool):

	fname = tool.name
	curr_file = tool.curr_file
	# strip_file = tool.work_dir + '/' + fname + '_strip.bc'
	add_file = tool.work_dir + '/' + fname + '_added.bc'
        annotated_file = tool.work_dir + '/' + fname + '_annotated.bc'
	unroll_file = tool.work_dir + '/' + fname + '_unroll.bc'
	libspec_file = tool.work_dir + '/' + fname + '_ls.bc'
	annot_file = tool.work_dir + '/' + fname + '_annot.bc'
	constprop_file = tool.work_dir + '/' + fname + '_constprop.bc'
	constprop_log_file =  tool.work_dir + '/log.txt'
	remove_file = tool.work_dir + '/' + fname + '_remove.bc'
	inline_file = tool.work_dir + '/' + fname + '_inline.bc'
	intern_file = tool.work_dir + '/' + fname + '_intern.bc'
	spec_file = tool.work_dir + '/' + fname + '_spec.bc'

	# strip pass
	# if(tool.strip_flag):
	# 	Cmd = opt + ' -strip -strip-dead-prototypes ' + curr_file + ' -o ' + curr_file
	# 	print Cmd
	# 	subprocess.call(Cmd, shell = True)
	# print tool.args

	# Add arguments to main
	# if(tool.icp_flag):
	# 	# annotate pass
	# 	Cmd = opt + ' -load ' + build_path + 'Annotate.so -annotate ' + curr_file + ' -o ' \
	# 	+ curr_file
	# 	printDbgMsg(Cmd)
	# 	subprocess.call(Cmd, shell = True)	

	Cmd = opt + ' -load ' + build_path + 'SpecializeArguments.so -specialize-args \
	-args=' + tool.args + ' ' + curr_file + ' -o ' + add_file

	printDbgMsg(Cmd)
	subprocess.call(Cmd, shell = True)	 
        disassemble(add_file)
	if(tool.icp_flag): 
                if(tool.track_allocas):
                        Cmd = opt + ' -load ' + build_path + 'AnnotateNew.so -mem2reg -mergereturn -simplifycfg -loops -lcssa -loop-simplify -loop-rotate -loop-rotate -indvars  -svfg --isAnnotated=' + str(tool.annot_flag) + ' --argvName=__argv_new__\
                            ' + add_file + ' -o ' + annotated_file
                        printDbgMsg(Cmd)

                        starttime =  datetime.now()
                        subprocess.call(Cmd, shell = True)
                        endtime = datetime.now()
                        delta = endtime-starttime
                        combined = delta.seconds + delta.microseconds/1E6
                        print(combined)
                        disassemble(annotated_file)
                        #return
                else:
                        annotated_file = add_file
                #-simplifycfg
		# interconstprop pass
                # 
		Cmd = opt + ' -load ' + build_path + 'ConstantFolding.so -isAnnotated=' + str(tool.annot_flag) + ' -trackAllocas=' + str(tool.track_allocas) + ' -fileNames '  + str(tool.config_files) + ' -mem2reg -globalopt -instcombine --disable-simplify-libcalls  -loops -lcssa -loop-simplify -loop-rotate -inter-constprop -__progName=ssh' + annotated_file + ' -o ' + constprop_file
		printDbgMsg(Cmd)
#'-simplifycfg'
                rotated_file = tool.work_dir + "/rotated.bc"
                global_opt = tool.work_dir + "/global_opt.bc"
                Cmd = [opt, "-loop-rotate", annotated_file, "-o", rotated_file]
                subprocess.call(Cmd)
 #"-instcombine",
                Cmd = [opt, "-globalopt","-instcombine", '-mergereturn', '-loop-rotate', rotated_file, '-o', global_opt]
                subprocess.call(Cmd)
#'-loop-unswitch', '-loop-idiom', '-loop-accesses', '-loop-vectorize', '-loop-load-elim', '-loop-sink' '-lcssa', 
		Cmd = [opt, '-load', build_path + 'ConstantFolding.so', '-isAnnotated=' + str(tool.annot_flag), '-trackAllocas=' + str(tool.track_allocas), '-contextType=' + str(tool.context_type), '-fileNames', str(tool.config_files),'-mem2reg', '-loops', '-loop-simplify', '-scalar-evolution', '-licm',  '-loop-rotate', '-indvars', '-loop-reduce', "-__progName=ssh",'-inter-constprop', annotated_file, '-o', constprop_file]
		f = open(constprop_log_file, "wb")
		printDbgMsg(" ".join(Cmd))

                starttime =  datetime.now() 
		subprocess.call(Cmd)
                endtime = datetime.now()
                delta = endtime-starttime
                combined = delta.seconds + delta.microseconds/1E6
                print(combined)

		f.close()
                disassemble(constprop_file)
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
	# strip_file = tool.work_dir + '/' + fname + '_linked_strip.bc'
	intern_file = tool.work_dir + '/' + fname + '_linked_intern.bc'

	for mod in tool.modules:
		utils.exists(mod)
		name = mod[:-3]
		# lib_strip = tool.work_dir + '/' + name + '_strip.a.bc'
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
	Cmd = opt + ' ' + dce_file + ' -O1 -o ' + opt1_file
        printDbgMsg(Cmd)
	subprocess.call(Cmd, shell = True)

	# opt -O2
	Cmd = opt + ' ' + dce_file + ' -O2 -o ' + opt2_file
        printDbgMsg(Cmd)
	subprocess.call(Cmd, shell = True)

	# opt -O3
	Cmd = opt + ' ' + dce_file + ' -O3 -o ' + opt3_file
	printDbgMsg(Cmd)
	subprocess.call(Cmd, shell = True)

	# opt -Os
	Cmd = opt + ' ' + dce_file + ' -Os -o ' + opts_file
	printDbgMsg(Cmd)
	subprocess.call(Cmd, shell = True)
	tool.curr_file = opt3_file

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
		Cmd = 'strip ' + exe_name + ' -o ' + exe_name
		printDbgMsg(Cmd)
		subprocess.call(Cmd, shell = True)	
