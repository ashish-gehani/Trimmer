TOTD=totd
TOTD_BITCODE=${TOTD}.bc
TOTD_VERSION=1.5.3
TOTD_NAME=${TOTD}-${TOTD_VERSION}
TOTD_TAR=${TOTD_NAME}.tar.gz

TOTD_MANIFEST=${TOTD}.manifest
TOTD_CONF1=./totdipv6.conf
TOTD_CONF2=./totdipv4.conf

OUT_DIR?=trimmer
LOG_FILE?=logs

BITCODE_WRAPPER?=wllvm
BITCODE_EXTRACT?=extract-bc

all: ${TOTD_BITCODE}

ipv6: ${OUT_DIR} ${TOTD_BITCODE}
	cp ${TOTD_BITCODE} ${OUT_DIR} 
	cp ${TOTD_CONF1} ${OUT_DIR}
	cd ${OUT_DIR} && \echo '{"binary": "totd_fin", "native_libs": [], "name": "totd", "args": ["-c", "totdipv6.conf", "-d2"],"modules": [], "ldflags": [], "main": "totd.bc","config_files":["totdipv6.conf"]}' > ${TOTD_MANIFEST} && \
	python ${TRIMMER_HOME}/tool/trimmer.py ${TOTD_MANIFEST} ./workdir $(option) 2> ${LOG_FILE}

ipv4: ${OUT_DIR} ${TOTD_BITCODE}
	cp ${TOTD_BITCODE} ${OUT_DIR} 
	cp ${TOTD_CONF2} ${OUT_DIR}
	cd ${OUT_DIR} && \echo '{"binary": "totd_fin", "native_libs": [], "name": "totd", "args": ["-c", "totdipv4.conf", "-d2", "-no6"],"modules": [], "ldflags": [], "main": "totd.bc","config_files":["totdipv4.conf"]}' > ${TOTD_MANIFEST} && \
	python ${TRIMMER_HOME}/tool/trimmer.py ${TOTD_MANIFEST} ./workdir $(option) 2> ${LOG_FILE}

${TOTD_BITCODE}: ${TOTD_NAME}
	cd ${TOTD_NAME} && \
	sed -i 's/-g -O2/ -Xclang -disable-O0-optnone/g' ./Makefile && \
	sed -i 's/CC = gcc/CC? = gcc/g' ./Makefile && \
	CC=${BITCODE_WRAPPER} make && \
	${BITCODE_EXTRACT} ${TOTD} && \
	mv ${TOTD_BITCODE} ../
	
test_totd:
	python3 test_totd.py
${OUT_DIR}:
	mkdir -p ${OUT_DIR}

${TOTD_NAME}:
	tar -xvzf ./${TOTD_TAR}

base:
	opt -O3 ${TOTD_BITCODE} -o ${TOTD}_opt.bc
	llc -filetype=obj ${TOTD}_opt.bc -o ${TOTD}_opt.o
	clang++ -O3 ${TOTD}_opt.o -o ${TOTD}_bin 
	strip ${TOTD}_bin -o ${TOTD}_base_stripped

clean:
	-rm -r ${TOTD_NAME}
	-rm *.bc
	-rm -r ${OUT_DIR}
	-rm *_bin *_stripped *.o
