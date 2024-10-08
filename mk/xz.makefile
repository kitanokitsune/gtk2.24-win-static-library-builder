
xz: ./mk/xz.makefile
	tar xf pkg/xz-5.6.2.tar.xz
	cd xz-5.6.2 && \
	./configure --host=${CPUARCH}-w64-mingw32 --prefix=${GTK_PREFIX} --disable-rpath --enable-static --disable-shared  ac_cv_prog_HAVE_DOXYGEN="false" --enable-doc=no --disable-threads --disable-nls CPPFLAGS="-I${GTK_PREFIX}/include" CFLAGS="-O2 -I${GTK_PREFIX}/include -static" CXXFLAGS="-O2 -I${GTK_PREFIX}/include -static" LDFLAGS="-L${GTK_PREFIX}/lib -static" && \
	make -j ${JOBS} -C ./src/liblzma && \
	make -j 1 -C ./src/liblzma install

clean:
	rm -rf xz-5.6.2

