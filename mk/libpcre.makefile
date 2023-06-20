
libpcre: ./mk/libpcre.makefile
	tar xf pkg/libpcre-8.41.tar.xz
	cd libpcre-8.41 && \
	./configure --host=${CPUARCH}-w64-mingw32 --prefix=${GTK_PREFIX} --enable-static --disable-shared  ac_cv_prog_HAVE_DOXYGEN="false" --enable-pcre8 --enable-pcre16 --enable-pcre32 --enable-jit --enable-utf --enable-unicode-properties --enable-newline-is-anycrlf CPPFLAGS="-I${GTK_PREFIX}/include" CFLAGS="-I${GTK_PREFIX}/include -static" CXXFLAGS="-I${GTK_PREFIX}/include -static" LDFLAGS="-static -L${GTK_PREFIX}/lib" && \
	make -j ${JOBS} && \
	make -j 1 install

clean:
	rm -rf libpcre-8.41
