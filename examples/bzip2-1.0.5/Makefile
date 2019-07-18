BZIP=bzip2
BZIP_BITCODE=${BZIP}.bc
BZIP_VERSION=1.0.5
BZIP_NAME=${BZIP}-${BZIP_VERSION}
BZIP_TAR=${BZIP_NAME}.tar.gz

BZIP_MANIFEST=${BZIP}.manifest

OUT_DIR?=trimmer
LOG_FILE?=logs

BITCODE_WRAPPER?=wllvm
BITCODE_EXTRACT?=extract-bc

all: ${BZIP_BITCODE}

compress: ${OUT_DIR} ${BZIP_BITCODE}
	cp ${BZIP_BITCODE} ${OUT_DIR}
	cd ${OUT_DIR} && \
	echo '{"binary": "bzip2_fin", "native_libs": [], "name": "bzip2", "args": ["-fkqs", "huffman.c"], "modules": [], "ldflags": ["-lbz2"], "main": "bzip2.bc", "config_files": []}' > ${BZIP_MANIFEST} && \
	python ${TRIMMER_HOME}/tool/trimmer.py ${BZIP_MANIFEST} ./ 2> ${LOG_FILE}


decompress: ${OUT_DIR} ${BZIP_BITCODE}
	cp ${BZIP_BITCODE} ${OUT_DIR}
	cd ${OUT_DIR} && \
	echo '{"binary": "bzip2_fin", "native_libs": [], "name": "bzip2", "args": ["-fdq", "huffman.c.bz2"], "modules": [], "ldflags": ["-lbz2"], "main": "bzip2.bc", "config_files": []}' > ${BZIP_MANIFEST} && \
	python ${TRIMMER_HOME}/tool/trimmer.py ${BZIP_MANIFEST} ./ 2> ${LOG_FILE}

${BZIP_BITCODE}: ${BZIP_NAME}
	cd ${BZIP_NAME} && \
	sed -i 's/-O2 -g/ -fno-inline -fno-inline-functions/g' ./Makefile && \
	sed -i 's/CC=gcc/CC?=gcc/g' ./Makefile && \
	CC=${BITCODE_WRAPPER} make && \
	${BITCODE_EXTRACT} ${BZIP} && \
	mv ${BZIP_BITCODE} ../
		
${OUT_DIR}:
	mkdir -p ${OUT_DIR}

${BZIP_NAME}:
	tar -xvzf ./${BZIP_TAR}

clean:
	rm -r ${BZIP_NAME}
	rm *.bc
	rm -r ${OUT_DIR}
