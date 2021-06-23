curl=curl
curl_BITCODE=${curl}.bc
curl_VERSION=7.47.0
curl_NAME=${curl}-${curl_VERSION}
curl_TAR=${curl_NAME}.tar.gz


curl_MANIFEST=${curl}.manifest

OUT_DIR?=trimmer
LOG_FILE?=logs

BITCODE_WRAPPER=wllvm
BITCODE_EXTRACT=extract-bc

all: ${curl_BITCODE}

compress: ${OUT_DIR}
	cp ${curl_BITCODE} ${OUT_DIR}
	cd ${OUT_DIR} && \
	echo '{"binary": "curl_fin", "native_libs": [], "name": "curl", "args": ["--compress", "--http1.1", "--ipv4", "--ssl", "_"], "modules": [], "ldflags": ["-lz", "-lcurl"], "main": "curl.bc"}' > ${curl_MANIFEST} && \
	python ${TRIMMER_HOME}/tool/trimmer.py ${curl_MANIFEST} ./work_dir 2> ${LOG_FILE}

.PHONY: ${curl_BITCODE}
${curl_BITCODE}: ${curl_NAME}
	cd ${curl_NAME} && \
	CC=${BITCODE_WRAPPER} CFLAGS=" -Xclang -disable-O0-optnone" ./configure && \
	sed -i 's/CFLAGS = -Xclang -disable-O0-optnone -Qunused-arguments -Os/CFLAGS = -Xclang -disable-O0-optnone/g' src/Makefile && \
	CC=${BITCODE_WRAPPER} make && \
        sudo make install && \
	sudo cp /usr/local/bin/curl  ../ && \
        sudo chmod 777 ../${curl} && \
        ${BITCODE_EXTRACT} ../${curl}

test_curl:
	python3 test_curl.py


		
${OUT_DIR}:
	mkdir -p ${OUT_DIR}

${curl_NAME}:
	tar -xvzf ./${curl_TAR}

base:
	opt -O3 ${curl_BITCODE} -o ${curl}_opt.bc
	llc -filetype=obj ${curl}_opt.bc -o ${curl}_opt.o
	clang++ -O3 ${curl}_opt.o -lcurl -lz -o ${curl}_bin 
	strip ${curl}_bin -o ${curl}_base_stripped

clean:
	-rm -rf ${curl_NAME}
	-rm *.bc
	-rm -r ${OUT_DIR}
	-rm *_bin *_stripped *.o
	-rm ${curl}
