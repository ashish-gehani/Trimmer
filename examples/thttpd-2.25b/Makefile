THTTPD=thttpd
THTTPD_BITCODE=${THTTPD}.bc
THTTPD_VERSION=2.25b
THTTPD_NAME=${THTTPD}-${THTTPD_VERSION}
THTTPD_TAR=${THTTPD_NAME}.tar.gz
THTTPD_PATCH=thttpd.patch
THTTPD_CONF=./thttpd.conf
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

test_thttpd:
	@echo "\t\tTesting Thttpd"
	@cp ${THTTPD_CONF} ${THTTPD_NAME}
	@cd ${THTTPD_NAME}  && \
	sed -i 's/8089/8199/g' ${THTTPD_CONF}
	@test -f workdir && echo "workdir already exists" || mkdir workdir 
	@echo '<HTML><HEAD><TITLE>Index of ./</TITLE></HEAD><BODY BGCOLOR="#99cc99" TEXT="#000000" LINK="#2020ff" VLINK="#4040cc"><H4>Index of ./</H4></HTML>' > workdir/index.html

	${THTTPD_NAME}/thttpd -C ${THTTPD_NAME}/thttpd.conf
	wget 127.0.0.1:8190/ 
	@cd ${OUT_DIR}/work_dir/ && \
        mkdir workdir && \
	echo '<HTML><HEAD><TITLE>Index of ./</TITLE></HEAD><BODY BGCOLOR="#99cc99" TEXT="#000000" LINK="#2020ff" VLINK="#4040cc"><H4>Index of ./</H4></HTML>' > workdir/index.html && \
	./thttpd_fin_stripped  && \
	wget 127.0.0.1:8089/
	@cmp -s ./index.html ${OUT_DIR}/work_dir/index.html; \
	RETVAL=$$?; \
	if [ $$RETVAL -eq 0 ]; then \
		echo "\tthttpd test baseline compare? Passed!"; \
	else \
		echo "\tthttpd test baseline compare? Failed!"; \
	fi
		
${OUT_DIR}:
	mkdir -p ${OUT_DIR}

${THTTPD_NAME}:
	tar -xvzf ./${THTTPD_TAR}

clean:
	rm -rf ${THTTPD_NAME}
	rm *.bc
	rm -r ${OUT_DIR}
