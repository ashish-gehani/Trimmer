SANS=sans
SANS_BITCODE=${SANS}.bc
SANS_NAME=${SANS}
SANS_TAR=${SANS_NAME}.tar.gz

SANS_MANIFEST=${SANS}.manifest

OUT_DIR?=trimmer
LOG_FILE?=logs

BITCODE_WRAPPER?=wllvm
BITCODE_EXTRACT?=extract-bc

all: ${SANS_BITCODE}

udp: ${OUT_DIR}
	cp ${SANS_BITCODE} ${OUT_DIR} && \
	cp sans.conf ${OUT_DIR} && \
	cd ${OUT_DIR} && \
	echo '{"binary": "sans_fin",  "native_libs": [], "name": "sans", "args": ["-c", "sans.conf"], "modules": [], "ldflags": [], "main": "sans.bc", "config_files":["sans.conf"] }' > ${SANS_MANIFEST} && \
	python ${TRIMMER_HOME}/tool/trimmer.py ${SANS_MANIFEST} ./ 2> ${LOG_FILE}

socks5: ${OUT_DIR}
	cp ${SANS_BITCODE} ${OUT_DIR} && \
	cp sans2.conf ${OUT_DIR} && \
	cd ${OUT_DIR} && \
	echo '{"binary": "sans_fin",  "native_libs": [], "name": "sans", "args": ["-c", "sans2.conf"], "modules": [], "ldflags": [], "main": "sans.bc", "config_files":["sans2.conf"] }' > ${SANS_MANIFEST} && \
	python ${TRIMMER_HOME}/tool/trimmer.py ${SANS_MANIFEST} ./ 2> ${LOG_FILE}

tcp: ${OUT_DIR}
	cp ${SANS_BITCODE} ${OUT_DIR} && \
	cp sanss.conf ${OUT_DIR} && \
	cd ${OUT_DIR} && \
	echo '{"binary": "sans_fin",  "native_libs": [], "name": "sans", "args": ["-c", "sanss.conf"], "modules": [], "ldflags": [], "main": "sans.bc", "config_files":["sanss.conf"] }' > ${SANS_MANIFEST} && \
	python ${TRIMMER_HOME}/tool/trimmer.py ${SANS_MANIFEST} ./ 2> ${LOG_FILE}


.PHONY: ${SANS_BITCODE}
${SANS_BITCODE}: ${SANS_NAME}
	cd ${SANS_NAME} && \
	CC=${BITCODE_WRAPPER} CFLAGS="-O0 -fno-inline -fno-inline-functions" ./configure && \
	CC=${BITCODE_WRAPPER} make && \
	cd src/ && \
	${BITCODE_EXTRACT} ${SANS} && \
	mv ${SANS_BITCODE} ../../
		
${OUT_DIR}:
	mkdir -p ${OUT_DIR}

${SANS_NAME}:
	tar -xvzf ./${SANS_TAR}

clean:
	rm -rf ${SANS_NAME}
	rm *.bc
	rm -r ${OUT_DIR}
