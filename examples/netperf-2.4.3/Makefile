NETPERF=netperf
NETPERF_BITCODE=${NETPERF}.bc
NETPERF_VERSION=2.4.3
NETPERF_NAME=${NETPERF}-${NETPERF_VERSION}
NETPERF_TAR=${NETPERF_NAME}.tar.gz

NETPERF_MANIFEST=${NETPERF}.manifest


OUT_DIR?=trimmer
LOG_FILE?=logs

BITCODE_WRAPPER?=wllvm
BITCODE_EXTRACT?=extract-bc
OPT_NAME=opt
CFLAGS = -mem2reg -loops -lcssa -loop-simplify -loop-rotate -indvars


all: ${NETPERF_BITCODE}

netperf: ${OUT_DIR}
	cp ${NETPERF_BITCODE} ${OUT_DIR} && \
	cd ${OUT_DIR} && \
	echo '{"binary": "netperf_fin", "native_libs": [], "name": "netperf", "args": ["-H", "localhost","-t","TCP_RR","-D","5,G","-i","15,1"], "modules": [], "ldflags": ["-lm"], "main": "netperf.bc", "config_files": []}' > ${NETPERF_MANIFEST} && \
	python ${TRIMMER_HOME}/tool/trimmer.py ${NETPERF_MANIFEST} ./work_dir  2> ${LOG_FILE}

.PHONY: ${NETPERF_BITCODE}
${NETPERF_BITCODE}: ${NETPERF_NAME}
	cd ${NETPERF_NAME} && \
	CC=${BITCODE_WRAPPER} CFLAGS="-O0 -Xclang -disable-O0-optnone" ./configure --enable-demo=yes && \
	sed -i 's/CC = gcc//g' ./Makefile && \
	sed -i 's/CC = gcc//g' ./src/Makefile && \
	CC=${BITCODE_WRAPPER} make && \
	${BITCODE_EXTRACT} src/${NETPERF} && \
	${OPT_NAME} ${CFLAGS} src/${NETPERF_BITCODE} -o src/${NETPERF_BITCODE} && \
	mv src/${NETPERF_BITCODE} ../ 
    
		
${OUT_DIR}:
	mkdir -p ${OUT_DIR}

${NETPERF_NAME}:
	tar -xvzf ./${NETPERF_TAR}

clean:
	rm -rf ${NETPERF_NAME}
	rm *.bc
	rm -r ${OUT_DIR}

