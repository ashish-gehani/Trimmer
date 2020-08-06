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

BITCODE_WRAPPER?=wllvm
BITCODE_EXTRACT?=extract-bc
OPT_NAME=opt
CFLAGS = -mem2reg -loops -lcssa -loop-simplify -loop-rotate -indvars


all: ${AIRCRACK-NG_BITCODE}

aircrack: ${OUT_DIR}
	cp ${AIRCRACK-NG_BITCODE} ${OUT_DIR} && \
	cp sha1-sse2.S ${OUT_DIR} && \
	cd ${OUT_DIR} && \
	echo '{"binary": "aircrack-ng_fin", "native_libs": [], "name": "aircrack-ng", "args": ["-b", "00:0c:29:52:aa:56","-a","wpa","-s","-w","dictionary.lst","chargen-tcp.pcap"], "modules": [], "ldflags": ["-lssl","-lcrypto","-lpthread","sha1-sse2.S"], "main": "aircrack-ng.bc", "config_files": []}' > ${AIRCRACK-NG_MANIFEST} && \
	python ${TRIMMER_HOME}/tool/trimmer.py ${AIRCRACK-NG_MANIFEST} ./aircrack  2> ${LOG_FILE}

aircrack_crack: ${OUT_DIR}
	cp ${AIRCRACK-NG_BITCODE} ${OUT_DIR} && \
	cp sha1-sse2.S ${OUT_DIR} && \
	cp password.lst ${OUT_DIR} && \
	cp wpa.cap ${OUT_DIR} && \
	cd ${OUT_DIR} && \
	echo '{"binary": "aircrack-ng_fin", "native_libs": [], "name": "aircrack-ng", "args": ["-w", "password.lst","wpa.cap"], "modules": [], "ldflags": ["-lssl","-lcrypto","-lpthread","sha1-sse2.S"], "main": "aircrack-ng.bc", "config_files": []}' > ${AIRCRACK-NG_MANIFEST} && \
	python ${TRIMMER_HOME}/tool/trimmer.py ${AIRCRACK-NG_MANIFEST} ./aircrack  2> ${LOG_FILE}



airtun: ${OUT_DIR}
	cp ${AIRTUN-NG_BITCODE} ${OUT_DIR} && \
	cd ${OUT_DIR} && \
	echo '{"binary": "airtun-ng_fin", "native_libs": [], "name": "airtun-ng", "args": ["-a", "00:0c:29:52:aa:56","-w","1234567890","eth0"], "modules": [], "ldflags": ["-lssl","-lcrypto"], "main": "airtun-ng.bc", "config_files": []}' > ${AIRTUN-NG_MANIFEST} && \
	python ${TRIMMER_HOME}/tool/trimmer.py ${AIRTUN-NG_MANIFEST} ./airtun  2> ${LOG_FILE}

.PHONY: ${AIRCRACK-NG_BITCODE}
${AIRCRACK-NG_BITCODE}: ${AIRCRACK-NG_NAME}
	cd ${AIRCRACK-NG_NAME} && \
	sed -i 's/CC		= gcc/CC=wllvm/g' ./Makefile && \
	sed -i 's/CC		= gcc/CC=wllvm/g' ./src/Makefile && \
	sed -i 's/-D_FILE_OFFSET_BITS=64 -D_REVISION=0 -Iinclude/-D_FILE_OFFSET_BITS=64 -D_REVISION=0 -Iinclude -Xclang -disable-O0-optnone/g' ./src/Makefile && \
	CC=${BITCODE_WRAPPER} make && \
	${BITCODE_EXTRACT} src/${AIRCRACK-NG} && \
	${OPT_NAME} ${CFLAGS} src/${AIRCRACK-NG_BITCODE} -o src/${AIRCRACK-NG_BITCODE} && \
	mv src/${AIRCRACK-NG_BITCODE} ../ && \
    ${BITCODE_EXTRACT} src/${AIRTUN-NG} && \
	${OPT_NAME} ${CFLAGS} src/${AIRTUN-NG_BITCODE} -o src/${AIRTUN-NG_BITCODE} && \
	mv src/${AIRTUN-NG_BITCODE} ../

		
${OUT_DIR}:
	mkdir -p ${OUT_DIR}

${AIRCRACK-NG_NAME}:
	tar -xvzf ./${AIRCRACK-NG_TAR}

clean:
	rm -rf ${AIRCRACK-NG_NAME}
	rm *.bc
	rm -r ${OUT_DIR}

