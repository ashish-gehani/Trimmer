GZIP=gzip
GZIP_BITCODE=${GZIP}.bc
GZIP_VERSION=1.3.12
GZIP_NAME=${GZIP}-${GZIP_VERSION}
GZIP_TAR=${GZIP_NAME}.tar.gz
GZIP_PATCH=gzip.patch

GZIP_MANIFEST=${GZIP}.manifest

OUT_DIR?=trimmer
LOG_FILE?=logs

BITCODE_WRAPPER?=wllvm
BITCODE_EXTRACT?=extract-bc

all: ${GZIP_BITCODE}

compress: ${OUT_DIR}
	cp ${GZIP_BITCODE} ${OUT_DIR}
	cd ${OUT_DIR} && \
	echo '{"binary": "gzip_fin", "native_libs": [], "name": "gzip", "args": ["--force",  "--quiet",  "huffman.c"], "modules": [], "ldflags": ["-lbz2"], "main": "gzip.bc", "config_files": []}' > ${GZIP_MANIFEST} && \
	python ${TRIMMER_HOME}/tool/trimmer.py ${GZIP_MANIFEST} ./work_dir 2> ${LOG_FILE}
	cp huffman.c ${OUT_DIR}/work_dir


test_compress: 
	@# Testing if compressed file produced
	@cp huffman.c ${OUT_DIR}/work_dir && \
	cd ${OUT_DIR}/work_dir && \
	./gzip_fin_stripped && \
	test -f huffman.c.gz && echo "gzip test compress passed!" || echo "gzip test compress failed!" 

	@# Printing File sizes
	@echo -n "Source File Size:\t"
	@stat -L -c %s huffman.c
	@echo -n "Compressed File Size:\t"
	@stat -L -c %s ${OUT_DIR}/work_dir/huffman.c.gz



.PHONY: ${GZIP_BITCODE}
${GZIP_BITCODE}: ${GZIP_NAME}
	cp ${GZIP_PATCH} ${GZIP_NAME} && \
	cd ${GZIP_NAME} && \
	patch -p0 -f -R -i ./${GZIP_PATCH} && \
	CC=${BITCODE_WRAPPER} CFLAGS="-DHAVE_CONFIG_H -DVERSION="\"1.17\"" -Xclang -disable-O0-optnone" ./configure && \
	CC=${BITCODE_WRAPPER} make && \
	${BITCODE_EXTRACT} ${GZIP} && \
	mv ${GZIP_BITCODE} ../
		
${OUT_DIR}:
	mkdir -p ${OUT_DIR}

${GZIP_NAME}:
	tar -xvzf ./${GZIP_TAR}

clean:
	rm -rf ${GZIP_NAME}
	rm *.bc
	rm -r ${OUT_DIR}
