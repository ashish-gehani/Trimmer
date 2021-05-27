#!/usr/bin/env python
# Copyright (c) 2020 SRI International All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

"""
To understand this file, you need to know about opentuner and driver.py file.

This file is run by the run_opts function in driver.py, if we use the value auto as optLevel, which means to tune the clang optimization passes in 
such a way that it produces final bitcode file with minimum size.

The final set of optimization passes are written to size_config.json file.

opentuner can be installed using pip install opentuner.


"""

import opentuner
from opentuner import ConfigurationManipulator
from opentuner import MeasurementInterface
from opentuner import Result
from opentuner import EnumParameter
import argparse
import os
import subprocess
import json
import string
CLANG_FLAGS = [
  #-O2 pipeline flags
'-tti', '-targetlibinfo', '-tbaa', '-scoped-noalias', '-assumption-cache-tracker', '-verify', '-simplifycfg', '-domtree',
'-sroa', '-early-cse', '-lower-expect', '-targetlibinfo', '-tti', '-tbaa', '-scoped-noalias', '-assumption-cache-tracker',
'-forceattrs', '-inferattrs', '-ipsccp', '-globalopt', '-domtree', '-mem2reg', '-deadargelim', '-basicaa', '-aa', '-domtree',
'-instcombine', '-simplifycfg', '-basiccg', '-globals-aa', '-prune-eh', '-inline', '-functionattrs', '-domtree', '-sroa', '-early-cse',
'-lazy-value-info', '-jump-threading', '-correlated-propagation', '-simplifycfg', '-basicaa', '-aa', '-domtree', '-instcombine',
'-tailcallelim', '-simplifycfg' , '-reassociate', '-domtree', '-loops', '-loop-simplify', '-lcssa', '-loop-rotate', '-basicaa', '-aa',
'-licm', '-loop-unswitch', '-simplifycfg', '-basicaa', '-aa', '-domtree', '-instcombine', '-loops', '-scalar-evolution', '-loop-simplify',
'-lcssa', '-indvars', '-aa', '-loop-idiom', '-loop-deletion', '-loop-unroll', '-basicaa', '-aa', '-mldst-motion', '-aa', '-memdep', '-gvn',
'-basicaa', '-aa', '-memdep', '-memcpyopt', '-sccp', '-domtree', '-demanded-bits', '-bdce', '-basicaa', '-aa', '-instcombine', '-lazy-value-info',
'-jump-threading', '-correlated-propagation', '-domtree', '-basicaa','-aa', '-memdep', '-dse', '-loops', '-loop-simplify', '-lcssa', '-aa','-licm',
'-adce', '-simplifycfg', '-basicaa', '-aa', '-domtree', '-instcombine', '-barrier', '-basiccg', '-rpo-functionattrs', '-elim-avail-extern',
'-basiccg', '-globals-aa', '-float2int', '-domtree', '-loops', '-loop-simplify', '-lcssa', '-loop-rotate', '-branch-prob', '-block-freq',
'-scalar-evolution', '-basicaa', '-aa', '-loop-accesses', '-demanded-bits', '-loop-vectorize', '-instcombine', '-scalar-evolution', '-aa',
'-slp-vectorizer', '-simplifycfg', '-basicaa', '-aa', '-domtree', '-instcombine', '-loops', '-loop-simplify', '-lcssa', '-scalar-evolution',
'-loop-unroll', '-basicaa', '-aa', '-instcombine', '-loop-simplify', '-lcssa', '-aa', '-licm', '-scalar-evolution', '-alignment-from-assumptions',
'-strip-dead-prototypes', '-globaldce', '-constmerge', '-verify', '-domtree'
]

opt_name = os.environ.get('LLVM_OPT_NAME')
llc_name = os.environ.get('LLVM_LLC_NAME')
clang_name = os.environ.get('LLVM_CXX_NAME')
argparser = argparse.ArgumentParser(parents=opentuner.argparsers())
argparser.add_argument('path', help='path to working directory')
argparser.add_argument('manifest', help='name of the manifest file')

class ClangFlagsTuner(MeasurementInterface):

  
  def manipulator(self):
    """
    Define the search space by creating a
    ConfigurationManipulator
    """
    manipulator = ConfigurationManipulator()
    for flag in CLANG_FLAGS:
      manipulator.add_parameter(
        EnumParameter(flag,
                      ['on', 'off','default'])) #default is needed, optimizations don't work without it(tried and tested)
    return manipulator
  def compile(self, cfg, id):
    """
    Compile a given configuration in parallel

    """
    binary_filename = args.path + '/'  + str(self.programname) +  '_linked_intern.bc'
    opt_cmd = opt_name + ' ' + binary_filename
    opt_cmd += ' -o ' + args.path + '/final.bc'
    for flag in CLANG_FLAGS:
      if cfg[flag] == 'on':
        opt_cmd += ' {0}'.format(flag)

    llc_cmd = llc_name + ' -filetype=obj ' + args.path + '/final.bc' + ' -o ' + args.path + '/' + str(self.programname) + '.o'
    clang_cmd = clang_name + ' ' + str(self.ldflags) + ' ' + args.path + '/' + str(self.programname) + '.o ' + str(self.nativelibs) +  ' -O3 -o ' + args.path + '/' +str(self.binaryname)
    strip_cmd =	'strip ' + args.path + '/' + str(self.binaryname) + ' -o ' + args.path + '/' + str(self.binaryname) +"_stripped"
    self.store_config_list(opt_cmd)
    self.call_program(opt_cmd)
    self.call_program(llc_cmd)
    self.call_program(clang_cmd)


    return self.call_program(strip_cmd)

  def run_precompiled(self, desired_result, input, limit, compile_result, id):
    """
    Run a compile_result from compile() sequentially and return performance
    """
    run_result_getFileSize = os.stat(args.path + '/' + str(self.binaryname) + '_stripped').st_size
    
    self.store_size_list(run_result_getFileSize)
    return Result(time=run_result_getFileSize)

  def run(self, desired_result, input, limit):
    """
    Compile and run a given configuration then
    return performance
    """
    with open(args.manifest) as mfile:
	  man_data = json.load(mfile)
    self.binaryname = man_data["binary"]
    self.programname = man_data["name"]
    self.ldflags = ' '.join(man_data["ldflags"])
    self.nativelibs = ' '.join(man_data["native_libs"])

    
    cfg = desired_result.configuration.data
    compile_result = self.compile(cfg, 0)
    return self.run_precompiled(desired_result, input, limit, compile_result, 0)

  list_size = [] # list of file sizes
  list_config = [] #list of configurations
  
  def store_size_list(self, binary_size):
    """stores file size in a list"""
    self.list_size.append(binary_size)

  def store_config_list(self,cfg):
    """stores configurations in a list"""
    self.list_config.append(cfg)

  def save_final_config(self,configuration):
    """saves list of file size with corresponding optimization in a file"""
    counter = 1
    minIndex = 0
    minimum = self.list_size[0]
    while counter < len(self.list_size) :
      if self.list_size[counter] < minimum:
         minIndex = counter
         minimum = self.list_size[counter]
      counter += 1
    subprocess.call(self.list_config[minIndex], shell=True)
    self.manipulator().save_to_file(self.list_config[minIndex],
                                      args.path + '/size_config.json')


if __name__ == '__main__':
  args = argparser.parse_args()
  ClangFlagsTuner.main(args)
