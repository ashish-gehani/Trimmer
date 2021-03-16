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
	echo '{"binary": "curl_fin", "native_libs": [], "name": "curl", "args": ["--compress", "--http1.1", "--ipv4", "--ssl", "http://localhost:8070/"], "modules": [], "ldflags": ["-lz", "-lcurl"], "main": "curl.bc"}' > ${curl_MANIFEST} && \
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
	@echo "\t\tTest Curl"
	
	${OUT_DIR}/work_dir/curl_fin_stripped > t_out && \
	curl --compress --http1.1 --ipv4 --ssl http://www.google.com > o_out
	@echo "Output comparison to Baseline:"
	@cmp -s ./t_out o_out; \
	RETVAL=$$?; \
	if [ $$RETVAL -eq 0 ]; then \
		echo "\tcurl test baseline compare? Passed!"; \
	else \
		echo "\tcurl test baseline compare? Failed!"; \
	fi
	#@rm ./o_out
	#@rm ./t_out


		
${OUT_DIR}:
	mkdir -p ${OUT_DIR}

${curl_NAME}:
	tar -xvzf ./${curl_TAR}

clean:
	rm -rf ${curl_NAME}
	rm *.bc
	rm -r ${OUT_DIR}
