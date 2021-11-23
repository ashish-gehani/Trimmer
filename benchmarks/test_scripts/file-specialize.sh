cd ..
echo "file-specialize" >> file-specialize_logs
bash reset.sh
./runbench.py --sets="TSE-2020.set" --trimmer-opts="file-specialize"  >> file-specialize_logs
