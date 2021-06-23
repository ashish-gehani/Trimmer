
libacl.a.bc: acl
	cd acl && \
	get-bc -b ./libacl/.libs/libacl.a && \
	cp ./libacl/.libs/libacl.a.bc ../


acl:
	git clone https://github.com/philips/acl.git && \
	cd acl	&& \
	make CC=gclang

clean:
	rm -rf *bc *acl
