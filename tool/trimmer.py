import os, sys
from shutil import copyfile
import utils, commands

class Trimmer:
	
	def __init__(self, (man_data, work_dir, opt_flag, spec_flag, strip_flag, icp_flag)):

		self.name = man_data["name"]
		self.main = man_data["main"]
		self.args = utils.format_args(self.name, man_data["args"])
		self.modules = man_data["modules"]
		self.ldflags = ' '.join(man_data["ldflags"])
		self.native_libs = ' '.join(man_data["native_libs"])
		self.exe_name = man_data["binary"]
		self.work_dir = work_dir
		self.opt_flag = opt_flag
		self.spec_flag = spec_flag
		self.strip_flag = strip_flag
		self.icp_flag = icp_flag
		self.print_info()

	def print_info(self):

		print 'name is ' + self.name
		print 'main is ' + self.main
		print 'args are ' + self.args
		print 'modules are ' + ' '.join(self.modules)
		print 'ldflags are ' + self.ldflags
		print 'native_libs are ' + self.native_libs
		print 'exe name is ' + self.exe_name
		print 'work_dir is ' + self.work_dir

	def run(self):
		self.curr_file = self.work_dir + '/' + self.main
		utils.exists(self.main)
		copyfile(self.main, self.work_dir + '/' + self.main)
		if(self.spec_flag):	
			commands.run_specs(self)
		commands.handle_libs(self)
		if(self.opt_flag):
			commands.run_opts(self)
		commands.create_exe(self)
		copyfile(self.curr_file, self.work_dir + '/' + self.name + '-final.bc')

def main(args):
	Trimmer(utils.parse_args(args)).run()

main(sys.argv[1:])