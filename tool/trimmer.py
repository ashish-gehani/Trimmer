import os, sys
from shutil import copyfile
import utils, driver

# Disable debug mesages by default
debugPrint = 1

class Trimmer:

    def __init__(self, (man_data, work_dir, opt_flag, spec_flag, strip_flag, icp_flag, annot_flag, track_allocas)):

        self.name = man_data["name"]
        self.main = man_data["main"]
        self.main_path = man_data["main_path"]
        self.args = utils.format_args(self.name, man_data["args"])
        self.modules = man_data["modules"]
        self.ldflags = ' '.join(man_data["ldflags"])
        self.native_libs = ' '.join(man_data["native_libs"])
        self.exe_name = man_data["binary"]
        self.config_files = ','.join(man_data["config_files"])
        self.work_dir = work_dir
        self.opt_flag = opt_flag
        self.spec_flag = spec_flag
        self.strip_flag = strip_flag
        self.icp_flag = icp_flag
        self.annot_flag = annot_flag
        self.track_allocas = track_allocas
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
    print "\n******* TRIMMER *********** \n"     
    Trimmer(utils.parse_args(args)).run()

main(sys.argv[1:])
