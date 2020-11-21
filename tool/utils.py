# Copyright (c) 2020 SRI International All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

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
	opt_level = '3'
	spec_flag = True
	strip_flag = True
	icp_flag = True
        annot_flag = 1
        track_allocas = 1
        file_specialize = 1
        string_specialize = 1
        loop = 1
        contextType = 1
        isLimitedDepth = False
        depthLimit = 0
        isLoadsLimited = False
        loadPercent = 100
        useGlob = False
        exceedLimit = 0
        disableExit = False
        useRegOffset = False


	for i in range(2, len(args)):
		if(args[i] == 'optLevel'):
			opt_level = args[i+1]
			if(opt_level == 'none'):
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
                elif(args[i] == 'no-file-specialize'):
                        file_specialize = 0  
                elif(args[i] == 'no-string-specialize'):
                        string_specialize = 0              
                elif(args[i] == 'no-loop-unroll'):
                        loop = 0                    
                elif(args[i] == 'contextType'):
                        contextType = args[i+1]
                elif(args[i] == 'depthLimit'):
                        isLimitedDepth = True
                        depthLimit = args[i+1]
                elif(args[i] == "loadPercent"):
                        isLoadsLimited = True
                        loadPercent = args[i+1]
                elif(args[i] == "useGlob"):
                        useGlob = True
                elif(args[i] == "exceedLimit"):
                        exceedLimit = args[i+1]
                elif(args[i] == "disableExit"):
                        disableExit = True
                elif(args[i] == "useRegOffset"):
                        useRegOffset = True
                


	return (manifest_file,man_data, work_dir, opt_flag, spec_flag, strip_flag, icp_flag, annot_flag, track_allocas, contextType, isLimitedDepth, depthLimit, isLoadsLimited, loadPercent, useGlob,exceedLimit,disableExit,useRegOffset,opt_level,file_specialize,loop,string_specialize)

