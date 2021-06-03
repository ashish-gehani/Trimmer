import subprocess
import time
import os
#import urllib.request


def main():
    # Note the -u here: essential for not buffering the stdout of the subprocess
    proc = subprocess.Popen(['python3', '-u', '-m', 'http.server', '8070'],
                            stdout=subprocess.PIPE,
                            stderr=subprocess.STDOUT)

    try:
        time.sleep(20)
        f = open('../b.html','w')
        proc1 = subprocess.call(['trimmer/work_dir/curl_fin_stripped', '--compress', '--http1.1', '--ssl', '--ipv4', 'http://localhost:8070/'],stdout=f)
        f.close()
        f1 = open('../c.html','w')
        proc2 = subprocess.call(['curl', '--compress', '--http1.1', '--ssl', '--ipv4', 'http://localhost:8070/'],stdout=f1)
        f1.close()
        f = open('../b.html','rb')
        f1 = open('../c.html','rb')
        assert f.read() == f1.read(), "Test Failed"
        f.close()
        f1.close()
        print("Test Passed")
        os.remove('../b.html')
        os.remove('../c.html')

        
    finally:
        # This is in 'finally' so that we can terminate the child if something
        # goes wrong
        proc.terminate()
        try:
            outs, _ = proc.communicate(timeout=20)
            # We'll see it exiting with -15 which means killed by SIGTERM
            print('== subprocess exited with rc =', proc.returncode)
            print(outs.decode('utf-8'))
        except subprocess.TimeoutExpired:
            print('subprocess did not terminate in time')


if __name__ == '__main__':
    main()
