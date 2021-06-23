cd ..
echo "file-specialize" >> file-specialize_logs
bash reset.sh
./runbench.py --sets="trimmer.set" --trimmer-opts="file-specialize"  >> file-specialize_logs
