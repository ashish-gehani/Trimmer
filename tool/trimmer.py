import os, sys
from shutil import copyfile
import utils, driver

# Disable debug mesages by default
debugPrint = 1

class Trimmer:

    def __init__(self, (manifest_file,man_data, work_dir, opt_flag, spec_flag, strip_flag, icp_flag, annot_flag, track_allocas, context_type, depth_flag, anot_depth,load_flag, load_percent,use_glob,exceed_limit,disable_exit,use_reg_offset,opt_level)):

	self.manifestFile = manifest_file        
	self.name = man_data["name"]
        self.main = man_data["main"]
        self.main_path = man_data["main_path"]
        self.args = utils.format_args(self.name, man_data["args"])
        self.modules = man_data["modules"]
        self.ldflags = ' '.join(man_data["ldflags"])
        self.native_libs = ' '.join(man_data["native_libs"])
        self.exe_name = man_data["binary"]
        self.config_files = ""
        if("config_files" in man_data):
            self.config_files = ','.join(man_data["config_files"])
        self.work_dir = work_dir
        self.opt_flag = opt_flag
        self.spec_flag = spec_flag
        self.strip_flag = strip_flag
        self.icp_flag = icp_flag
        self.annot_flag = annot_flag
        self.track_allocas = track_allocas
        self.context_type = context_type
        self.depth_flag = depth_flag
        self.anot_depth = anot_depth
        self.load_flag = load_flag
        self.load_percent = load_percent
        self.use_glob = use_glob
        self.exceed_limit = exceed_limit
        self.disable_exit = disable_exit
        self.use_reg_offset = use_reg_offset
        self.opt_level = opt_level
        self.print_info()

    def print_info(self):

        print '*Program Name = ' + self.name
        print '*Static Arguments = ' + self.args
        print 'modules are ' + ' '.join(self.modules)
        print 'ldflags are ' + self.ldflags
        print 'native_libs are ' + self.native_libs
        print 'exe name is ' + self.exe_name
        print 'work_dir is ' + self.work_dir
        print 'config_files are ' + self.config_files
        print 'Limiting Depth ? ' + str(self.depth_flag)
        print 'annotation depth ' + str(self.anot_depth)
        print 'Limiting Loads ? ' + str(self.load_flag)
        print 'load percent ' + str(self.load_percent)
        print 'Use globals? ' + str(self.use_glob)
        print 'exceedLimit ' + str(self.exceed_limit)
        print 'disable_exit ? '+ str(self.disable_exit)
        print 'use_reg_offset ? '+ str(self.use_reg_offset)
        print 'opt_level ? '+ str(self.opt_level)


    def run(self):
        self.curr_file = self.work_dir + '/' + self.main
        utils.exists(self.main_path)
        print self.main_path
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
    print "\n******* TRIMMER *********** \n"
    Trimmer(utils.parse_args(args)).run()

main(sys.argv[1:])

