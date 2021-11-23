cd ..
echo "string-specialize" >> string-specialize_logs
bash reset.sh
./runbench.py --sets="TSE-2020.set" --trimmer-opts="string-specialize"  >> string-specialize_logs
