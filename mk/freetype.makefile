
freetype: ./mk/freetype.makefile
	./src/_chkroot.sh
	cd ${GTK_PREFIX}/lib && (cmd.exe "/U /C mklink libharfbuzz_too.a libharfbuzz.a" || true)
	cd ${GTK_PREFIX}/lib && (cmd.exe "/U /C mklink libfreetype_too.a libfreetype.a" || true)
	tar xf pkg/freetype-2.13.1.tar.xz
	cd freetype-2.13.1 && \
	GNUMAKE=make PKG_CONFIG_LIBDIR=${GTK_PREFIX}/lib/pkgconfig ./configure --host=${CPUARCH}-w64-mingw32 --prefix=${GTK_PREFIX} --with-harfbuzz=yes --enable-static --disable-shared  ac_cv_prog_HAVE_DOXYGEN="false" --enable-freetype-config CFLAGS="-O2" CXXFLAGS="-O2" LIBPNG_CFLAGS="-O2 `pkg-config libpng --cflags`" LIBPNG_LDFLAGS="`pkg-config libpng --libs`" FT2_EXTRA_LIBS="`pkg-config libpng --libs`" HARFBUZZ_LIBS="`pkg-config harfbuzz --libs` -lharfbuzz_too -lfreetype_too -lusp10 -lgdi32 -lrpcrt4 `pkg-config glib-2.0 --libs`" PKG_CONFIG="pkg-config --static" && \
	make -j ${JOBS} && \
	make -j 1 install && \
	sync; sync; sync
#	sed -i 's/ -lharfbuzz_too//g' ${GTK_PREFIX}/lib/pkgconfig/freetype2.pc && \
#	sed -i 's/ -lfreetype_too//g' ${GTK_PREFIX}/lib/pkgconfig/freetype2.pc
#	sed -i 's/harfbuzz_too/harfbuzz/g' ${GTK_PREFIX}/lib/libfreetype.la && \
#	sed -i 's/freetype_too/freetype/g' ${GTK_PREFIX}/lib/libfreetype.la
	rm -f ${GTK_PREFIX}/lib/libfreetype_too.a ${GTK_PREFIX}/lib/libharfbuzz_too.a
	cp -f ${GTK_PREFIX}/lib/libfreetype.a ${GTK_PREFIX}/lib/libfreetype_too.a
	cp -f ${GTK_PREFIX}/lib/libharfbuzz.a ${GTK_PREFIX}/lib/libharfbuzz_too.a

clean:
	rm -rf freetype-2.13.1

