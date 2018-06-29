import subprocess
import sys, os
import argparse

def run_test(workdir, lo, hi):
    if not os.path.exists(workdir):
        os.makedirs(workdir)
    os.chdir(os.path.dirname(os.path.realpath(__file__)))
    for i in xrange(lo, hi + 1):
        if not os.path.isfile('inter' + str(i) + '.c'):
            continue	
        print 'running test ' + str(i)
        Cmd = './script.sh inter' + str(i) + ' out' + str(i) + ' ' + workdir
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
