
MEMCACHED=memcached
MEMCACHED_BITCODE=${MEMCACHED}.bc

memcached.bc:
	bash make.sh

base:
	opt -O3 ${MEMCACHED_BITCODE} -o ${MEMCACHED}_opt.bc
	llc -filetype=obj ${MEMCACHED}_opt.bc -o ${MEMCACHED}_opt.o
	clang++ -O3 ${MEMCACHED}_opt.o -levent -lpthread -o ${MEMCACHED}_bin 
	strip ${MEMCACHED}_bin -o ${MEMCACHED}_base_stripped

clean:
	-rm -rf memcached-1.4.4
	-rm -rf *.bc
	-rm -rf trimmer
	-rm *_bin *_stripped *.o
