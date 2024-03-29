NETSTAT=netstat
NETSTAT_BITCODE=${NETSTAT}.bc
NETSTAT_VERSION=1.60
NETSTAT_NAME=${NETSTAT}-${NETSTAT_VERSION}
NETSTAT_TAR=${NETSTAT_NAME}.tar.gz

NETSTAT_MANIFEST=${NETSTAT}.manifest


OUT_DIR?=trimmer
LOG_FILE?=logs

BITCODE_WRAPPER=wllvm
BITCODE_EXTRACT=extract-bc


all: ${NETSTAT_BITCODE}

netstat: ${OUT_DIR}
	cp ${NETSTAT_BITCODE} ${OUT_DIR} && \
	cd ${OUT_DIR} && \
	echo '{"binary": "netstat_fin", "native_libs": [], "name": "netstat", "args": ["-a", "-e","-p"], "modules": [], "ldflags": [], "main": "netstat.bc", "config_files": []}' > ${NETSTAT_MANIFEST} && \
	python ${TRIMMER_HOME}/tool/trimmer.py ${NETSTAT_MANIFEST} ./work_dir $(option) 2> ${LOG_FILE}

test_netstat:
	@echo "\t\tTest Netstat" && \
	${NETSTAT_NAME}/netstat -a -e -p > o_out && \
	${OUT_DIR}/work_dir/netstat_fin_stripped > t_out
	@echo "Output comparison to Baseline:"
	@cmp -s ./o_out t_out; \
	RETVAL=$$?; \
	if [ $$RETVAL -eq 0 ]; then \
		echo "\tnetstat test baseline compare? Passed!"; \
	else \
		echo "\tnetstat test baseline compare? Failed!"; \
	fi
	@rm o_out
	@rm t_out



.PHONY: ${NETSTAT_BITCODE}
${NETSTAT_BITCODE}: ${NETSTAT_NAME}
	cd ${NETSTAT_NAME} && \
	sed -i 's/CC	= gcc//g' ./Makefile && \
	sed -i 's/COPTS = -D_GNU_SOURCE -Wall/COPTS = -D_GNU_SOURCE -Wall -Xclang -disable-O0-optnone/g' ./Makefile && \
	yes "" | CC=${BITCODE_WRAPPER} make && \
	${BITCODE_EXTRACT} ${NETSTAT} && \
	mv ${NETSTAT_BITCODE} ../ 
    
		
${OUT_DIR}:
	mkdir -p ${OUT_DIR}

${NETSTAT_NAME}:
	tar -xvzf ./${NETSTAT_TAR}

base:
	opt -O3 ${NETSTAT_BITCODE} -o ${NETSTAT}_opt.bc
	llc -filetype=obj ${NETSTAT}_opt.bc -o ${NETSTAT}_opt.o
	clang++ -O3 ${NETSTAT}_opt.o -o ${NETSTAT}_bin 
	strip ${NETSTAT}_bin -o ${NETSTAT}_base_stripped

clean:
	-rm -rf ${NETSTAT_NAME}
	-rm *.bc
	-rm -r ${OUT_DIR}
	-rm *_bin *_stripped *.o
