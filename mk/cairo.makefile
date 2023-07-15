ifeq ($(strip $(USE_POSIX_THREAD)),true)
    ENABLE_PTHREAD_SWITCH = --enable-pthread
else ifeq ($(strip $(USE_POSIX_THREAD)),false)
    ENABLE_PTHREAD_SWITCH = --disable-pthread
else
    $(error USE_POSIX_THREAD invalid value: $(strip $(USE_POSIX_THREAD)))
endif

cairo: ./mk/cairo.makefile
	tar xf pkg/cairo-1.17.6.tar.xz
	patch -p1 -d cairo-1.17.6 < src/cairo-1-fixes.patch
	sed -i 's,libpng12,libpng,g' cairo-1.17.6/configure
	sed -i 's,^\(Libs:.*\),\1 @CAIRO_NONPKGCONFIG_LIBS@,' cairo-1.17.6/src/cairo.pc.in
	cd cairo-1.17.6 && \
	./configure --host=${CPUARCH}-w64-mingw32 --prefix=${GTK_PREFIX} --enable-static --disable-shared  ac_cv_prog_HAVE_DOXYGEN="false" --enable-gtk-doc=no --enable-gtk-doc-html=no --enable-gtk-doc-pdf=no --disable-gtk-doc --disable-test-surfaces --disable-gcov --disable-xlib --disable-xlib-xrender --disable-xcb --disable-quartz --disable-quartz-font --disable-quartz-image --disable-os2 --disable-beos --disable-directfb --disable-atomic --enable-win32 --enable-win32-font --enable-png --enable-ft --enable-ps --enable-pdf --enable-svg $(ENABLE_PTHREAD_SWITCH) CPPFLAGS="-I${GTK_PREFIX}/include" CFLAGS="-O2 -DCAIRO_WIN32_STATIC_BUILD -I${GTK_PREFIX}/include -static" CXXFLAGS="-O2 -I${GTK_PREFIX}/include -static" LDFLAGS="-L${GTK_PREFIX}/lib -static" LIBS="-lmsimg32 -lgdi32 `pkg-config pixman-1 --libs`" PKG_CONFIG="`which pkg-config`" && \
	make -j ${JOBS} sbin_PROGRAMS= noinst_PROGRAMS= && \
	make -j 1 install sbin_PROGRAMS= noinst_PROGRAMS=

clean:
	rm -rf cairo-1.17.6

