# Copyright (c) 2020 SRI International All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

#!/usr/bin/env python

#-------------------------------------------------------------------#
#                         Benchmark runner
#-------------------------------------------------------------------#

# NOTE: this script reads from the standard output/error to extract
# information about Trimmer and ROPgadget. Thus, any change in these
# tools might break this script. 

import sys
import os
import os.path
import re
import datetime 
import collections
import argparse as a
import pptable
import commands as cmd

verbose = False
# named tuple for trimmer stats
trimmer_stats = collections.namedtuple('TrimmerStats', 'funcs insts mem_insts bin_size test_status')

def get_trimmer_home():
    path = os.environ.get('TRIMMER_HOME')
    if path is None:
        cmd.raise_error("need to set TRIMMER_HOME environment variable")
    return path

def get_ropgadget():
    ropgadget = None
    if 'ROPGADGET' in os.environ: ROPGADGET = os.environ ['ROPGADGET']
    if not cmd.is_exec(ropgadget): ropgadget = cmd.which('ropgadget')
    if not cmd.is_exec(ropgadget): ropgadget = cmd.which('ROPgadget.py')    
    if not cmd.is_exec(ropgadget):
        raise IOError("Cannot find ropgadget")
    return ropgadget
    
def get_benchmarks(name):
    import json
    with open(name, "r") as f:
        benchs = list()
        try:
            d = json.load(f)
            benchs = d['benchmarks']
        except ValueError as msg:
            print (("Error: while decoding JSON file " + name)) 
            print (msg)
    f.close()
    return benchs

def read_trimmer_output(logfile):
    b_funcs, b_insts, b_mem, b_size = 0, 0, 0, 0
    a_funcs, a_insts, a_mem, a_size = 0, 0, 0, 0
    testStatus = "Failed"
    before_done = False    
    with open(logfile, 'r') as fd:
        for line in fd:
            if re.search('^Statistics for \S* after specialization', line):
                before_done = True
            if re.search('Number of functions', line):
                n = int(line.split()[0])
                if not before_done:
                    b_funcs = n
                else:
                    a_funcs = n
            if re.search('Number of instructions', line):
                n = int(line.split()[0])
                if not before_done:
                    b_insts = n
                else:
                    a_insts = n
            if re.search('Statically unknown memory accesses', line):
                n = int(line.split()[0])
                if not before_done:
                    b_mem = n
                else:
                    a_mem = n
            if re.search('Binary Size', line):
                n = int(line.split()[2])
                if not before_done:
                    b_size = n
                else:
                    a_size = n
            if re.search('Passed', line):
                testStatus = "Passed"
            if re.search('Not Available', line):
                testStatus = "Unavailable"


    before = trimmer_stats(funcs=b_funcs, insts=b_insts, mem_insts=b_mem, bin_size=b_size, test_status=testStatus)
    after = trimmer_stats(funcs=a_funcs, insts=a_insts, mem_insts=a_mem, bin_size=a_size, test_status="NA")
    fd.close()
    return (before, after)

def read_ropgadget_output(logfile):
    num_gadgets = 0
    with open(logfile, 'r') as fd:
        for line in fd:
            if re.search('Unique gadgets found:', line):
                num_gadgets = int(line.split()[3])
                fd.close()
                return num_gadgets
    fd.close()
    return num_gadgets

