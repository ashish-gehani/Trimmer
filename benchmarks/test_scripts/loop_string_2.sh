cd ..
echo "loop-unroll string-specialize" >> loop_string_2_logs
bash reset.sh
./runbench.py --sets="trimmer.set" --trimmer-opts="loop-unroll string-specialize"  >> loop_string_2_logs
