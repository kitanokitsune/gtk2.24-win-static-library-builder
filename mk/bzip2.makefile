
bzip2: ./mk/bzip2.makefile
	tar xf pkg/bzip2-1.0.8.tar.gz
	patch -p1 -d bzip2-1.0.8 < src/bzip2-1-fixes.patch
	cd bzip2-1.0.8 && \
	mkdir -p _build && \
	CPPFLAGS="-I${GTK_PREFIX}/include" CFLAGS="-O2 -I${GTK_PREFIX}/include -static" CXXFLAGS="-O2 -I${GTK_PREFIX}/include -static" LDFLAGS="-L${GTK_PREFIX}/lib -static" make -j ${JOBS} libbz2.a PREFIX=${GTK_PREFIX} && \
	ranlib libbz2.a && \
	install -m644 ./bzlib.h ${GTK_PREFIX}/include/ && \
	install -m644 ./libbz2.a ${GTK_PREFIX}/lib/
	cp ./src/bzip2.pc ${GTK_PREFIX}/lib/pkgconfig
	touch ${GTK_PREFIX}/lib/pkgconfig/bzip2.pc

clean:
	rm -rf bzip2-1.0.8

