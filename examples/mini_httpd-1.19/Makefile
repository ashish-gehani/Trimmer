MINI_HTTPD=mini_httpd
MINI_HTTPD_BITCODE=${MINI_HTTPD}.bc
MINI_HTTPD_VERSION=1.19
MINI_HTTPD_NAME=${MINI_HTTPD}-${MINI_HTTPD_VERSION}
MINI_HTTPD_TAR=${MINI_HTTPD_NAME}.tar.gz

MINI_HTTPD_MANIFEST=${MINI_HTTPD}.manifest
MINI_HTTPD_PATCH=mini_httpd.patch
MINI_HTTPD_CONF=./mini_httpd.conf


OUT_DIR?=trimmer
LOG_FILE?=logs

BITCODE_WRAPPER?=wllvm
BITCODE_EXTRACT?=extract-bc

all: ${MINI_HTTPD_BITCODE}

mini: ${OUT_DIR} 
	cp ${MINI_HTTPD_BITCODE} ${OUT_DIR} 
	cp ${MINI_HTTPD_CONF} ${OUT_DIR}
	cd ${OUT_DIR} && \echo '{"binary": "mini_httpd_fin", "native_libs": [], "name": "mini_httpd", "args": ["-C", "mini_httpd.conf"], "modules": [], "ldflags": ["-lcrypt"], "main": "mini_httpd.bc", "config_files": ["mini_httpd.conf"]}' > ${MINI_HTTPD_MANIFEST} && \
	python ${TRIMMER_HOME}/tool/trimmer.py ${MINI_HTTPD_MANIFEST} ./work_dir 2> ${LOG_FILE}
	mkdir ${OUT_DIR}/work_dir/workdir

test_mini:
	@echo "\t\tTesting Mini"
	@cp ${MINI_HTTPD_CONF} ${MINI_HTTPD_NAME}
	@cd ${MINI_HTTPD_NAME}  && \
	sed -i 's/8087/8199/g' ${MINI_HTTPD_CONF}
	@test -f workdir && echo "workdir already exists" || mkdir workdir 
	@echo '<HTML><HEAD><TITLE>Index of ./</TITLE></HEAD><BODY BGCOLOR="#99cc99" TEXT="#000000" LINK="#2020ff" VLINK="#4040cc"><H4>Index of ./</H4></HTML>' > workdir/index.html

	${MINI_HTTPD_NAME}/mini_httpd -C ${MINI_HTTPD_NAME}/mini_httpd.conf
	wget 127.0.0.1:8199/ 
	@cd ${OUT_DIR}/work_dir/ && \
	echo '<HTML><HEAD><TITLE>Index of ./</TITLE></HEAD><BODY BGCOLOR="#99cc99" TEXT="#000000" LINK="#2020ff" VLINK="#4040cc"><H4>Index of ./</H4></HTML>' > workdir/index.html && \
	./mini_httpd_fin  && \
	wget 127.0.0.1:8087/
	@cmp -s ./index.html ${OUT_DIR}/work_dir/index.html; \
	RETVAL=$$?; \
	if [ $$RETVAL -eq 0 ]; then \
		echo "\tmini_httpd test baseline compare? Passed!"; \
	else \
		echo "\tmini_httpd test baseline compare? Failed!"; \
	fi


${MINI_HTTPD_BITCODE}: ${MINI_HTTPD_NAME}
	cp ${MINI_HTTPD_PATCH} ${MINI_HTTPD_NAME} && \
	cd ${MINI_HTTPD_NAME} && \
	sed -i 's/CC =		gcc/CC? = gcc/g' ./Makefile && \
	sed -i 's/-O/ -Xclang -disable-O0-optnone/g' ./Makefile && \
	patch -p1 -f -R -i ./${MINI_HTTPD_PATCH} && \
	CC=${BITCODE_WRAPPER} make && \
	${BITCODE_EXTRACT} ${MINI_HTTPD} && \
	mv ${MINI_HTTPD_BITCODE} ../
		
${OUT_DIR}:
	mkdir -p ${OUT_DIR}

${MINI_HTTPD_NAME}:
	tar -xvzf ./${MINI_HTTPD_TAR}

clean:
	rm -r ${MINI_HTTPD_NAME}
	rm *.bc
	rm -r ${OUT_DIR}
	rm index.html*
	rm -r workdir
