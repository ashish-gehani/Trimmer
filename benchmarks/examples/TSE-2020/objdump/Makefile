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

objdump: ${OUT_DIR}
	cp ${OBJDUMP_BITCODE} ${OUT_DIR}
	cd ${OUT_DIR} && \
	echo '{"binary": "objdump_fin", "native_libs": [], "name": "objdump", "args": ["-D","--syms","-s","-w","name"], "modules": [], "ldflags": ["-ldl"], "main": "objdump.bc", "config_files": []}' > ${OBJDUMP_MANIFEST} && \
	python ${TRIMMER_HOME}/tool/trimmer.py ${OBJDUMP_MANIFEST} ./objdump  exceedLimit 200 $(option) 2> ${LOG_FILE}

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
	${BITCODE_EXTRACT} ${OBJDUMP} && \
	mv ${OBJDUMP_BITCODE} ../..
		
${OUT_DIR}:
	mkdir -p ${OUT_DIR}

${READELF_NAME}:
	tar -xvzf ./${READELF_TAR}

base:
	opt -O3 ${OBJDUMP_BITCODE} -o ${OBJDUMP}_opt.bc
	llc -filetype=obj ${OBJDUMP}_opt.bc -o ${OBJDUMP}_opt.o
	clang++ -O3 ${OBJDUMP}_opt.o -ldl -o ${OBJDUMP}_bin 
	strip ${OBJDUMP}_bin -o ${OBJDUMP}_base_stripped

clean:
	-rm -rf ${READELF_NAME}
	-rm *.bc
	-rm -r ${OUT_DIR}
	-rm *_bin *_stripped *.o
