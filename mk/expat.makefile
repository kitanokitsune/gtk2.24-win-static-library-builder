
expat: ./mk/expat.makefile
	tar xf pkg/expat-2.4.8.tar.bz2
	cd expat-2.4.8 && \
	./configure --host=${CPUARCH}-w64-mingw32 --prefix=${GTK_PREFIX} --enable-static --disable-shared  ac_cv_prog_HAVE_DOXYGEN="false" --without-docbook CPPFLAGS="-I${GTK_PREFIX}/include" CFLAGS="-O2 -I${GTK_PREFIX}/include -static" CXXFLAGS="-O2 -I${GTK_PREFIX}/include -static" LDFLAGS="-L${GTK_PREFIX}/lib -static" && \
	make -j ${JOBS} && \
	make -j 1 install

clean:
	rm -rf expat-2.4.8

