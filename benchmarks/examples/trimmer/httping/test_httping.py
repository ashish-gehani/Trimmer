import subprocess
import time
import os
#import urllib.request


def main():
    # Note the -u here: essential for not buffering the stdout of the subprocess
    f = open('t_out','w')
    proc = subprocess.Popen(['trimmer/work_dir/httping_fin_stripped', '-G','s','X','b','B','http://www.facebook.com'],
                            stdout=f,
                            stderr=subprocess.STDOUT)

    try:
        time.sleep(10)
        
    finally:
        # This is in 'finally' so that we can terminate the child if something
        # goes wrong
        proc.terminate()
        try:
            outs, _ = proc.communicate(timeout=10)
            # We'll see it exiting with -15 which means killed by SIGTERM
            print('== subprocess exited with rc =', proc.returncode)
            f.close()
            f = open('t_out','r')
            a = f.read()
            if a.find("connected to") !=-1:
              print("Test Passed")
            else:
              print("Test Failed")
            f.close()
            os.remove('t_out')
        except subprocess.TimeoutExpired:
            print('subprocess did not terminate in time')


if __name__ == '__main__':
    main()
