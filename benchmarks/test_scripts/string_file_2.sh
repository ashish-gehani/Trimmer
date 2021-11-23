cd ..
echo "string-specialize file-specialize" >> string_file_2_logs
bash reset.sh
./runbench.py --sets="TSE-2020.set" --trimmer-opts="string-specialize file-specialize"  >> string_file_2_logs
