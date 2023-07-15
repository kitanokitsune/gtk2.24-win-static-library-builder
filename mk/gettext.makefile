#ifeq ($(strip $(USE_POSIX_THREAD)),true)
#    GETTEXT_THREAD_MODEL = posix
#    GCC_POSIX_OPT = -static -static-libgcc -Wl,-Bstatic -lwinpthread
#    GXX_POSIX_OPT = -static -static-libgcc -static-libstdc++ -Wl,-Bstatic -lwinpthread
#else ifeq ($(strip $(USE_POSIX_THREAD)),false)
    GETTEXT_THREAD_MODEL = windows
    GCC_POSIX_OPT =
    GXX_POSIX_OPT =
#else
#    $(error USE_POSIX_THREAD invalid value: $(strip $(USE_POSIX_THREAD)))
#endif


gettext: ./mk/gettext.makefile
	tar --lzip -xf pkg/gettext-0.22.tar.lz && \
	patch -p1 -d gettext-0.22 < ./src/gettext-0.22.patch && \
	cd gettext-0.22 && \
	rm -rf build && \
	mkdir -p build && \
	cd build && \
	../gettext-runtime/configure --host=${CPUARCH}-w64-mingw32 --prefix=${GTK_PREFIX} --disable-rpath --enable-static --disable-shared  ac_cv_prog_HAVE_DOXYGEN="false" --enable-doc=no --enable-gtk-doc=no --enable-gtk-doc-html=no --enable-gtk-doc-pdf=no --disable-doxygen --enable-threads=$(GETTEXT_THREAD_MODEL) --enable-relocatable --without-libexpat-prefix --without-libxml2-prefix CONFIG_SHELL=bash CFLAGS="-O2 $(GCC_POSIX_OPT)" CXXFLAGS="-O2 $(GXX_POSIX_OPT)" && \
	make -j ${JOBS} && \
	make -j 1 install


clean:
	rm -rf gettext-0.22
