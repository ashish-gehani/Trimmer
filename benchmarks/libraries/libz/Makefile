#iam 6/5/2018

THISDIR =  $(shell pwd)
OS      =  $(shell uname)
ARCH    =  $(shell uname -p)


ZLIB_VERSION ?= 1.2.11

ZLIB=zlib-${ZLIB_VERSION}
ZLIB_TARBALL=${ZLIB}.tar.gz
ZLIB_URL=https://zlib.net/${ZLIB_TARBALL}
ZLIB_INSTALL=${THISDIR}/install/zlib

LLVMCC ?= gclang
LLVMGET ?= get-bc

ifeq (Darwin, $(findstring Darwin, ${OS}))

LIBEXT=dylib

else

LIBEXT=so

endif


BITCODE = libz.a.bc

all: ${BITCODE}

${ZLIB_TARBALL}:
	wget ${ZLIB_URL}

${ZLIB}: ${ZLIB_TARBALL}
	tar xvfz ${ZLIB_TARBALL}

${ZLIB_INSTALL}/lib/libz.a: ${ZLIB}
	cd ${ZLIB}; CC=${LLVMCC} ./configure --prefix=${ZLIB_INSTALL}; make && make install

libz.a.bc: ${ZLIB_INSTALL}/lib/libz.a
	cd ${ZLIB_INSTALL}/lib; ${LLVMGET} -b libz.a; mv libz.a.bc ${THISDIR}


clean:
	rm -rf ${BITCODE} ${ZLIB_INSTALL} ${ZLIB} ${ZLIB_TARBALL} install

.PHONY: clean very_clean spotless
