cd ..
echo "Running Trimmer on all options" >> logs

echo "Default" >> logs
bash reset.sh

./runbench.py --sets="trimmer.set" --trimmer-opts=""  >> logs

echo "loop-unroll" >>logs
bash reset.sh

./runbench.py --sets="trimmer.set" --trimmer-opts="loop-unroll"  >> logs


echo "file-specialize" >>logs
bash reset.sh

./runbench.py --sets="trimmer.set" --trimmer-opts="file-specialize"  >> logs


echo "string-specialize" >>logs
bash reset.sh

./runbench.py --sets="trimmer.set" --trimmer-opts="string-specialize"  >> logs


echo "loop-unroll file-specialize" >> logs
bash reset.sh

./runbench.py --sets="trimmer.set" --trimmer-opts="loop-unroll file-specialize"  >> logs

echo "loop-unroll string-specialize" >> logs
bash reset.sh

./runbench.py --sets="trimmer.set" --trimmer-opts="loop-unroll string-specialize"  >> logs

echo "string-specialize file-specialize" >> logs
bash reset.sh

./runbench.py --sets="trimmer.set" --trimmer-opts="string-specialize file-specialize"  >> logs





