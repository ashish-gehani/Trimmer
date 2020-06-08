#!/usr/bin/env python
#
# Autotune flags to g++ to optimize the performance of apps/raytracer.cpp
#
# This is an extremely simplified version meant only for tutorials
#

import argparse
import os
import json

import opentuner
from opentuner import ConfigurationManipulator
from opentuner import EnumParameter
from opentuner import IntegerParameter
from opentuner import MeasurementInterface
from opentuner import Result

TRIMMER_FLAGS = [
  'useGlob', 'disableExit','useRegOffset'
]

# (name, min, max)
TRIMMER_PARAMS = [
  ('exceedLimit', 0, 1000),
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
      EnumParameter('opt_level', ['default','0','1','2','3','s']))
    for flag in TRIMMER_FLAGS:
      manipulator.add_parameter(
        EnumParameter(flag, ['on', 'off','default']))
    for param, min, max in TRIMMER_PARAMS:
      manipulator.add_parameter(
        IntegerParameter(param, min, max))
    return manipulator

    
  def run(self, desired_result, input, limit, id,cfg):
    
    trimmer_cmd = 'python ' + trimmer_path + '/tool/trimmer.py ' + args.source +  ' workdir{0}'.format(id) 
    if cfg['opt_level'] != 'default':
    	trimmer_cmd += ' optLevel {0}'.format(cfg['opt_level'])
    for flag in TRIMMER_FLAGS:
      if cfg[flag] == 'on':
        trimmer_cmd += ' {0}'.format(flag)
    for param, min, max in TRIMMER_PARAMS:
      trimmer_cmd += ' {0} {1}'.format(
        param, cfg[param])
    try:    
        print(trimmer_cmd)
        run_result = self.call_program(trimmer_cmd)
        assert run_result['returncode'] == 0
        with open(args.source) as mfile:
	        man_data = json.load(mfile)
        binaryName = man_data['binary']
        print(binaryName)
        result_size = os.stat('workdir{0}/'.format(id) + binaryName + '_stripped').st_size
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
