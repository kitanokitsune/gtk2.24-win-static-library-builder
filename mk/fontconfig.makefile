ifeq ($(strip $(USE_POSIX_THREAD)),true)
    GCC_POSIX_OPT = -Wl,-Bstatic -lwinpthread
    GXX_POSIX_OPT = -Wl,-Bstatic -lwinpthread
    LD_POSIX_OPT = -lwinpthread
else ifeq ($(strip $(USE_POSIX_THREAD)),false)
    GCC_POSIX_OPT =
    GXX_POSIX_OPT =
    LD_POSIX_OPT =
else
    $(error USE_POSIX_THREAD invalid value: $(strip $(USE_POSIX_THREAD)))
endif

fontconfig: ./mk/fontconfig.makefile
	tar xf pkg/fontconfig-2.14.2.tar.xz
	cd fontconfig-2.14.2 && \
	autoreconf -fi && \
	./configure --host=${CPUARCH}-w64-mingw32 --prefix=${GTK_PREFIX} --disable-rpath --enable-static --disable-shared  ac_cv_prog_HAVE_DOXYGEN="false" --with-arch=${CPUARCH}-w64-mingw32 --with-expat=${GTK_PREFIX} --disable-docs CPPFLAGS="-I${GTK_PREFIX}/include" CFLAGS="-O2 -I${GTK_PREFIX}/include -static -static-libgcc $(GCC_POSIX_OPT)" CXXFLAGS="-O2 -I${GTK_PREFIX}/include -static -static-libgcc -static-libstdc++ $(GXX_POSIX_OPT)" LDFLAGS="-L${GTK_PREFIX}/lib -static -static-libgcc -static-libstdc++ $(LD_POSIX_OPT)" FREETYPE_CFLAGS="`pkg-config --static --cflags freetype2`" FREETYPE_LIBS="`pkg-config --static --libs freetype2`" && \
	make -j 1 sbin_PROGRAMS= noinst_PROGRAMS= && \
	sync ; sync ; sync && \
	FONTCONFIG_FILE="${GTK_PREFIX}/etc/fonts/fonts.conf" make -j 1 install sbin_PROGRAMS= noinst_PROGRAMS=

clean:
	rm -rf fontconfig-2.14.2

