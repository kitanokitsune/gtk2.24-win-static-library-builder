

gettext: ./mk/gettext.makefile
	tar --lzip -xf pkg/gettext-0.21.tar.lz && \
	cd gettext-0.21 && \
	rm -rf build && \
	mkdir -p build && \
	cd build && \
	../gettext-runtime/configure --host=${CPUARCH}-w64-mingw32 --prefix=${GTK_PREFIX} --disable-rpath --enable-static --disable-shared  ac_cv_prog_HAVE_DOXYGEN="false" --enable-doc=no --enable-gtk-doc=no --enable-gtk-doc-html=no --enable-gtk-doc-pdf=no --disable-doxygen --enable-threads=windows --without-libexpat-prefix --without-libxml2-prefix CONFIG_SHELL=bash CFLAGS="-O2" CXXFLAGS="-O2" && \
	make -j ${JOBS} && \
	make -j 1 install

clean:
	rm -rf gettext-0.21
