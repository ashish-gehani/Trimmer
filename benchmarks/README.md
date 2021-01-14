Running Trimmer on all applications with runbench script
=======

i) Build Trimmer on your machine
ii) Run the following commands
iii) fourth command would run Trimmer on all applications and print the statistics in a table
iv) Finally, run "bash reset.sh" before running the rubench script again. reset.sh deletes old executables and bitcode of applications to allow runbench script to be used again


```
1) cd /
2) git clone https://github.com/shoaibCS/OCCAM-Benchmarks.git -b trimmer_tool
3) cd OCCAM-Benchmarks
4) ./runbench.py --sets="trimmer.set" --slash-opts=""
```





Docker
=======

To run the benchmark script in docker,

run the following commands,

```
1) docker pull shoaibshoaib/trimmer:reproduce_all_examples_v2
2) docker run -v `pwd`:/host -it shoaibshoaib/trimmer:reproduce_all_examples_v2
3) ./runbench.py --sets="trimmer.set" --slash-opts=""
```

