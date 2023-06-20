
fontconfig: ./mk/fontconfig.makefile
	tar xf pkg/fontconfig-2.14.0.tar.xz
	cd fontconfig-2.14.0 && \
	autoreconf -fi && \
	./configure --host=${CPUARCH}-w64-mingw32 --prefix=${GTK_PREFIX} --disable-rpath --enable-static --disable-shared  ac_cv_prog_HAVE_DOXYGEN="false" --with-arch=${CPUARCH}-w64-mingw32 --with-expat=${GTK_PREFIX} --disable-docs CPPFLAGS="-I${GTK_PREFIX}/include" CFLAGS="-I${GTK_PREFIX}/include -static -static-libgcc" CXXFLAGS="-I${GTK_PREFIX}/include -static -static-libgcc -static-libstdc++" LDFLAGS="-L${GTK_PREFIX}/lib -static -static-libgcc -static-libstdc++" FREETYPE_CFLAGS="`pkg-config --static --cflags freetype2`" FREETYPE_LIBS="`pkg-config --static --libs freetype2`" && \
	make -j 1 sbin_PROGRAMS= noinst_PROGRAMS= && \
	sync ; sync ; sync && \
	FONTCONFIG_FILE="${GTK_PREFIX}/etc/fonts/fonts.conf" make -j 1 install sbin_PROGRAMS= noinst_PROGRAMS=

clean:
	rm -rf fontconfig-2.14.0

