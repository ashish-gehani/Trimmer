import subprocess
import time
import os
#import urllib.request


def main():
    # Note the -u here: essential for not buffering the stdout of the subprocess
    proc = subprocess.Popen(['trimmer/mem/memcached_fin_stripped','-m','64','-l','127.0.0.1'],
                            stdout=subprocess.PIPE,
                            stderr=subprocess.STDOUT)

    try:
        time.sleep(15)
        #resp = urllib.request.urlopen('http://localhost:8070/o_out')
        #resp1 = urllib.request.urlopen('http://localhost:8070/a.html')
        f = open('t_out','w')
        proc1 = subprocess.call(['memcslap','-s','127.0.0.1' ],stdout=f)
        f.close()
        f = open('t_out','r')
        a = f.read()
        if a.find('Failure') == -1:  
          print("Test Passed")
        else:
          print("Test Failed")
        os.remove('t_out')


        
    finally:
        # This is in 'finally' so that we can terminate the child if something
        # goes wrong
        proc.terminate()
        try:
            outs, _ = proc.communicate(timeout=15)
            # We'll see it exiting with -15 which means killed by SIGTERM
            print('== subprocess exited with rc =', proc.returncode)
            print(outs.decode('utf-8'))
        except subprocess.TimeoutExpired:
            print('subprocess did not terminate in time')


if __name__ == '__main__':
    main()
