cd ..
echo "no-inter-constprop" >> no-inter-constprop_logs
bash reset.sh
./runbench.py --sets="trimmer.set" --trimmer-opts="no-inter-constprop"  >> no-inter-constprop_logs
