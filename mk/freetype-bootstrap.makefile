
freetype-bootstrap: ./mk/freetype-bootstrap.makefile
	tar xf pkg/freetype-2.12.1.tar.xz
	cd freetype-2.12.1 && \
	GNUMAKE=make PKG_CONFIG_LIBDIR=${GTK_PREFIX}/lib/pkgconfig ./configure --host=${CPUARCH}-w64-mingw32 --prefix=${GTK_PREFIX} --with-harfbuzz=no --enable-static --disable-shared  ac_cv_prog_HAVE_DOXYGEN="false" --enable-doc=no --enable-gtk-doc=no --enable-gtk-doc-html=no --enable-gtk-doc-pdf=no --disable-doxygen --enable-freetype-config CFLAGS="-O2" CXXFLAGS="-O2" LIBPNG_CFLAGS="-O2 `pkg-config libpng --cflags`" LIBPNG_LDFLAGS="`pkg-config libpng --libs`" FT2_EXTRA_LIBS="`pkg-config libpng --libs`" HARFBUZZ_LIBS="`pkg-config glib-2.0 --libs`" && \
	make -j ${JOBS} && \
	make -j 1 install

clean:
	rm -rf freetype-2.12.1

