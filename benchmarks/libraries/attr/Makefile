
libattr.shared.bc: attr-2.4.47
	cd attr-2.4.47 && \
	get-bc ./libattr/.libs/libattr.so.1.1.0 && \
	cp ./libattr/.libs/libattr.so.1.1.0.bc ../libattr.shared.bc


attr-2.4.47:
	wget http://download.savannah.gnu.org/releases/attr/attr-2.4.47.src.tar.gz && \
	tar -xvf attr-2.4.47.src.tar.gz && \
	cd attr-2.4.47 && \
	sed -i -e 's|/@pkg_name@|&-@pkg_version@|' include/builddefs.in && \
	INSTALL_USER=root  \
	INSTALL_GROUP=root \
	./configure --prefix=/usr --disable-static && \
	make CC=gclang


clean:
	rm -rf *bc attr-2.4.47*
