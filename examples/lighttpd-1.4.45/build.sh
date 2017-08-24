LIGHTTPD_STATIC=yes ./configure -C --enable-static=yes
make CFLAGS="-DLIGHTTPD_STATIC -std=c99"
