
libpng: ./mk/libpng.makefile
	tar xf pkg/libpng-1.6.37.tar.xz
	cd libpng-1.6.37 && \
	./configure --host=${CPUARCH}-w64-mingw32 --prefix=${GTK_PREFIX} --enable-static --disable-shared  ac_cv_prog_HAVE_DOXYGEN="false" CPPFLAGS="-I${GTK_PREFIX}/include" CFLAGS="-I${GTK_PREFIX}/include" CXXFLAGS="-I${GTK_PREFIX}/include" LDFLAGS="-L${GTK_PREFIX}/lib" && \
	make -j ${JOBS} sbin_PROGRAMS= noinst_PROGRAMS= man_MANS= && \
	make -j 1 install sbin_PROGRAMS= noinst_PROGRAMS= man_MANS=

clean:
	rm -rf libpng-1.6.37

