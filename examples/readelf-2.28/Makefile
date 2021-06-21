BINUTILS=binutils
READELF=readelf
READELF_BITCODE=${READELF}.bc
READELF_VERSION=2.28
READELF_NAME=${BINUTILS}-${READELF_VERSION}
READELF_TAR=${READELF_NAME}.tar.gz

OBJDUMP=objdump
OBJDUMP_BITCODE=${OBJDUMP}.bc
GPROF=gprof
GPROF_BITCODE=${GPROF}.bc



READELF_MANIFEST=${READELF}.manifest
OBJDUMP_MANIFEST=${OBJDUMP}.manifest
GPROF_MANIFEST=${GPROF}.manifest


OUT_DIR?=trimmer
LOG_FILE?=logs

BITCODE_WRAPPER?=wllvm
BITCODE_EXTRACT?=extract-bc


all: ${READELF_BITCODE}

readelf: ${OUT_DIR}
	cp ${READELF_BITCODE} ${OUT_DIR}
	cd ${OUT_DIR} && \
	echo '{"binary": "readelf_fin", "native_libs": [], "name": "readelf", "args": ["-a", "name"], "modules": [], "ldflags": ["-lz","-ldl"], "main": "readelf.bc", "config_files": []}' > ${READELF_MANIFEST} && \
	python ${TRIMMER_HOME}/tool/trimmer.py ${READELF_MANIFEST} ./work_dir 2> ${LOG_FILE}

test_readelf:
	@echo "\t\tTest Readelf"

	${OUT_DIR}/work_dir/readelf_fin_stripped > t_out && \
	${READELF_NAME}/${BINUTILS}/${READELF} -a ./name > o_out
	@echo "Output comparison to Baseline:"
	@cmp -s ./t_out o_out; \
	RETVAL=$$?; \
	if [ $$RETVAL -eq 0 ]; then \
		echo "\treadelf test baseline compare? Passed!"; \
	else \
		echo "\treadelf test baseline compare? Failed!"; \
	fi
	@rm ./o_out
	@rm ./t_out






gprof: ${OUT_DIR}
	cp ${GPROF_BITCODE} ${OUT_DIR}
	cd ${OUT_DIR} && \
	echo '{"binary": "gprof_fin", "native_libs":[],"name": "gprof", "args": ["-q", "name"], "modules": [], "ldflags": [], "main": "gprof.bc", "config_files": []}' > ${GPROF_MANIFEST} && \
	python ${TRIMMER_HOME}/tool/trimmer.py ${GPROF_MANIFEST} ./gprof  exceedLimit 400 2> ${LOG_FILE}

test_gprof:
	@echo "\t\tTest gprof"
	
	${OUT_DIR}/gprof/gprof_fin_stripped > t_out && \
	${READELF_NAME}/${GPROF}/${GPROF} -q name > o_out
	@echo "Output comparison to Baseline:"
	@cmp -s ./t_out o_out; \
	RETVAL=$$?; \
	if [ $$RETVAL -eq 0 ]; then \
		echo "\tgprof test baseline compare? Passed!"; \
	else \
		echo "\tgprof test baseline compare? Failed!"; \
	fi
	@rm ./o_out
	@rm ./t_out




objdump: ${OUT_DIR}
	cp ${OBJDUMP_BITCODE} ${OUT_DIR}
	cd ${OUT_DIR} && \
	echo '{"binary": "objdump_fin", "native_libs": [], "name": "objdump", "args": ["-D","--syms","-s","-w","name"], "modules": [], "ldflags": ["-ldl"], "main": "objdump.bc", "config_files": []}' > ${OBJDUMP_MANIFEST} && \
	python ${TRIMMER_HOME}/tool/trimmer.py ${OBJDUMP_MANIFEST} ./objdump  exceedLimit 200 2> ${LOG_FILE}

test_objdump:
	@echo "\t\tTest Objdump"
	
	${OUT_DIR}/objdump/objdump_fin_stripped > t_out && \
	${READELF_NAME}/${BINUTILS}/${OBJDUMP} -D --syms -s -w name > o_out
	@echo "Output comparison to Baseline:"
	@cmp -s ./t_out o_out; \
	RETVAL=$$?; \
	if [ $$RETVAL -eq 0 ]; then \
		echo "\tobjdump test baseline compare? Passed!"; \
	else \
		echo "\tobjdump test baseline compare? Failed!"; \
	fi
	@rm ./o_out
	@rm ./t_out




.PHONY: ${READELF_BITCODE}
${READELF_BITCODE}: ${READELF_NAME}
	cd ${READELF_NAME} && \
	CC=${BITCODE_WRAPPER} CFLAGS="-DHAVE_CONFIG_H -O0 -fno-inline -fno-inline-functions -Xclang -disable-O0-optnone" ./configure && \
	CC=${BITCODE_WRAPPER} make && \
	cd ${BINUTILS} && \
	${BITCODE_EXTRACT} ${READELF} && \
	mv ${READELF_BITCODE} ../.. && \
	${BITCODE_EXTRACT} ${OBJDUMP} && \
	mv ${OBJDUMP_BITCODE} ../.. && \
        cd ../${GPROF} && \
	${BITCODE_EXTRACT} ${GPROF} && \
	mv ${GPROF_BITCODE} ../.. 
        
		
${OUT_DIR}:
	mkdir -p ${OUT_DIR}

${READELF_NAME}:
	tar -xvzf ./${READELF_TAR}

clean:
	rm -rf ${READELF_NAME}
	rm *.bc
	rm -r ${OUT_DIR}
