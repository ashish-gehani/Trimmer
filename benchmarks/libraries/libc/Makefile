
libc.a.bc: musllvm
	get-bc -b musllvm/lib/libc.a && \
	cp musllvm/lib/libc.a.bc ./


musllvm:
	git clone https://github.com/SRI-CSL/musllvm && \
	cd musllvm && \
	CC=gclang WLLVM_CONFIGURE_ONLY=1  ./configure --target=LLVM --build=LLVM && \
	make


clean:
	rm -rf *bc musllvm