def pretty_printing_trimmer(results):
    tab = []
    for benchmark, before, after in results:
        if before is None or after is None:
            continue
        
        func_red = 0.0
        if (before.funcs > 0):
            func_red = (1.0 - (float(after.funcs) / float(before.funcs))) * 100.0
        bin_red = 0.0
        if (before.bin_size > 0):
            bin_red = (1.0 - (float(after.bin_size) / float(before.bin_size))) * 100.0
        insts_red = 0.0
        if (before.insts > 0):
            insts_red = (1.0 - (float(after.insts) / float(before.insts))) * 100.0
        mem_red = 0.0
        if (before.mem_insts > 0):
            mem_red = (1.0 - (float(after.mem_insts) / float(before.mem_insts))) * 100.0
        tab.append([benchmark,
                    before.test_status,
                    before.bin_size,
                    after.bin_size,
                    float("{0:.2f}".format(bin_red)),
                    before.funcs,
                    after.funcs,
                    float("{0:.2f}".format(func_red)),
                    before.insts,
                    after.insts,                    
                    float("{0:.2f}".format(insts_red)),
                    before.mem_insts,
                    after.mem_insts,                    
                    float("{0:.2f}".format(mem_red))])

    table = [["Program", \
              "Test", \
              "B Size", "A Size", "% Size Red", \
              "B Fun", "A Fun", "% Fun Red", \
              "B Ins", "A Ins", "% Ins Red", \
              "B Mem Ins", "A Mem Ins", "% Mem Ins Red"]]
    
    for row in tab:
        table.append(row)
        
    import pptable
    out = sys.stdout
    pptable.pprint_table(out,table)

def pretty_printing_ropgadget(results):
    tab = []
    for benchmark, \
        total_before, total_after,  \
        jop_before, jop_after, \
        sys_before, sys_after, \
        rop_before, rop_after in results:
    
        # total_red = 0.0
        # if (total_before > 0):
        #     total_red = (1.0 - (float(total_after) / float(total_before))) * 100.0
        rop_red = 0.0
        if (rop_before > 0):
            rop_red = (1.0 - (float(rop_after) / float(rop_before))) * 100.0
        sys_red = 0.0
        if (sys_before > 0):
            sys_red = (1.0 - (float(sys_after) / float(sys_before))) * 100.0        
        jop_red = 0.0
        if (jop_before > 0):
            jop_red = (1.0 - (float(jop_after) / float(jop_before))) * 100.0
            
        tab.append([benchmark,
                    #total_before,
                    #total_after,
                    #float("{0:.2f}".format(total_red)),
                    rop_before,
                    rop_after,
                    float("{0:.2f}".format(rop_red)),
                    sys_before,
                    sys_after,
                    float("{0:.2f}".format(sys_red)),
                    jop_before,
                    jop_after,
                    float("{0:.2f}".format(jop_red))])

    table = [["Program", \
              "B ROP", "A ROP", "% ROP Red", \
              "B SYS", "A SYS", "% SYS Red", \
              "B JOP", "A JOP", "% JOP Red"]]
    
    for row in tab:
        table.append(row)
        
    out = sys.stdout
    pptable.pprint_table(out,table)
    
    
def run_trimmer(dirname, execname, workdir, cpu, mem, delete_temps, trimmer_opts= []):
    #benchmark_name = os.path.basename(os.path.normpath(dirname))
    benchmark_name = execname
    outfile = benchmark_name + ".trimmer.out"
    errfile = benchmark_name + ".trimmer.err"
    outfileName = os.path.join(workdir, outfile)
    errfileName = os.path.join(workdir, errfile)
    outfd = open(outfileName, "w")
    errfd = open(errfileName, "w")
    res_before, res_after = None, None
    #1. Generate bitcode: run `make`
    returncode,_,_,_ = cmd.run_limited_cmd(['make'], outfd, errfd, benchmark_name, dirname)
    if returncode != 0:
        if (delete_temps):
            cmd.warning("something failed while running \"make\"" + benchmark_name + "\n" + \
                        "Turn on logging to generate logs")
        else:
            cmd.warning("something failed while running \"make\"" + benchmark_name + "\n" + \
                        "\"" + benchmark_name + "\n" + \
                        "Read logs at " + outfileName + " and " + errfileName)
    else:
        #2. Run Trimmer on it: `build.sh opts`
        trimmer_args = ['./build.sh']
        trimmer_args.extend(trimmer_opts)
        print (("Running trimmer with options " + str(trimmer_args)))
        returncode,_,_,_ = \
         cmd.run_limited_cmd(trimmer_args, outfd, errfd, benchmark_name, dirname, cpu, mem)
        if returncode != 0:
            if (delete_temps):
                cmd.warning("something failed while running \"" + ' '.join(trimmer_args) + \
                            "\"" + benchmark_name + "\n" + \
                            "Turn on logging to generate logs")
            else:
                cmd.warning("something failed while running \"" + ' '.join(trimmer_args) + \
                            "\"" + benchmark_name + "\n" + \
                            "Read logs at " + outfileName + " and " + errfileoutfileName)
        
    outfd.close()
    errfd.close()

    if returncode == 0:
        #All Trimmer output is redirected to error
        logfile = os.path.join(workdir, errfile)
        (res_before, res_after) = read_trimmer_output(logfile)
        
    return (benchmark_name, res_before, res_after)

