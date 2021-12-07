# Copyright (c) 2020 SRI International All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

"""
This is the main python file which is used to run Trimmer. It contains Trimmer class with attributes such as name of the manifest file, 
values set in the manifest file (arguments, native libraries etc) and options specified by user (such as optLevel, useGlob, etc). It contains
two functions print_info ( to print the attributes of the class) and run ( to run Trimmer passes, do optimization, link dynamic libraries and 
create a final binary executable).   


"""

import os, sys
from shutil import copyfile
import utils, driver

# Disable debug mesages by default
debugPrint = 1

class Trimmer:

	def __init__(self,arguments):

		self.manifestFile = arguments[0]        
		self.name = arguments[1]["name"]
		self.main = arguments[1]["main"]
		self.main_path = arguments[1]["main_path"]
		self.args = utils.format_args(self.name, arguments[1]["args"])
		self.modules = arguments[1]["modules"]
		self.ldflags = ' '.join(arguments[1]["ldflags"])
		self.native_libs = ' '.join(arguments[1]["native_libs"])
		self.exe_name = arguments[1]["binary"]
		self.config_files = ""
		if("config_files" in arguments[1]):
			self.config_files = ','.join(arguments[1]["config_files"])
		self.work_dir = arguments[2]
		self.opt_flag = arguments[3]
		self.spec_flag = arguments[21]
		self.strip_flag = arguments[4]
		self.icp_flag = arguments[5]
		self.annot_flag = arguments[6]
		self.track_allocas = arguments[7]
		self.context_type = arguments[8]
		self.file_specialize = arguments[18]
		self.string_specialize = arguments[20]
		self.loop_unroll = arguments[19]
		self.depth_flag = arguments[9]
		self.anot_depth = arguments[10]
		self.tracked_flag = arguments[11]
		self.tracked_percent = arguments[12]
		self.use_glob = arguments[13]
		self.exceed_limit = arguments[14]
		self.disable_exit = arguments[15]
		self.use_reg_offset = arguments[16]
		self.opt_level = arguments[17]
		self.print_info()

	def print_info(self):

		print (('*Program Name = ' + self.name))
		print (('*Static Arguments = ' + self.args))
		print (('modules are ' + ' '.join(self.modules)))
		print (('ldflags are ' + self.ldflags))
		print (('native_libs are ' + self.native_libs))
		print (('exe name is ' + self.exe_name))
		print (('work_dir is ' + self.work_dir))
		print (('config_files are ' + self.config_files))
		print (('Use globals ' + str(self.use_glob)))
		print (('exceedLimit ' + str(self.exceed_limit)))
		print (('opt_level '+ str(self.opt_level)))
		print (('loop unroll '+ str(self.loop_unroll)))
		print (('string specialize '+ str(self.string_specialize)))
		print (('file specialize '+ str(self.file_specialize)))
		print (('contextType '+ str(self.context_type)))


	def run(self):
		self.curr_file = self.work_dir + '/' + self.main
		utils.exists(self.main_path)
		copyfile(self.main_path, self.work_dir + '/' + self.main)
		if(self.spec_flag):
		# The following driver call runs the argument specialization transform
			driver.run_argspec(self)
		driver.link_libs(self)
		if(self.opt_flag):
		# The following driver call runs all the optimization passes
			driver.run_opts(self)
		driver.create_exe(self)
		copyfile(self.curr_file, self.work_dir + '/' + self.name + '-final.bc')

def main(args):
	print ("\n******* TRIMMER *********** \n")
	Trimmer(utils.parse_args(args)).run()

main(sys.argv[1:])


