import os
import json

def format_args(fname, args):
	return ("'" + " " + "'").join([fname] + args)

def exists(fname):
	if not os.path.exists(fname):
                print fname
		print 'file ' + fname + ' does not exist'
		quit()
	elif  not os.path.isfile(fname):
		print 'file ' + fname + ' path is not a file'
		quit()

def usage():
	print 'two arguments are required'
	print '1. full path to the manifest file'
	print '2. path to the working directory'
	quit()

def parse_args(args):
	if(len(args) < 2):
		usage()
	manifest_file = args[0]
	exists(manifest_file)

	with open(manifest_file) as mfile:    
	    man_data = json.load(mfile)
	work_dir = args[1]

	if not os.path.exists(work_dir):
		os.makedirs(work_dir)
	
        dir_path = os.path.dirname(os.path.realpath(manifest_file))
        man_data["main_path"] = os.path.join(dir_path, man_data["main"])

	opt_flag = True
	spec_flag = True
	strip_flag = True
	icp_flag = True
        annot_flag = 1
        track_allocas = 1
	for i in range(2, len(args)):
		if(args[i] == 'no-optimization'):
			opt_flag = False
		elif(args[i] == 'no-specialization'):
			spec_flag = False
		elif(args[i] == 'no-strip'):
			strip_flag = False
		elif(args[i] == 'no-inter-constprop'):
			icp_flag = False
                elif(args[i] == 'no-annot'):
                        annot_flag = 0 
                elif(args[i] == 'no-track-allocas'):
                        track_allocas = 0
		else: usage()
	return (man_data, work_dir, opt_flag, spec_flag, strip_flag, icp_flag, annot_flag, track_allocas)
