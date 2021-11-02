THTTPD=thttpd
THTTPD_BITCODE=${THTTPD}.bc
THTTPD_VERSION=2.25b
THTTPD_NAME=${THTTPD}-${THTTPD_VERSION}
THTTPD_TAR=${THTTPD_NAME}.tar.gz
THTTPD_PATCH=thttpd.patch
THTTPD_CONF=thttpd.conf
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
	python ${TRIMMER_HOME}/tool/trimmer.py ${THTTPD_MANIFEST} ./work_dir $(option) 2> ${LOG_FILE}

.PHONY: ${THTTPD_BITCODE}
${THTTPD_BITCODE}: ${THTTPD_NAME}
	cp ${THTTPD_PATCH} ${THTTPD_NAME} && \
	cd ${THTTPD_NAME} && \
	patch -p0 -f < ./${THTTPD_PATCH} && \
	CC=${BITCODE_WRAPPER} ./configure && \
	sed -i 's/-O/ /g' ./Makefile && \
	sed -i 's/CCOPT =/CCOPT = -fno-inline -fno-inline-functions -Xclang -disable-O0-optnone/g' ./Makefile && \
	CC=${BITCODE_WRAPPER} make && \
	${BITCODE_EXTRACT} ${THTTPD} && \
	mv ${THTTPD_BITCODE} ../

test_thttpd:
	@echo "\t\tTesting Thttpd"
	@cd ${OUT_DIR}/work_dir/ && \
	mkdir -p workdir && \
	echo '<HTML><HEAD><TITLE>Index of ./</TITLE></HEAD><BODY BGCOLOR="#99cc99" TEXT="#000000" LINK="#2020ff" VLINK="#4040cc"><H4>Index of ./</H4></HTML>' > workdir/index.html && \
	./thttpd_fin_stripped && \
	cd ../../ && \
	sleep 1
	wget 127.0.0.1:8087/

	cp ${THTTPD_CONF} ${THTTPD_NAME}
	sed -i 's/8087/8199/g' ${THTTPD_NAME}/${THTTPD_CONF}
	@mkdir -p ${THTTPD_NAME}/workdir 
	@echo '<HTML><HEAD><TITLE>Index of ./</TITLE></HEAD><BODY BGCOLOR="#99cc99" TEXT="#000000" LINK="#2020ff" VLINK="#4040cc"><H4>Index of ./</H4></HTML>' > ${THTTPD_NAME}/workdir/index.html && \
	cd ${THTTPD_NAME} && \
	./thttpd -C ${THTTPD_CONF}
	sleep 1
	cd ${THTTPD_NAME} && \
	wget 127.0.0.1:8199/ 
	cd ..
	@cmp -s ${THTTPD_NAME}/index.html.1 index.html; \
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

base:
	opt -O3 ${THTTPD_BITCODE} -o ${THTTPD}_opt.bc
	llc -filetype=obj ${THTTPD}_opt.bc -o ${THTTPD}_opt.o
	clang++ -O3 ${THTTPD}_opt.o -lcrypt -o ${THTTPD}_bin 
	strip ${THTTPD}_bin -o ${THTTPD}_base_stripped

clean:
	-rm -rf ${THTTPD_NAME}
	-rm *.bc
	-rm -r ${OUT_DIR}
	-rm *_bin *_stripped *.o
	-rm index*
