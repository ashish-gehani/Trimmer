Running Specialized Binaries
===============

With Static Arguments
------------------

If all the command line arguments for an application are provided in the manifest file (i.e. there are no dynamic arguments) then the specialized binary is run without providing any arguments. For example, bzip2 in the Trimmer benchmarks is specialized with the following arguments: `"args": ["-fkqs", "huffman.c"]` (i.e. compress the file huffman.c). Subsequently, after specialization, bzip2 can be run by simply running: `./bzip2_fin` (where bzip2_fin is the specialized binary). This will compress the file huffman.c.


With Dynamic Arguments
--------------------

If at least one of the command line arguments for an application is kept dynamic in the manifest file, then all the arguments (static+dynamic) are required to be provided when running the specialized binary. For example, httping in the Trimmer benchmarks is specialized with the following arguments:`"args": ["-G","-s","-X","-b","-B","_"]`. The last argument here represents the website to ping and is left to be dynamic in this example. To run the specialized httping on a particular website (let's say google.com), we need to provide all the arguments (i.e. `httping_fin -G -s -X -b -B www.google.com`, where httping_fin is the specialized binary).
