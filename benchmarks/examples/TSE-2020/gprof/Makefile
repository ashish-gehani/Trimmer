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

gprof: ${OUT_DIR}
	cp ${GPROF_BITCODE} ${OUT_DIR}
	cd ${OUT_DIR} && \
	echo '{"binary": "gprof_fin", "native_libs":[],"name": "gprof", "args": ["-q","name"], "modules": [], "ldflags": ["-ldl"], "main": "gprof.bc", "config_files": []}' > ${GPROF_MANIFEST} && \
	python ${TRIMMER_HOME}/tool/trimmer.py ${GPROF_MANIFEST} ./gprof  restrictLimit 400 $(option) 2> ${LOG_FILE}

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


.PHONY: ${READELF_BITCODE}
${READELF_BITCODE}: ${READELF_NAME}
	cd ${READELF_NAME} && \
	CC=${BITCODE_WRAPPER} CFLAGS="-DHAVE_CONFIG_H -O0 -fno-inline -fno-inline-functions -Xclang -disable-O0-optnone" ./configure && \
	CC=${BITCODE_WRAPPER} make && \
	cd ${GPROF} && \
	${BITCODE_EXTRACT} ${GPROF} && \
	mv ${GPROF_BITCODE} ../.. 
        
		
${OUT_DIR}:
	mkdir -p ${OUT_DIR}

${READELF_NAME}:
	tar -xvzf ./${READELF_TAR}

base:
	opt -O3 ${GPROF_BITCODE} -o ${GPROF}_opt.bc
	llc -filetype=obj ${GPROF}_opt.bc -o ${GPROF}_opt.o
	clang++ -O3 ${GPROF}_opt.o -ldl -o ${GPROF}_bin 
	strip ${GPROF}_bin -o ${GPROF}_base_stripped

clean:
	-rm -rf ${READELF_NAME}
	-rm *.bc
	-rm -r ${OUT_DIR}
	-rm *_bin *_stripped *.o
