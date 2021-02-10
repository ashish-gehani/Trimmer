echo "loop-unroll string-specialize" >> loop_file_2_logs

bash reset.sh
./runbench.py --sets="trimmer.set" --slash-opts="loop-unroll string-specialize"  >> loop_string_2_logs
