The following steps are used to trace Faraz's run of debloating target applications of the coreutils-9

Pre-requisites: Trimmer and wllvm are successfully installed.

1) Download coreutils-9.0.tar.xz from:
	https://ftp.gnu.org/gnu/coreutils/
	

2) Extract the tar file and enter the coreutils-9.0 directory 
	

3) Now you run the configure file with the following flags
	./configure FORCE_UNSAFE_CONFIGURE=1 CC=wllvm (Note: write export LLVM_COMPILER=clang before this to make wllvm work)
  This will create Makefile in the directory.

4) Inside the Makefile, replace the line " CFLAGS= -g -O2" with:
	CFLAGS = -Xclang -disable-O0-optnone
	
	
5) Run the makefile using "make"
		

6) cd to "src" and generate the bitcode file of the target application using:
	extract-bc <app_name>
        e.g., for rm application, write extract-bc rm
	
	
7) Sample manifest file (for rm with -r flag):
	 {
	    "binary": "rm_fin", 
	    "native_libs": [], 
	    "name": "rm", 
	    "args": ["-r", "_"],
	    "modules": [], 
	    "ldflags": [], 
	    "main": "rm.bc",
	    "config_files": []
 	 }
 	 
 	 
8) Run Trimmer

 python ${TRIMMER_HOME}/tool/trimmer.py [manifest-file] [working-directory]



