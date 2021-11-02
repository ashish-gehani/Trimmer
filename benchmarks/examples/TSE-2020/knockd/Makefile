knockd=knockd
knockd_BITCODE=${knockd}.bc
knockd_VERSION=0.5
knockd_NAME=${knockd}-${knockd_VERSION}
knockd_TAR=${knockd_NAME}.tar.gz


knockd_MANIFEST=${knockd}.manifest

OUT_DIR?=trimmer
LOG_FILE?=logs

BITCODE_WRAPPER?=wllvm
BITCODE_EXTRACT?=extract-bc

all: ${knockd_BITCODE}

compress: ${OUT_DIR}
	cp ${knockd_BITCODE} ${OUT_DIR}
	cd ${OUT_DIR} && \
	echo '{"binary": "knockd_fin", "native_libs": [], "name": "knockd", "args": ["-i","eth0"], "modules": [], "ldflags": ["-lpcap"], "main": "knockd.bc", "config_files": []}' > ${knockd_MANIFEST} && \
	python ${TRIMMER_HOME}/tool/trimmer.py ${knockd_MANIFEST} ./work_dir $(option) 2> ${LOG_FILE}

.PHONY: ${knockd_BITCODE}
${knockd_BITCODE}: ${knockd_NAME}
	cd ${knockd_NAME} && \
	CC=${BITCODE_WRAPPER} CFLAGS="-Xclang -disable-O0-optnone" ./configure && \
	sed -i 's/-g -Wall -pedantic -fno-exceptions/-Wall -pedantic -fno-exceptions -Xclang -disable-O0-optnone/g' ./Makefile && \
	CC=${BITCODE_WRAPPER} make && \
	${BITCODE_EXTRACT} ${knockd} && \
	mv ${knockd_BITCODE} ../
		
${OUT_DIR}:
	mkdir -p ${OUT_DIR}

${knockd_NAME}:
	tar -xvzf ./${knockd_TAR}

base:
	opt -O3 ${knockd_BITCODE} -o ${knockd}_opt.bc
	llc -filetype=obj ${knockd}_opt.bc -o ${knockd}_opt.o
	clang++ -O3 ${knockd}_opt.o -lpcap -o ${knockd}_bin 
	strip ${knockd}_bin -o ${knockd}_base_stripped

clean:
	-rm -rf ${knockd_NAME}
	-rm *.bc
	-rm -r ${OUT_DIR}
	-rm *_bin *_stripped *.o
