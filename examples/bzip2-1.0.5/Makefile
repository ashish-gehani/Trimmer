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
	python ${TRIMMER_HOME}/tool/trimmer.py ${BZIP_MANIFEST} ./work 2> ${LOG_FILE} 

test_compress: 
	@echo "\t\tTest Compress"
	@echo "File Existence Check:"
	@# Testing if compressed file produced
	@cp huffman.c ${OUT_DIR}/work && \
	cd ${OUT_DIR}/work && \
	./bzip2_fin_stripped && \
	test -f huffman.c.bz2 && echo "\tbzip2 test compress file exist? Passed!" || echo "\tbzip2 test compress file exist?  Failed!" 

	@echo "Comparing File Sizes:"
	@# Printing File sizes
	@echo -n "\tSource File Size:\t"
	@stat -L -c %s huffman.c
	@echo -n "\tCompressed File Size:\t"
	@stat -L -c %s ${OUT_DIR}/work/huffman.c.bz2

	@echo "Output comparison to Baseline:"
	@cmp -s ./huffman.c.bz2 ${OUT_DIR}/work/huffman.c.bz2; \
	RETVAL=$$?; \
	if [ $$RETVAL -eq 0 ]; then \
		echo "\tbzip2 test baseline compare? Passed!"; \
	else \
		echo "\tbzip2 test baseline compare? Failed!"; \
	fi



	

	

decompress: ${OUT_DIR} ${BZIP_BITCODE}
	cp ${BZIP_BITCODE} ${OUT_DIR}
	cd ${OUT_DIR} && \
	echo '{"binary": "bzip2_fin", "native_libs": [], "name": "bzip2", "args": ["-fdq", "huffman.c.bz2"], "modules": [], "ldflags": ["-lbz2"], "main": "bzip2.bc", "config_files": []}' > ${BZIP_MANIFEST} && \
	python ${TRIMMER_HOME}/tool/trimmer.py ${BZIP_MANIFEST} ./work 2> ${LOG_FILE}

test_decompress:
	@echo "\t\tTest Decompress"
	@echo "File Existence Check:"
	@# Testing if decompressed file produced
	@cp huffman.c.bz2 ${OUT_DIR}/work && \
	cd ${OUT_DIR}/work && \
	./bzip2_fin_stripped && \
	test -f huffman.c && echo "\tbzip2 test decompress file exist? Passed!" || echo "\tbzip2 test decompress file exist? Failed!" 

	@echo "Comparing File Sizes:"
	@# Printing File sizes
	@echo -n "\tSource File Size:\t"
	@stat -L -c %s huffman.c.bz2
	@echo -n "\tDecompressed File Size:\t"
	@stat -L -c %s ${OUT_DIR}/work/huffman.c

	@echo "Output comparison to Baseline:"
	@cmp -s ./huffman.c ${OUT_DIR}/work/huffman.c; \
	RETVAL=$$?; \
	if [ $$RETVAL -eq 0 ]; then \
		echo "\tbzip2 test baseline compare? Passed!"; \
	else \
		echo "\tbzip2 test baseline compare? Failed!"; \
	fi




${BZIP_BITCODE}: ${BZIP_NAME}
	cd ${BZIP_NAME} && \
	sed -i 's/-O2 -g/ -fno-inline -fno-inline-functions -Xclang -disable-O0-optnone/g' ./Makefile && \
	sed -i 's/CC=gcc/CC?=gcc/g' ./Makefile && \
	CC=${BITCODE_WRAPPER} make && \
	${BITCODE_EXTRACT} ${BZIP} && \
	cp huffman.c ../ && \
	./bzip2 -fkqs huffman.c && \
	mv huffman.c.bz2 ../ && \
	mv ${BZIP_BITCODE} ../
		
${OUT_DIR}:
	mkdir -p ${OUT_DIR}

${BZIP_NAME}:
	tar -xvzf ./${BZIP_TAR}

clean:
	rm -r ${BZIP_NAME}
	rm *.bc
	rm huffman.c
	rm huffman.c.bz2
	rm -r ${OUT_DIR}
