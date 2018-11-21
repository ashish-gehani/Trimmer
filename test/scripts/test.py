import subprocess
import sys, os
import argparse

def run_test(workdir, typ, lo, hi):

    if not os.path.exists(workdir):
        os.makedirs(workdir)

    script_dir = os.path.dirname(os.path.realpath(__file__))
    src_dir = os.path.join(script_dir, '../src', typ + "_tests")
    os.chdir(script_dir)
    
    script_file = 'script.sh' if typ != 'annotate' else 'annotate.sh'
    for i in xrange(lo, hi + 1):
        if not os.path.isfile(os.path.join(src_dir, 'inter' + str(i) + '.c')):
            continue
        print 'running test ' + str(i)
        Cmd = './' + script_file + ' inter' + str(i) + ' out' + str(i) + ' ' + workdir + ' ' + src_dir
        subprocess.call(Cmd, shell = True)	

def main():
    parser = get_arg_parser() 
    args = parser.parse_args()

    if not os.path.isabs(args.work_dir):
        args.work_dir = os.path.abspath(os.path.join(os.getcwd(), args.work_dir))

    run_test(args.work_dir, args.type, args.start, args.end)

def get_arg_parser():
    parser = argparse.ArgumentParser(description='Run TRIMMER tests')
    parser.add_argument('work_dir', metavar='work_dir', type=str,
            help='path to place test output')
    parser.add_argument('type', metavar='type', type=str,
            help='type of test, one of misc,bugfix,pointer,tofix,loop,fileio,contprop')
    parser.add_argument('start', metavar='start', type=int,
            help='test number to start from')
    parser.add_argument('end', metavar='end', type=int,
            help='test number to end at')
    return parser

main()
