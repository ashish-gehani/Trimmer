# Copyright (c) 2020 SRI International All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

"""
Slider is a tool which allows varying of the dept of the Control Flow Graph considered in 
annotation during the AnnotateNew pass used in Trimmer. During the process it collects statistics
and produces a plot to summarise results and debloating.

Slider also handles errors, where a failed iteration is logged, and the tool moves on to the next iteration.

The Call Graph Depth steps by 1, while the Percentage by 10%. It's configurable according to need in the corresponding
label objects.


# python3 slider.py manifest mode startlim endlim
# Where mode is  "depth" or "percent"

"""
import subprocess
import sys
import json
import os
import matplotlib.pyplot as plt
import csv

# python3 slider.py manifest mode startlim endlim
# Where mode is  "depth" or "percent"




def print_and_run(cmd):
    print(cmd)
    subprocess.call(cmd, shell=True)

def run_in_dir(cmd, directory):
    print(directory+"$ " +  cmd)
    subprocess.call(cmd, shell=True, cwd = directory)

def getMemoryStats(basename, directory):
    cmd = "opt-4.0 -load $TRIMMER_HOME/libLLVMMyCount.so -mycount "+basename+"_annotated.bc " 
    run_in_dir(cmd, directory) 

    AnnotStats = {}
    MemoryStats = {}

    with open(directory+"/"+"stats.JSON","r") as StatFile:
        MemoryStats = json.load(StatFile)

    with open(directory+"/"+"anotStats.JSON","r") as StatFile:
        AnnotStats = json.load(StatFile)

    print("Memory Stats: {}".format(MemoryStats))
    print("Annotation Stats: {}".format(AnnotStats))

    tracked_allocas = AnnotStats['trackedAllocas'] - AnnotStats['globals']
    total_allocas = MemoryStats['total']
    final_size = os.path.getsize(directory+"/"+basename+"_fin")

    return {"tracked":tracked_allocas , "total":total_allocas, "binary_size": final_size} 


def create_plot(name, data,detail):
    x = [(float(point['tracked'])/point['total']*100.0) for point in data]
    y = [point['binary_size'] for point in data]

    print("x: {}, y:{}".format(x,y))

    with open(name+detail["plot_detail_str"]+".csv", mode='w') as StatFile:
        stat_writer = csv.writer(StatFile, delimiter=',')
        stat_writer.writerow([detail["csv_col"], 'Tracked Absolute', '% Tracked', 'Binary Size'])
        for cg_depth in range(0,len(data)):
            point = data[cg_depth]
            stat_writer.writerow([str(point['limit']), str(point['tracked']),str(x[cg_depth]), str(point['binary_size'])]) 

    plt.figure()
    plt.plot(x,y, color='green', linestyle = 'dashed', linewidth = 2,
            marker = 'o', markerfacecolor='blue', markersize=5)

    plt.xlabel('% Variables Tracked')
    plt.ylabel('Binary-Size / Bytes')
    plt.title("{} Trimmer Results".format(name))
    plt.grid()

    plt.savefig(name+detail["plot_detail_str"]+"_summary.png")





if len(sys.argv) != 5:
    print("Incorrect number of arguments passed... \n\
            python slider.py manifest mode startdept enddept")
            
print("="*5 + "Slider" + "="*5)
MANIFEST = sys.argv[1]
MODE = sys.argv[2]
PROGNAME = MANIFEST.split(".")[0]
LOW = int(sys.argv[3])
HIGH = int(sys.argv[4])


parentDir = PROGNAME +"_"+MODE.upper()+"_"+str(LOW)+"_"+str(HIGH)
cmd = "mkdir {} && cp {} {}".format(parentDir, MANIFEST, parentDir)
print_and_run(cmd)

cmd = "cp {} {}".format(PROGNAME+".bc", parentDir)
print_and_run(cmd)

with open(MANIFEST,"r") as ManFile:
    man = json.load(ManFile)
    for conf in man['config_files']:
        cmd = "cp {} {}".format(conf,parentDir)
        print_and_run(cmd)



summary = []

def run_standard_trimmer(parentDir):
    print("Running Trimmer with Full Annotation")
    dirName = "ANOT_FULL"
    logName = "LOG_FULL"
    try:
        cmd = "python $TRIMMER_HOME/tool/trimmer.py "+MANIFEST+" "+dirName + " 2>" + logName 
        run_in_dir(cmd,'./' + parentDir)

        cmd = "mv "+ logName +" "+dirName
        run_in_dir(cmd, './'+parentDir)

        cmd = "mv anotStats.JSON "+ dirName
        run_in_dir(cmd, './'+parentDir)

        result = getMemoryStats(PROGNAME,"./"+parentDir+"/"+dirName)
        result['limit'] = 1000 
        summary.append(result)
    except KeyboardInterrupt:
        print("Killing Slider")
        sys.exit()
    except:
        with open(PROGNAME+"_"+MODE+"_slider_log.txt","a+") as ErrorLog:
            ErrorLog.write("Error while process limit: {}\n".format("FULL"))




depthLabels = {
        "detail_str": "Annotion-Depth",
        "dir_name_prefix": "ANOT_DEPTH_",
        "log_name_prefix": "ANOT_LOG_",
        "slider_flag":" depthLimit ",
        "step":1,
        "csv_col":"CallGraph-Depth",
        "plot_detail_str": "_Depth_Vary",
}

percentLabels = {
        "detail_str": "Sorted Percentage",
        "dir_name_prefix": "ANOT_PERCENT_",
        "log_name_prefix": "ANOT_LOG_",
        "slider_flag":" trackedPercent ",
        "step":10,
        "csv_col":"Top N Percent Sources",
        "plot_detail_str":"_Percent_Vary_",
}


currentModeLabels = {}

if MODE == "depth":
    currentModeLabels = depthLabels
elif MODE == "percent":
    currentModeLabels = percentLabels


for limit in range(LOW, HIGH+(2*currentModeLabels["step"]),currentModeLabels["step"]): 
    try:
        if limit == HIGH+currentModeLabels["step"]:
            run_standard_trimmer(parentDir)
            continue

        print("Running Trimmer with {} = {}".format(currentModeLabels["detail_str"],limit))
        dirName = currentModeLabels["dir_name_prefix"]+str(limit)
        logName = currentModeLabels["log_name_prefix"]+str(limit)

        cmd = "python $TRIMMER_HOME/tool/trimmer.py "+MANIFEST+" "+dirName + currentModeLabels["slider_flag"]+ str(limit) + " 2>" + logName 
        run_in_dir(cmd,'./' + parentDir)

        cmd = "mv "+ logName +" "+dirName
        run_in_dir(cmd, './'+parentDir)

        cmd = "mv anotStats.JSON "+ dirName
        run_in_dir(cmd, './'+parentDir)

        result = getMemoryStats(PROGNAME,"./"+parentDir+"/"+dirName)
        result['limit'] = limit

        print(result)
        summary.append(result)
    except KeyboardInterrupt:
        print("Killing Slider...")
        sys.exit()
    except:
        print("Slider CRASHED")
        with open(PROGNAME+"_"+MODE+"_slider_log.txt","a+") as ErrorLog:
            ErrorLog.write("Error while process limit: {}\n".format(limit))
        continue






create_plot(PROGNAME, summary, currentModeLabels)

    





