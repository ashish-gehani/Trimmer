# Copyright (c) 2020 SRI International All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

"""
This file contains utility functions such as format_args to format the arguments mentioned in the manifest file in a way that is accepted by the LLVM pass,
exists to check the existence of manifest file and report error if it does not exist, usage to print how to run trimmer in case user runs it incorrectly and 
parse_args, which parses the parameters and options provided by user when running trimmer.py and creates a Trimmer object (see trimmer.py).




"""

import os
import json

def format_args(fname, args):
	return (' ').join([fname] + args)

def exists(fname):
	if not os.path.exists(fname):
		print (fname)
		print (('file ' + fname + ' does not exist'))
		quit()
	elif  not os.path.isfile(fname):
		print (('file ' + fname + ' path is not a file'))
		quit()

def usage():
	print ('two arguments are required')
	print ('1. full path to the manifest file')
	print ('2. path to the working directory')
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
	opt_level = '3'
	spec_flag = True
	strip_flag = True
	icp_flag = True
	annot_flag = 1
	track_allocas = 1
	file_specialize = 1
	string_specialize = 1
	loop = 1
	file_flag = False
	string_flag = False
	loop_flag= False
	contextType = 1
	isLimitedDepth = False
	depthLimit = 0
	isTrackedLimited = False
	trackedPercent = 100
	useGlob = False
	exceedLimit = 'No'
	disableExit = False
	useRegOffset = False

	for i in range(2, len(args)):
		if(args[i] == 'optLevel'):
			opt_level = args[i+1]
			if(opt_level == 'none'):
				opt_flag = False
		elif(args[i] == 'no-strip'):
			strip_flag = False
		elif(args[i] == 'no-specialization'):
			spec_flag = False

		elif(args[i] == 'no-inter-constprop'):
			icp_flag = False
			loop = 0
			file_specialize = 0
			string_specialize = 0
		elif(args[i] == 'no-track-allocas'):
			track_allocas = 0
		elif(args[i] == 'file-specialize'):
			file_flag = True
			file_specialize = 1
			if string_flag == False:
				string_specialize = 0
			if loop_flag == False:
				loop=0
		elif(args[i] == 'string-specialize'):
			string_flag = True
			string_specialize = 1
			if file_flag==False:
				file_specialize = 0
			if loop_flag == False:
				loop = 0              
		elif(args[i] == 'loop-unroll'):
			loop_flag = True
			loop = 1
			if file_flag==False:
				file_specialize = 0
			if string_flag == False:
				string_specialize = 0                               
		elif(args[i] == 'contextType'):
			contextType = int(args[i+1])
			if(contextType != 1):
				track_allocas = 0
		elif(args[i] == 'depthLimit'):
			isLimitedDepth = True
			depthLimit = args[i+1]
		elif(args[i] == "trackedPercent"):
			isTrackedLimited = True
			trackedPercent = args[i+1]
		elif(args[i] == "useGlob"):
			useGlob = True
		elif(args[i] == "restrictLimit"):
			exceedLimit = args[i+1]
		elif(args[i] == "useRegOffset"):
			useRegOffset = True
                


	return (manifest_file,man_data, work_dir, opt_flag, strip_flag, icp_flag, annot_flag, track_allocas, contextType, isLimitedDepth, depthLimit, isTrackedLimited, trackedPercent, useGlob,exceedLimit,disableExit,useRegOffset,opt_level,file_specialize,loop,string_specialize,spec_flag)

