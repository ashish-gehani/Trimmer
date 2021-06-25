NETPERF=netperf
NETPERF_BITCODE=${NETPERF}.bc
NETPERF_VERSION=2.4.3
NETPERF_NAME=${NETPERF}-${NETPERF_VERSION}
NETPERF_TAR=${NETPERF_NAME}.tar.gz

NETPERF_MANIFEST=${NETPERF}.manifest
NETPERF_LL=${NETPERF}.ll

OUT_DIR?=trimmer
LOG_FILE?=logs

BITCODE_WRAPPER=wllvm
BITCODE_EXTRACT=extract-bc
BITCODE_DIS=llvm-dis
BITCODE_AS=llvm-as

#FIXME Currently not handling bitcast calls (under progress). Replacing one instance occuring in netperf.


all: ${NETPERF_BITCODE}

netperf: ${OUT_DIR}
	cp ${NETPERF_BITCODE} ${OUT_DIR} && \
	cd ${OUT_DIR} && \
	echo '{"binary": "netperf_fin", "native_libs": [], "name": "netperf", "args": ["-H", "_","-t","TCP_RR", "-v","0"], "modules": [], "ldflags": ["-lm"], "main": "netperf.bc", "config_files": []}' > ${NETPERF_MANIFEST} && \
	python2 ${TRIMMER_HOME}/tool/trimmer.py ${NETPERF_MANIFEST} ./work_dir  2> ${LOG_FILE}

.PHONY: ${NETPERF_BITCODE}
${NETPERF_BITCODE}: ${NETPERF_NAME}
	cd ${NETPERF_NAME} && \
	CC=${BITCODE_WRAPPER} CFLAGS="-O0 -Xclang -disable-O0-optnone" ./configure --enable-demo=yes && \
	sed -i 's/CC = gcc//g' ./Makefile && \
	sed -i 's/CC = gcc//g' ./src/Makefile && \
	CC=${BITCODE_WRAPPER} make && \
	${BITCODE_EXTRACT} src/${NETPERF} && \
	${BITCODE_DIS} src/${NETPERF_BITCODE} && \
	sed -i 's/(...) bitcast (void ()\*/ /g' src/${NETPERF_LL} && \
	sed -i 's/ to void (...)\*)//g' src/${NETPERF_LL} && \
	${BITCODE_AS} src/${NETPERF_LL} && \
	rm src/${NETPERF_LL} && \
	mv src/${NETPERF_BITCODE} ../

test_netperf:
	@echo "\t\tTest netperf"  
	${NETPERF_NAME}/src/netserver && \
	${OUT_DIR}/work_dir/netperf_fin_stripped -H localhost -t TCP_RR > t_out && \
	if grep -q 'TCP REQUEST/RESPONSE TEST' t_out; then \
		echo "\tnetperf test baseline compare? Passed!"; \
	else \
		echo "\tnetperf test baseline compare? Failed!"; \
	fi
	@rm ./t_out

    
		
${OUT_DIR}:
	mkdir -p ${OUT_DIR}

${NETPERF_NAME}:
	tar -xvzf ./${NETPERF_TAR}

clean:
	rm -rf ${NETPERF_NAME}
	rm *.bc
	rm -r ${OUT_DIR}

