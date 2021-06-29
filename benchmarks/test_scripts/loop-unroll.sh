cd ..
echo "loop-unroll" >> loop-unroll_logs
bash reset.sh
./runbench.py --sets="trimmer.set" --trimmer-opts="loop-unroll"  >> loop-unroll_logs
