cd ..
echo "Running Trimmer on default options" >> default_logs
bash reset.sh
./runbench.py --sets="TSE-2020.set" --trimmer-opts=""  >> default_logs
