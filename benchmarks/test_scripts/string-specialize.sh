cd ..
echo "string-specialize" >> string-specialize_logs
bash reset.sh
./runbench.py --sets="trimmer.set" --trimmer-opts="string-specialize"  >> string-specialize_logs
