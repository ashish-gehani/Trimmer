DNSPROXY=dnsproxy
DNSPROXY_BITCODE=${DNSPROXY}.bc
DNSPROXY_VERSION=1.17
DNSPROXY_NAME=${DNSPROXY}-${DNSPROXY_VERSION}
DNSPROXY_TAR=${DNSPROXY_NAME}.tar.gz

DNSPROXY_MANIFEST=${DNSPROXY}.manifest
DNSPROXY_CONF=./dnsproxy.conf


OUT_DIR?=trimmer
LOG_FILE?=logs

BITCODE_WRAPPER?=wllvm
BITCODE_EXTRACT?=extract-bc

all: ${DNSPROXY_BITCODE}

dns: ${OUT_DIR} ${DNSPROXY_BITCODE}
	cp ${DNSPROXY_BITCODE} ${OUT_DIR} 
	cp ${DNSPROXY_CONF} ${OUT_DIR}
	cd ${OUT_DIR} && \echo '{"binary": "dnsproxy_fin", "native_libs": [], "name": "dnsproxy", "args": ["-c", "dnsproxy.conf"], "modules": [], "ldflags": ["-levent"], "main": "dnsproxy.bc", "config_files": ["dnsproxy.conf"]}' > ${DNSPROXY_MANIFEST} && \
	python ${TRIMMER_HOME}/tool/trimmer.py ${DNSPROXY_MANIFEST} ./ 2> ${LOG_FILE}


${DNSPROXY_BITCODE}: ${DNSPROXY_NAME}
	cd ${DNSPROXY_NAME} && \
	CC=${BITCODE_WRAPPER} CFLAGS="-DHAVE_CONFIG_H -DVERSION="\"1.17\"" -Xclang -disable-O0-optnone" ./configure && \
	CC=${BITCODE_WRAPPER} make && \
	${BITCODE_EXTRACT} ${DNSPROXY} && \
	mv ${DNSPROXY_BITCODE} ../
		
${OUT_DIR}:
	mkdir -p ${OUT_DIR}

${DNSPROXY_NAME}:
	tar -xvzf ./${DNSPROXY_TAR}

clean:
	rm -r ${DNSPROXY_NAME}
	rm *.bc
	rm -r ${OUT_DIR}
