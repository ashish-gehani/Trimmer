cd ..
echo "Running Trimmer on default options" >> default_logs
bash reset.sh
./runbench.py --sets="trimmer.set" --trimmer-opts=""  >> default_logs
