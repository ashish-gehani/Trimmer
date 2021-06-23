AIRCRACK-NG=aircrack-ng
AIRTUN-NG=airtun-ng
AIRCRACK-NG_BITCODE=${AIRCRACK-NG}.bc
AIRTUN-NG_BITCODE=${AIRTUN-NG}.bc
AIRCRACK-NG_VERSION=1.1
AIRCRACK-NG_NAME=${AIRCRACK-NG}-${AIRCRACK-NG_VERSION}
AIRCRACK-NG_TAR=${AIRCRACK-NG_NAME}.tar.gz

AIRCRACK-NG_MANIFEST=${AIRCRACK-NG}.manifest
AIRTUN-NG_MANIFEST=${AIRTUN-NG}.manifest

OUT_DIR?=trimmer
LOG_FILE?=logs

BITCODE_WRAPPER=wllvm
BITCODE_EXTRACT=extract-bc


all: ${AIRCRACK-NG_BITCODE}

airtun: ${OUT_DIR}
	cp ${AIRTUN-NG_BITCODE} ${OUT_DIR} && \
	cd ${OUT_DIR} && \
	echo '{"binary": "airtun-ng_fin", "native_libs": [], "name": "airtun-ng", "args": ["-a", "_","-w","_","_"], "modules": [], "ldflags": ["-lssl","-lcrypto"], "main": "airtun-ng.bc", "config_files": []}' > ${AIRTUN-NG_MANIFEST} && \
	python ${TRIMMER_HOME}/tool/trimmer.py ${AIRTUN-NG_MANIFEST} ./airtun  2> ${LOG_FILE}


.PHONY: ${AIRCRACK-NG_BITCODE}
${AIRCRACK-NG_BITCODE}: ${AIRCRACK-NG_NAME}
	cd ${AIRCRACK-NG_NAME} && \
	sed -i 's/CC		= gcc/CC=wllvm/g' ./Makefile && \
	sed -i 's/CC		= gcc/CC=wllvm/g' ./src/Makefile && \
	sed -i 's/-D_FILE_OFFSET_BITS=64 -D_REVISION=0 -Iinclude/-D_FILE_OFFSET_BITS=64 -D_REVISION=0 -Iinclude -Xclang -disable-O0-optnone/g' ./src/Makefile && \
	sed -i 's/$(PIC) -I.. $(LIBAIRPCAP)/$(PIC) -I.. $(LIBAIRPCAP) -Xclang -disable-O0-optnone/g' ./src/osdep/Makefile && \
	CC=${BITCODE_WRAPPER} make && \
	${BITCODE_EXTRACT} src/${AIRTUN-NG} && \
	mv src/${AIRTUN-NG_BITCODE} ../

		
${OUT_DIR}:
	mkdir -p ${OUT_DIR}

${AIRCRACK-NG_NAME}:
	tar -xvzf ./${AIRCRACK-NG_TAR}

base:
	opt -O3 ${AIRTUN-NG_BITCODE} -o ${AIRTUN-NG}_opt.bc
	llc -filetype=obj ${AIRTUN-NG}_opt.bc -o ${AIRTUN-NG}_opt.o
	clang++ -O3 ${AIRTUN-NG}_opt.o -lcrypto -lssl -o ${AIRTUN-NG}_bin 
	strip ${AIRTUN-NG}_bin -o ${AIRTUN-NG}_base_stripped

clean:
	-rm -rf ${AIRCRACK-NG_NAME}
	-rm *.bc
	-rm -r ${OUT_DIR}
	-rm *_bin *_stripped *.o

