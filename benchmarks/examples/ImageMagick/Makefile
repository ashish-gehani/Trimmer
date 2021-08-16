IMGDIR= $(shell pwd)

MANIFEST=imagemagick.manifest

#LLVMCC=wllvm
#LLVMGET=extract-bc
SLASH_ARGS ?=''
LLVMCC ?=wllvm
LLVMCXX ?=wllvm++
LLVMGET=extract-bc

PREFIX ?= install

IMG_MAGICK_VERSION=7.0.8-68
IMG_MAGICK=ImageMagick-${IMG_MAGICK_VERSION}
IMG_MAGICK_TARBALL=${IMG_MAGICK}.tar.xz
IMG_MAGICK_URL=https://imagemagick.org/download/releases/${IMG_MAGICK_TARBALL}
IMG_MAGICK_INSTALL=${IMGDIR}/${PREFIX}
IMG_MAGICK_BITCODE=magick_combined.bc
OUT_DIR?=trimmer
LOG_FILE?=logs

#iam: producing the library varies from OS to OS
OS   =  $(shell uname)
ifeq (Darwin, $(findstring Darwin, ${OS}))
#  DARWIN
LIBEXT=dylib
else
LIBEXT=so
endif

bitcode=magick.bc libMagickCore.bc libMagickWand.bc

all: bitcode 

magick: ${OUT_DIR} ${IMG_MAGICK_BITCODE}
	cp ${IMG_MAGICK_BITCODE} ${OUT_DIR}
	cd ${OUT_DIR} && \
        echo '{ "main" : "magick_combined.bc" , "binary"  : "magick_fin" , "modules"    : [] , "native_libs" : [] , "ldflags" : ["-lm", "-lbz2", "-lz", "-lpthread"] , "name"    : "magick" , "args" : ["convert", "_", "_", "_"]}' > ${MANIFEST} && \
        python ${TRIMMER_HOME}/tool/trimmer.py ${MANIFEST} ./work trackedPercent 50 2> ${LOG_FILE}

${IMG_MAGICK_TARBALL}:
	wget ${IMG_MAGICK_URL} --no-check-certificate

${IMG_MAGICK_INSTALL}/bin/convert: ${IMG_MAGICK_TARBALL}
	tar -xvf ${IMG_MAGICK_TARBALL}
	cd ${IMG_MAGICK}; ./buildconf; CC=${LLVMCC} CXX=${LLVMCXX} ./configure --enable-static --prefix=${IMG_MAGICK_INSTALL}/; make -j4; make install


bitcode: ${IMG_MAGICK_INSTALL}/bin/convert
	cd ${IMG_MAGICK_INSTALL}/bin/ && \
	${LLVMGET} magick &&\
	cp ./magick.bc ${IMGDIR}

	cd ${IMG_MAGICK_INSTALL}/lib 	&& \
	${LLVMGET} libMagickCore-7.Q16HDRI.${LIBEXT}.6.0.0 && \
	${LLVMGET} libMagickWand-7.Q16HDRI.${LIBEXT}.6.0.0 && \
	cp libMagickCore-7.Q16HDRI.${LIBEXT}.6.0.0.bc ${IMGDIR}/libMagickCore.bc &&  \
	cp libMagickWand-7.Q16HDRI.${LIBEXT}.6.0.0.bc ${IMGDIR}/libMagickWand.bc &&  \
	cd ${IMGDIR} && \
	make link

link:
	llvm-link libMagickWand.bc libMagickCore.bc magick.bc -o magick_combined.bc

test:
	@echo "\t\tTest Compress"
	@echo "File Existence Check:"
	@# Testing if compressed file produced
	@cp ${IMG_MAGICK}/images/smile.gif ./ && \
        cp ${OUT_DIR}/work/magick_fin_stripped ./ && \
        ./magick_fin_stripped convert -negate smile.gif negate_trimmer.gif && \
        test -f negate_trimmer.gif && echo "\ttest file exist? Passed!" || echo "\ttest file exist?  Failed!" 

	@${IMG_MAGICK_INSTALL}/bin/magick convert -negate smile.gif negate_magick.gif
        @echo "Output comparison to Baseline:"
	@cmp -s ./negate_magick.gif negate_trimmer.gif; \
	RETVAL=$$?; \
	if [ $$RETVAL -eq 0 ]; then \
                echo "\tImageMagick test baseline compare? Passed!"; \
        else \
                echo "\tImageMagick test baseline compare? Failed!"; \
        fi

clean:
	-rm -rf ${IMG_MAGICK}
	-rm -f ${IMG_MAGICK_TARBALL}
	-rm magick_*
	-rm *.bc
	-rm -r ${OUT_DIR}
	-rm *.gif
base:
	opt -O3 magick_combined.bc -o magick_combined_opt.bc
	llc -filetype=obj magick_combined_opt.bc -o magick_combined_opt.o
	clang++ -O3 magick_combined_opt.o -lm -lbz2 -lz -lpthread -o magick_combined_bin 
	strip magick_combined_bin -o magick_combined_base_stripped

${OUT_DIR}:
	mkdir -p ${OUT_DIR}

realclean:
	make clean
	rm -f libMagickCore.bc	
	rm -f libMagickWand.bc
	rm -f magick.bc
	rm -f imagemagick.manifest
	rm -rf ${IMG_MAGICK_INSTALL}
	rm -rf slash
