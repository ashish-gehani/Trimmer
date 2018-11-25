import subprocess
import sys, os
import argparse

def run_test(workdir, lo, hi):
    if not os.path.exists(workdir):
        os.makedirs(workdir)
    script_dir = os.path.dirname(os.path.realpath(__file__))
    os.chdir(script_dir)
    for i in xrange(lo, hi + 1):
        fileName = "../data/configFile" + str(i) + ".txt";
        if os.path.isfile(os.path.join(script_dir, '../src/ConstProp/', 'inter' + str(i) + '.c')):
            srcPath = 'src/ConstProp/'
        else:
            if os.path.isfile(os.path.join(script_dir, '../src/LoopUnroll/', 'inter' + str(i) + '.c')):
                srcPath = 'src/LoopUnroll/'		
	    else:
                if os.path.isfile(os.path.join(script_dir, '../src/FileIO/', 'inter' + str(i) + '.c')):
                    srcPath = 'src/FileIO/'
                else:
                    continue	
        print 'running test ' + str(i)
        Cmd = './script.sh inter' + str(i) + ' out' + str(i) + ' ' + workdir + ' ' + srcPath + ' ' + fileName
        subprocess.call(Cmd, shell = True)	

def main():
    parser = get_arg_parser() 
    args = parser.parse_args()

    if not os.path.isabs(args.work_dir):
        args.work_dir = os.path.abspath(os.path.join(os.getcwd(), args.work_dir))

    run_test(args.work_dir, args.start, args.end)

def get_arg_parser():
    parser = argparse.ArgumentParser(description='Run TRIMMER tests')
    parser.add_argument('work_dir', metavar='work_dir', type=str,
            help='path to place test output')
    parser.add_argument('start', metavar='start', type=int,
            help='test number to start from')
    parser.add_argument('end', metavar='end', type=int,
            help='test number to end at')
    return parser

main()
