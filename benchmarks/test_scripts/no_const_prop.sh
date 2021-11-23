cd ..
echo "no-inter-constprop" >> no-inter-constprop_logs
bash reset.sh
./runbench.py --sets="TSE-2020.set" --trimmer-opts="no-inter-constprop"  >> no-inter-constprop_logs
