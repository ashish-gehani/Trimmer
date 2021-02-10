all:
	git clone git://git.savannah.gnu.org/coreutils.git
	mkdir coreutils_source
	mv coreutils coreutils_source
	cd coreutils_source/coreutils && \
        ./bootstrap && \
        ./configure FORCE_UNSAFE_CONFIGURE=1 CC=gclang && \
        make -j4


