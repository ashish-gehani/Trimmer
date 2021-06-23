Running Trimmer on all applications with runbench script
=======

1) Build Trimmer on your machine

2) Run `./dependencies.sh` to install the dependencies of applications in the trimmer set 

3) Run `./runbench.py --sets="trimmer.set" --trimmer-opts=""`

4) Finally, run `bash reset.sh` before running the rubench script again. reset.sh deletes old executables and bitcode of applications to allow runbench script to be used again


The runbench.py script will run Trimmer on all applications and print the statistics in a table. Trimmer can be run with different options such as loop-unroll, string-specialize and file-specialize. user can provide these options through --trimmer-opts. e.g if anyone is only interested in running Trimmer with loop-unroll pass, run this command **./runbench.py --sets="trimmer.set" --trimmer-opts="loop-unroll"**