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

aircrack: ${OUT_DIR}
	cp ${AIRCRACK-NG_BITCODE} ${OUT_DIR} && \
	cp sha1-sse2.S ${OUT_DIR} && \
	cp password.lst ${OUT_DIR} && \
	cp wpa.cap ${OUT_DIR} && \
	cd ${OUT_DIR} && \
	echo '{"binary": "aircrack-ng_fin", "native_libs": [], "name": "aircrack-ng", "args": ["-b", "_","-a","wpa","-s","-w","password.lst","_"], "modules": [], "ldflags": ["-lssl","-lcrypto","-lpthread","sha1-sse2.S"], "main": "aircrack-ng.bc", "config_files": []}' > ${AIRCRACK-NG_MANIFEST} && \
	python ${TRIMMER_HOME}/tool/trimmer.py ${AIRCRACK-NG_MANIFEST} ./aircrack  > ${LOG_FILE} 
	@cp ${OUT_DIR}/password.lst ${OUT_DIR}/aircrack/ && \
	cp ${OUT_DIR}/wpa.cap ${OUT_DIR}/aircrack/ 

CHECK_AIRCRACK:= $(shell cd ${OUT_DIR}/aircrack && ./aircrack-ng_fin_stripped -b 00:0D:93:EB:B0:8C -a wpa -s -w password.lst wpa.cap | grep 'biscotte') 

test_aircrack_crack:
	@echo "\t\tTest Aircrack-ng"
	@echo "Checking if aircrack output valid:"
ifeq ('$(CHECK_AIRCRACK)',)
	@echo "\taircrack test valid? Failed!"
else
	@echo "\taircrack test valid? Passed!"
endif

.PHONY: ${AIRCRACK-NG_BITCODE}
${AIRCRACK-NG_BITCODE}: ${AIRCRACK-NG_NAME}
	cd ${AIRCRACK-NG_NAME} && \
	sed -i 's/CC		= gcc/CC=wllvm/g' ./Makefile && \
	sed -i 's/CC		= gcc/CC=wllvm/g' ./src/Makefile && \
	sed -i 's/-D_FILE_OFFSET_BITS=64 -D_REVISION=0 -Iinclude/-D_FILE_OFFSET_BITS=64 -D_REVISION=0 -Iinclude -Xclang -disable-O0-optnone/g' ./src/Makefile && \
	sed -i 's/$(PIC) -I.. $(LIBAIRPCAP)/$(PIC) -I.. $(LIBAIRPCAP) -Xclang -disable-O0-optnone/g' ./src/osdep/Makefile && \
	CC=${BITCODE_WRAPPER} make && \
	${BITCODE_EXTRACT} src/${AIRCRACK-NG} && \
	mv src/${AIRCRACK-NG_BITCODE} ../ 

${OUT_DIR}:
	mkdir -p ${OUT_DIR}

${AIRCRACK-NG_NAME}:
	tar -xvzf ./${AIRCRACK-NG_TAR}

base:
	opt -O3 ${AIRCRACK-NG_BITCODE} -o ${AIRCRACK-NG}_opt.bc
	llc -filetype=obj ${AIRCRACK-NG}_opt.bc -o ${AIRCRACK-NG}_opt.o
	clang++ -O3 ${AIRCRACK-NG}_opt.o -lssl -lcrypto -lpthread sha1-sse2.S -o ${AIRCRACK-NG}_bin 
	strip ${AIRCRACK-NG}_bin -o ${AIRCRACK-NG}_base_stripped

clean:
	rm -rf ${AIRCRACK-NG_NAME}
	rm *.bc
	rm -r ${OUT_DIR}
	-rm *_bin *_stripped *.o


