echo "Default" >> logs
bash reset.sh

./runbench.py --sets="trimmer.set" --slash-opts=""  >> logs

echo "loop-unroll" >>logs
bash reset.sh

./runbench.py --sets="trimmer.set" --slash-opts="loop-unroll"  >> logs


echo "file-specialize" >>logs
bash reset.sh

./runbench.py --sets="trimmer.set" --slash-opts="file-specialize"  >> logs


echo "string-specialize" >>logs
bash reset.sh

./runbench.py --sets="trimmer.set" --slash-opts="string-specialize"  >> logs


echo "loop-unroll file-specialize" >> logs
bash reset.sh

./runbench.py --sets="trimmer.set" --slash-opts="loop-unroll file-specialize"  >> logs

echo "loop-unroll string-specialize" >> logs
bash reset.sh

./runbench.py --sets="trimmer.set" --slash-opts="loop-unroll string-specialize"  >> logs

echo "string-specialize file-specialize" >> logs
bash reset.sh

./runbench.py --sets="trimmer.set" --slash-opts="string-specialize file-specialize"  >> logs