#Pre: run_trimmer has been executed already and thus, there are two 
#executables in dirname: the original one and the one after trimmer.        
def run_ropgadget(dirname, execname, workdir, cpu, mem):
    def run_ropgadget_on_pair(bench_name, prog_before, prog_after, opts, \
                              logfile, outfd, errfd):
        outfd.seek(0,0)
        errfd.seek(0,0)
        res_before, res_after = None, None
        args = [get_ropgadget(), '--binary', prog_before] + opts
        returncode,_,_,_ = cmd.run_limited_cmd(args, outfd, errfd, bench_name)
        # ROPgadget returns 1 if success
        if returncode != 1:
            cmd.warning("something failed while running \"" + ' '.join(args) + "\"")
        else:
            res_before = read_ropgadget_output(logfile)
            outfd.seek(0,0)
            errfd.seek(0,0)
            args = [get_ropgadget(), '--binary', prog_after] + opts
            returncode,_,_,_ = cmd.run_limited_cmd(args, outfd, errfd, bench_name)
            # ROPgadget returns 1 if success        
            if returncode != 1:
                cmd.warning("something failed while running \"" + ' '.join(args) + "\"")
            else:
                res_after = read_ropgadget_output(logfile)
                
        return (res_before, res_after)

    #benchname = os.path.basename(os.path.normpath(dirname))
    benchname = execname
    outfile = benchname + ".ropgadget.out"
    errfile = benchname + ".ropgadget.err"
    outfd = open(os.path.join(workdir, outfile), "w")
    errfd = open(os.path.join(workdir, errfile), "w")

    prog_before = os.path.join(dirname, benchname + "_orig")
    prog_after = os.path.join(dirname, benchname + "_trimmed")

    total_before, total_after = None, None
    rop_before, rop_after = None, None    
    jop_before, jop_after = None, None
    sys_before, sys_after = None, None
    
    if os.path.exists(prog_before) and os.path.exists(prog_after): 
        # total gadgets: ropgadget --binary prog
        # only jop:      ropgadget --binary --norop --nosys
        # only sys:      ropgadget --binary --nojop --norop
        # only rop:      ropgadget --binary --nojop --nosys    
        logfile = os.path.join(workdir, outfile)
        opts = []
        (total_before, total_after) = run_ropgadget_on_pair(benchname, prog_before, prog_after, \
                                                            opts, logfile, outfd, errfd)
        opts = ['--norop','--nosys']
        (jop_before, jop_after) = run_ropgadget_on_pair(benchname, prog_before, prog_after, \
                                                        opts, logfile, outfd, errfd)
        opts = ['--nojop', '--norop']
        (sys_before, sys_after) = run_ropgadget_on_pair(benchname, prog_before, prog_after, \
                                                        opts, logfile, outfd, errfd)
        opts = ['--nojop', '--nosys']
        (rop_before, rop_after) = run_ropgadget_on_pair(benchname, prog_before, prog_after, \
                                                        opts, logfile, outfd, errfd)
    else:
        if not os.path.exists(prog_before):
            cmd.warning(prog_before + " does not exist")
        if not os.path.exists(prog_after):
            cmd.warning(prog_after + " does not exist")
            
    outfd.close()
    errfd.close()    
    return (benchname, \
            total_before, total_after, \
            jop_before, jop_after, \
            sys_before, sys_after, \
            rop_before, rop_after)

