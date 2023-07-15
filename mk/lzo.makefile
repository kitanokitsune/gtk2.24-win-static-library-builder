
lzo: ./mk/lzo.makefile
	tar xzf pkg/lzo-2.10.tar.gz
	cd lzo-2.10 && \
	./configure --host=${CPUARCH}-w64-mingw32 --prefix=${GTK_PREFIX} --enable-static --disable-shared  ac_cv_prog_HAVE_DOXYGEN="false" CPPFLAGS="-I${GTK_PREFIX}/include" CFLAGS="-O2 -I${GTK_PREFIX}/include -static" CXXFLAGS="-O2 -I${GTK_PREFIX}/include -static" LDFLAGS="-L${GTK_PREFIX}/lib -static" && \
	make -j 1 install sbin_PROGRAMS= noinst_PROGRAMS= LDFLAGS=-no-undefined

clean:
	rm -rf lzo-2.10

