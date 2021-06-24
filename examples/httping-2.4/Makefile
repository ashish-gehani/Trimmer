httping=httping
httping_BITCODE=${httping}.bc
httping_VERSION=2.4
httping_NAME=${httping}-${httping_VERSION}
httping_TAR=${httping_NAME}.tar.gz


httping_MANIFEST=${httping}.manifest

OUT_DIR?=trimmer
LOG_FILE?=logs

BITCODE_WRAPPER=wllvm
BITCODE_EXTRACT=extract-bc

all: ${httping_BITCODE}

compress: ${OUT_DIR}
	cp ${httping_BITCODE} ${OUT_DIR}
	cd ${OUT_DIR} && \
	echo '{"binary": "httping_fin", "native_libs": [], "name": "httping", "args": ["-G",  "-s",  "-X","-b","-B","_"], "modules": [], "ldflags": ["-lm"], "main": "httping.bc", "config_files": []}' > ${httping_MANIFEST} && \
	python ${TRIMMER_HOME}/tool/trimmer.py ${httping_MANIFEST} ./work_dir 2> ${LOG_FILE}

.PHONY: ${httping_BITCODE}
${httping_BITCODE}: ${httping_NAME}
	cd ${httping_NAME} && \
	CC=${BITCODE_WRAPPER} ./configure && \
	sed -i 's/WFLAGS=-Wall -W -Wextra -pedantic -D_FORTIFY_SOURCE=2/WFLAGS=-Xclang -disable-O0-optnone/g' ./Makefile && \
	sed -i 's/DEBUG=yes/DEBUG=no/g' ./Makefile && \
	CC=${BITCODE_WRAPPER} make && \
	${BITCODE_EXTRACT} ${httping} && \
	mv ${httping_BITCODE} ../

test_httping:
	python3 test_httping.py
		
${OUT_DIR}:
	mkdir -p ${OUT_DIR}

${httping_NAME}:
	tar -xvzf ./${httping_TAR}

clean:
	rm -rf ${httping_NAME}
	rm *.bc
	rm -r ${OUT_DIR}
