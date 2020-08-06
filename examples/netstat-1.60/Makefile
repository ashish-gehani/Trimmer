NETSTAT=netstat
NETSTAT_BITCODE=${NETSTAT}.bc
NETSTAT_VERSION=1.60
NETSTAT_NAME=${NETSTAT}-${NETSTAT_VERSION}
NETSTAT_TAR=${NETSTAT_NAME}.tar.gz

NETSTAT_MANIFEST=${NETSTAT}.manifest


OUT_DIR?=trimmer
LOG_FILE?=logs

BITCODE_WRAPPER?=wllvm
BITCODE_EXTRACT?=extract-bc
OPT_NAME=opt
CFLAGS = -mem2reg -loops -lcssa -loop-simplify -loop-rotate -indvars


all: ${NETSTAT_BITCODE}

netstat: ${OUT_DIR}
	cp ${NETSTAT_BITCODE} ${OUT_DIR} && \
	cd ${OUT_DIR} && \
	echo '{"binary": "netstat_fin", "native_libs": [], "name": "netstat", "args": ["-a", "-e","-p","-s"], "modules": [], "ldflags": [], "main": "netstat.bc", "config_files": []}' > ${NETSTAT_MANIFEST} && \
	python ${TRIMMER_HOME}/tool/trimmer.py ${NETSTAT_MANIFEST} ./work_dir  2> ${LOG_FILE}

.PHONY: ${NETSTAT_BITCODE}
${NETSTAT_BITCODE}: ${NETSTAT_NAME}
	cd ${NETSTAT_NAME} && \
	sed -i 's/CC	= gcc//g' ./Makefile && \
	CC=${BITCODE_WRAPPER} make && \
	${BITCODE_EXTRACT} ${NETSTAT} && \
	${OPT_NAME} ${CFLAGS} ${NETSTAT_BITCODE} -o ${NETSTAT_BITCODE} && \
	mv ${NETSTAT_BITCODE} ../ 
    
		
${OUT_DIR}:
	mkdir -p ${OUT_DIR}

${NETSTAT_NAME}:
	tar -xvzf ./${NETSTAT_TAR}

clean:
	rm -rf ${NETSTAT_NAME}
	rm *.bc
	rm -r ${OUT_DIR}
