BZIP=bzip2
LIB_BZ2_BITCODE=libbz2.a.bc
BZIP_VERSION=1.0.5
BZIP_NAME=${BZIP}-${BZIP_VERSION}
BZIP_TAR=${BZIP_NAME}.tar.gz

BZIP_MANIFEST=${BZIP}.manifest

HELPER_SCRIPT=./build.sh
HELPER_TAR=helper_scripts_and_files.tar.gz


OUT_DIR?=slash
LOG_FILE?=logs

BITCODE_WRAPPER?=gclang
BITCODE_EXTRACT?=get-bc

all: ${LIB_BZ2_BITCODE}

${LIB_BZ2_BITCODE}: ${BZIP_NAME} 
	cd ${BZIP_NAME} && \
	sed -i 's/-O2 -g/ -fno-inline -fno-inline-functions -Xclang -disable-O0-optnone/g' ./Makefile && \
	sed -i 's/CC=gcc/CC?=gcc/g' ./Makefile && \
	CC=${BITCODE_WRAPPER} make && \
	${BITCODE_EXTRACT} -b libbz2.a && \
	cp huffman.c ../ && \
	./bzip2 -fkqs huffman.c && \
	mv huffman.c.bz2 ../huffman_unspecialized.c.bz2 && \
	mv libbz2.a.bc ../
		
${OUT_DIR}:
	mkdir -p ${OUT_DIR}

${BZIP_NAME}:
	wget https://sourceware.org/pub/bzip2/bzip2-1.0.5.tar.gz
	tar -xvzf ./${BZIP_TAR}

${HELPER_SCRIPT}:
	tar -xvf ./${HELPER_TAR}

clean:
	rm -rf ${BZIP_NAME} ${BZIP_TAR} bzip2
	rm -rf *.bc *slash* *manifest *fin*
	rm -rf huffman_unspecialized.c.bz2 huffman.c libbz2.a.bc
	rm -rf ${OUT_DIR}
