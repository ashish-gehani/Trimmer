SSH=ssh
SSH_BITCODE=${SSH}.bc
SSH_VERSION=6.6p1
SSH_NAME=open${SSH}-${SSH_VERSION}
SSH_TAR=${SSH_NAME}.tar.gz

SSH_MANIFEST=${SSH}.manifest

OUT_DIR?=trimmer
LOG_FILE?=logs

BITCODE_WRAPPER?=wllvm
BITCODE_EXTRACT?=extract-bc


all: ${SSH_BITCODE}

compress: ${OUT_DIR}
	sudo cp ssh.conf /usr/local/etc/ && \
	cp ${SSH_BITCODE} ${OUT_DIR} && \
	cd ${OUT_DIR} && \
	echo '{"binary": "ssh_fin", "native_libs": [], "name": "ssh", "args": ["-F",  "/usr/local/etc/ssh.conf", "lums"], "modules": [], "ldflags": ["-L'${TRIMMER_HOME}'/examples/openssh/openssh-6.6p1/", "-L'${TRIMMER_HOME}'/examples/openssh/openssh-6.6p1/openbsd-compat", "-lcrypto","-ldl","-lutil","-lz","-lnsl", "-lcrypt","-lresolv", "-lssh", "-lopenbsd-compat"], "main": "ssh.bc", "config_files": ["/usr/local/etc/ssh.conf"]}' > ${SSH_MANIFEST} && \
	python ${TRIMMER_HOME}/tool/trimmer.py ${SSH_MANIFEST} ./work_dir 2> ${LOG_FILE}

.PHONY: ${SSH_BITCODE}
${SSH_BITCODE}: ${SSH_NAME}
	cd ${SSH_NAME} && \
	CC=${BITCODE_WRAPPER} CFLAGS="-O0 -fno-inline -fno-inline-functions -Xclang -disable-O0-optnone" ./configure && \
	CC=${BITCODE_WRAPPER} make && \
	${BITCODE_EXTRACT} ${SSH} && \
	mv ${SSH_BITCODE} ../
		
${OUT_DIR}:
	mkdir -p ${OUT_DIR}

${SSH_NAME}:
	tar -xvzf ./${SSH_TAR}

clean:
	rm -rf ${SSH_NAME}
	rm *.bc
	rm -r ${OUT_DIR}
