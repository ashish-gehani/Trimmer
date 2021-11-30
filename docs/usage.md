Executing Specialized Binaries
===============

Specialized binaries can be executed by passing the dynamic arguments in order:

`./specialized_binary_name [dynamic_arg_1] [dynamic_arg_2] ...`

For example, [aircrack](/benchmarks/examples/TSE-2020/aircrack/Makefile) in the TSE-2020 benchmarks is specialized with the following arguments:`"args": ["-b", "_","-a","wpa","-s","-w","password.lst","_"]`. The second and the last arguments are dynamic. The specialized binary can be executed for a particular bssid and cap file using `./aircrack_specialized 00:0D:93:EB:B0:8C wpa.cap`, where aircrack_specialized is the specialized binary, 00:0D:93:EB:B0:8C is the bssid (first dynamic argument), and wpa.cap is the cap file (second dynamic argument).

Similarly, for specialized binaries that do not have any dynamic arguments, the binary can be executed without providing any arguments. For example, bzip2 in the TSE-2020 benchmarks is specialized with the following arguments: `"args": ["-fkqs", "huffman.c"]` (i.e. compress the file huffman.c). Subsequently, after specialization, bzip2 can be executed by simply running: `./bzip2_specialized` (where bzip2_fin is the specialized binary). This will compress the file huffman.c.
