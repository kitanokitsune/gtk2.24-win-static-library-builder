
libiconv: ./mk/libiconv.makefile
	tar xf pkg/libiconv-1.17.tar.gz && \
	cd libiconv-1.17 && \
	./configure --prefix=${GTK_PREFIX} --disable-rpath --enable-static=yes --disable-shared --disable-nls ac_cv_prog_HAVE_DOXYGEN="false" && \
	make -j ${JOBS} && \
	make -j 1 install

clean:
	rm -rf libiconv-1.17

