#!/usr/bin/env python
# Copyright (c) 2020 SRI International All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

"""
This file uses opentuner to tune the options (useGlob, optLevel, exceedLimit) provided to the trimmer.py in a way that it creates the final binary executable,
which is minimum in size. It takes the path to the manifest file as a parameter.

To learn about options, see doc/options.md in the repository.

opentuner can be installed using pip install opentuner.


"""

import argparse
import os
import json
import sys

import opentuner
from opentuner import ConfigurationManipulator
from opentuner import EnumParameter
from opentuner import IntegerParameter
from opentuner import MeasurementInterface
from opentuner import Result

TRIMMER_FLAGS = [
  'useGlob'
]

trimmer_path = os.environ.get('TRIMMER_HOME')
argparser = argparse.ArgumentParser(parents=opentuner.argparsers())
argparser.add_argument('source', help='path to manifest file')


class TrimmerFlagsTuner(MeasurementInterface):

  def manipulator(self):
    """
    Define the search space by creating a
    ConfigurationManipulator
    """
    manipulator = ConfigurationManipulator()
    manipulator.add_parameter(
      EnumParameter('opt_level', ['default','none','0','1','2','3','s']))
    manipulator.add_parameter(
      EnumParameter('exceedLimit', ['default','0','50','100','150','200','250','300','350','400','450','500','550','600','650','700','750','800','850','900','950','1000']))

    for flag in TRIMMER_FLAGS:
      manipulator.add_parameter(
        EnumParameter(flag, ['on', 'off','default']))
    return manipulator

    
  def run(self, desired_result, input, limit, id,cfg):
    
    trimmer_cmd = 'python ' + trimmer_path + '/tool/trimmer.py ' + args.source +  ' workdir{0}'.format(id) 
    if cfg['opt_level'] != 'default':
    	trimmer_cmd += ' optLevel {0}'.format(cfg['opt_level'])
    if cfg['exceedLimit'] != 'default':
    	trimmer_cmd += ' exceedLimit {0}'.format(cfg['exceedLimit'])
    for flag in TRIMMER_FLAGS:
      if cfg[flag] == 'on':
        trimmer_cmd += ' {0}'.format(flag)
    try:    
        print(trimmer_cmd)
        run_result = self.call_program(trimmer_cmd)
        assert run_result['returncode'] == 0
        with open(args.source) as mfile:
	        man_data = json.load(mfile)
        binaryName = man_data['binary']
        if os.path.isfile('workdir{0}/'.format(id) + binaryName + '_stripped'):
		result_size = os.stat('workdir{0}/'.format(id) + binaryName + '_stripped').st_size
        else
		result_size = sys.float_info.max
    finally:
        self.call_program('rm -r workdir{0}'.format(id))
   

    return Result(time=result_size)

  def compile_and_run(self, desired_result, input, limit):
    cfg = desired_result.configuration.data
    return self.run(desired_result, input, limit, 0,cfg)

  def save_final_config(self, configuration):
    """called at the end of tuning"""
    print("Minimum size configuration written to minimumSize.json:", configuration.data)
    self.manipulator().save_to_file(configuration.data,
                                    'minimumSize.json')


if __name__ == '__main__':
  args = argparser.parse_args()
  TrimmerFlagsTuner.main(args)
