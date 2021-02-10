echo "string-specialize file-specialize" >> string_file_2_logs

bash reset.sh
./runbench.py --sets="trimmer.set" --slash-opts="string-specialize file-specialize"  >> string_file_2_logs
