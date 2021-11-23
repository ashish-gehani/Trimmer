# Copyright (c) 2020 SRI International All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

import subprocess
import sys, os
import argparse

def run_test(workdir, typ, lo, hi):

    if not os.path.exists(workdir):
        os.makedirs(workdir)

         
    script_dir = os.path.dirname(os.path.realpath(__file__))
    os.chdir(script_dir)
    numTest = 0;
    numPass = 0;
    numFail = 0;
    index = 0
    if typ == 'all':
      f = open("tests.txt", "rb")
      text = str(f.read())
      f.close()
      lines = text.split('\n')
      test_type_array = []
      test_start_array = []
      test_end_array = []

      for line in lines:
       split_line = line.split(',')
       if len(split_line) <=1:
         continue;
       test_type_array.append(split_line[0])
       test_start_array.append(int(split_line[1]))
       test_end_array.append(int(split_line[2]))
      
      for typ in test_type_array:
       print('\nTest Directory: ' + typ + '_tests')
       lo = test_start_array[index]
       hi = test_end_array[index]
       script_file = 'script.sh' if typ != 'annotation' else 'annotate.sh'
       src_dir = os.path.join(script_dir, '../src', typ + "_tests")
       index = index + 1
    
       for i in xrange(lo, hi + 1):
        fileName = "../data/configFile" + str(i) + ".txt"
        if not os.path.isfile(os.path.join(src_dir, 'test' + str(i) + '.c')):
            continue
        print 'running test ' + str(i)
        numTest = numTest + 1
        Cmd = ['./' + script_file ,'test' + str(i) ,'out' + str(i) , workdir, src_dir,fileName]
        if os.path.exists("temp.txt"):
          os.remove("temp.txt")
        f = open("temp.txt", "wb")
        subprocess.call(Cmd,stderr=f)	
        f = open("temp.txt", "rb")
        lines = str(f.read())
        if lines.find("Test passed") != -1:
          print("Test passed")
          numPass = numPass + 1
        else:
          numFail = numFail + 1
          print("Test failed")
      print("\nTotal Tests: " + str(numTest))
      print("Passed: " + str(numPass))
      print("Failed: " + str(numFail))
      os.remove("temp.txt")
    else:
      script_file = 'script.sh' if typ != 'annotation' else 'annotate.sh'
      src_dir = os.path.join(script_dir, '../src', typ + "_tests")  
      for i in xrange(lo, hi + 1):
        fileName = "../data/configFile" + str(i) + ".txt"
        if not os.path.isfile(os.path.join(src_dir, 'test' + str(i) + '.c')):
            continue
        print 'running test ' + str(i)
        numTest = numTest + 1
        Cmd = ['./' + script_file ,'test' + str(i) ,'out' + str(i) , workdir, src_dir,fileName]
        if os.path.exists("temp.txt"):
          os.remove("temp.txt")
        f = open("temp.txt", "wb")
        subprocess.call(Cmd,stderr=f)	
        f = open("temp.txt", "rb")
        lines = str(f.read())
        if lines.find("Test passed") != -1:
          print("Test passed")
          numPass = numPass + 1
        else:
          numFail = numFail + 1
          print("Test failed")
      print("\nTotal Tests: " + str(numTest))
      print("Passed: " + str(numPass))
      print("Failed: " + str(numFail))
      os.remove("temp.txt")

 

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
