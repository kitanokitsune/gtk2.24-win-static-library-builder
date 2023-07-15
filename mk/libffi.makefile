
libffi: ./mk/libffi.makefile
	tar xf pkg/libffi-3.4.4.tar.gz && \
	cd libffi-3.4.4 && \
	./configure --prefix=${GTK_PREFIX} --host=${CPUARCH}-w64-mingw32 --enable-static --disable-shared  CFLAGS="-O2" CXXFLAGS="-O2" ac_cv_prog_HAVE_DOXYGEN="false" && \
	make -j ${JOBS} && \
	make -j 1 install

clean:
	rm -rf libffi-3.4.4