def parse_opt (argv):
    p = a.ArgumentParser (description='Benchmark Runner for Trimmer')
    p.add_argument ('--remove-temps', '--delete-temps',
                    dest="delete_temps",
                    help="Delete temporary files",
                    action="store_true", default=False)
    p.add_argument ('--temp-dir', dest='temp_dir', metavar='DIR',
                    help="Temporary directory", default="Logs")
    p.add_argument ('--cpu', type=int, dest='cpu', metavar='SEC',
                    help='CPU time limit (seconds)', default=-1)
    p.add_argument ('--mem', type=int, dest='mem', metavar='MB',
                    help='MEM limit (MB)', default=-1)
    p.add_argument ('--sets', type=str, 
                    help="List of .set files (separated by comma)",
                    dest='benchmark_sets', default="")
    p.add_argument ('--trimmer-opts', type=str,
                    help="Options passed to trimmer.py (options separated by comma)",
                    dest='trimmer_opts', default="")
    p.add_argument ('--rop', help="Generate statistics about ROP/SYS/JOP gadgets (not maintained anymore)",
                    dest='rop', default=False, action="store_true")
    
    
    args = p.parse_args (argv)
    return args

def main (argv):
    args = parse_opt (argv[1:])
    workdir = cmd.create_work_dir(args.temp_dir, not args.delete_temps)
    sets = []
    trimmer_opts = []
    trimmer_tab = list()
    ropgadget_tab = list()

    for trimmer_opt in args.trimmer_opts.split(","):
        trimmer_opts += [trimmer_opt]

    for benchmark_set in args.benchmark_sets.split(","):
        if benchmark_set is not "":
            sets += [benchmark_set]

    if not sets:
        print ("Warning: you need to choose a benchmark set. Use option --sets")
        return 0
    
    if args.rop:
        print ("Warning: option --rop is not maintained anymore.")
        args.rop = False
        
    dt = datetime.datetime.now ().strftime ('%d/%m/%Y %H:%M:%S')    
    print (("[" + dt + "] " +  "STARTED runbench" ))   
    for s in sets:
        for t in get_benchmarks(s):
            if t['enabled'] == 'false':
                continue
            
            dirname = t['dirname']
            if not os.path.isdir(dirname):
                dirname = os.path.join(get_trimmer_home(), dirname)
                if not os.path.isdir(dirname):
                    cmd.raise_error(t['dirname'] + " is not a directory")
                    
            execname = t['execname']
            res = run_trimmer(dirname, execname, workdir, args.cpu, args.mem, args.delete_temps, trimmer_opts)
            trimmer_tab.append(res)
            if args.rop:
                res = run_ropgadget(dirname, execname, workdir, args.cpu, args.mem)
                ropgadget_tab.append(res)

    dt = datetime.datetime.now ().strftime ('%d/%m/%Y %H:%M:%S')                
    print (("[" + dt + "] " +  "FINISHED runbench\n"))

    if (len(trimmer_opts) > 0 and trimmer_opts[0] != ''):
        print (("\nProgram Reduction: (B:before and A:after Trimmer with " + \
            ' '.join(trimmer_opts) + ")\n"))
    else:
        print (("\nProgram Reduction: (B:before and A:after Trimmer with default options)\n"))

    pretty_printing_trimmer(trimmer_tab)
    
    if args.rop:
        print (("\nGadget Reduction: (B:before and A:after Trimmer with " + \
            ' '.join(trimmer_opts) + ")\n"))
        pretty_printing_ropgadget(ropgadget_tab)
        
    return 0
    
if __name__ == '__main__':
    res = None
    try:
        res = main(sys.argv)
    except Exception as e:
        print (e)
    except KeyboardInterrupt:
        pass
    finally:
        sys.exit(res)

