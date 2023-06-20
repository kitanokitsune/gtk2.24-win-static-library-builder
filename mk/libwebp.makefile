
libwebp: ./mk/libwebp.makefile
	tar xf pkg/libwebp-1.2.2.tar.gz
	cd libwebp-1.2.2 && \
	./configure --host=${CPUARCH}-w64-mingw32 --prefix=${GTK_PREFIX} --enable-static --disable-shared  ac_cv_prog_HAVE_DOXYGEN="false" --enable-everything --enable-gif --enable-jpeg --enable-png --disable-tiff CPPFLAGS="-I${GTK_PREFIX}/include" CFLAGS="-I${GTK_PREFIX}/include -static" CXXFLAGS="-I${GTK_PREFIX}/include -static" LDFLAGS="-static -L${GTK_PREFIX}/lib" LIBS="${GTK_PREFIX}/lib/libgif.a" && \
	make -j ${JOBS} sbin_PROGRAMS= noinst_PROGRAMS= man_MANS= && \
	make -j 1 install sbin_PROGRAMS= noinst_PROGRAMS= man_MANS=

clean:
	rm -rf libwebp-1.2.2

