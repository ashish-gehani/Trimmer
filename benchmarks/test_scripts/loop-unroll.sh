cd ..
echo "loop-unroll" >> loop-unroll_logs
bash reset.sh
./runbench.py --sets="TSE-2020.set" --trimmer-opts="loop-unroll"  >> loop-unroll_logs
