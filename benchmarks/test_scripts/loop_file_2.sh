cd ..
echo "loop-unroll file-specialize" >> loop_file_2_logs
bash reset.sh
./runbench.py --sets="TSE-2020.set" --trimmer-opts="loop-unroll file-specialize"  >> loop_file_2_logs
