THTTPD=thttpd
THTTPD_BITCODE=${THTTPD}.bc
THTTPD_VERSION=2.25b
THTTPD_NAME=${THTTPD}-${THTTPD_VERSION}
THTTPD_TAR=${THTTPD_NAME}.tar.gz
THTTPD_PATCH=thttpd.patch

THTTPD_MANIFEST=${THTTPD}.manifest

OUT_DIR?=trimmer
LOG_FILE?=logs

BITCODE_WRAPPER?=wllvm
BITCODE_EXTRACT?=extract-bc

all: ${THTTPD_BITCODE}

compress: ${OUT_DIR}
	cp ${THTTPD_BITCODE} ${OUT_DIR} && \
	cp ${THTTPD}.conf ${OUT_DIR} && \
	cd ${OUT_DIR} && \
	echo '{"binary": "thttpd_fin", "native_libs": [], "name": "thttpd", "args": ["-C",  "thttpd.conf"], "modules": [], "ldflags": ["-lcrypt"], "main": "thttpd.bc", "config_files": ["thttpd.conf"]}' > ${THTTPD_MANIFEST} && \
	python ${TRIMMER_HOME}/tool/trimmer.py ${THTTPD_MANIFEST} ./work_dir 2> ${LOG_FILE}

.PHONY: ${THTTPD_BITCODE}
${THTTPD_BITCODE}: ${THTTPD_NAME}
	cp ${THTTPD_PATCH} ${THTTPD_NAME} && \
	cd ${THTTPD_NAME} && \
	patch -p0 -f < ./${THTTPD_PATCH} && \
	CC=${BITCODE_WRAPPER} CFLAGS="-O0 -fno-inline -fno-inline-functions -Xclang -disable-O0-optnone" ./configure && \
	CC=${BITCODE_WRAPPER} make && \
	${BITCODE_EXTRACT} ${THTTPD} && \
	mv ${THTTPD_BITCODE} ../
		
${OUT_DIR}:
	mkdir -p ${OUT_DIR}

${THTTPD_NAME}:
	tar -xvzf ./${THTTPD_TAR}

clean:
	rm -rf ${THTTPD_NAME}
	rm *.bc
	rm -r ${OUT_DIR}
