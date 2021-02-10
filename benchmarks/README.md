Running Trimmer on all applications with runbench script
=======

1) Build Trimmer on your machine

2) clone the Trimmer repository and rename the benchmarks directory to OCCAM-Benchmarks.

3) Run the following commands

```
 1) cp -r OCCAM-Benchmarks /
 2) cd OCCAM-Benchmarks
 3) ./runbench.py --sets="trimmer.set" --slash-opts=""
```


4) Third command would run Trimmer on all applications and print the statistics in a table

5) Finally, run "bash reset.sh" before running the rubench script again. reset.sh deletes old executables and bitcode of applications to allow runbench script to be used again

6) Trimmer can run with different options such as loop-unroll, string-specialize and file-specialize. user can provide these options through --slash-opts. e.g if anyone is only interested in running Trimmer with loop-unroll pass, run this command **./runbench.py --sets="trimmer.set" --slash-opts="loop-unroll"**





Docker
=======

To run the benchmark script in docker,

run the following commands,

```
1) docker pull shoaibshoaib/trimmer:reproduce_all_examples_v2
2) docker run -v `pwd`:/host -it shoaibshoaib/trimmer:reproduce_all_examples_v2
3) ./runbench.py --sets="trimmer.set" --slash-opts=""
```

