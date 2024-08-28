
ifeq ($(strip $(USE_POSIX_THREAD)),true)
    GCC_POSIX_OPT = -static-libgcc -Wl,-Bstatic -lwinpthread
    GXX_POSIX_OPT = -static-libgcc -static-libstdc++ -Wl,-Bstatic -lwinpthread
    LD_POSIX_OPT = -static-libgcc -static-libstdc++ -lwinpthread
else ifeq ($(strip $(USE_POSIX_THREAD)),false)
    GCC_POSIX_OPT =
    GXX_POSIX_OPT =
    LD_POSIX_OPT =
else
    $(error USE_POSIX_THREAD invalid value: $(strip $(USE_POSIX_THREAD)))
endif

glib: ./mk/glib.makefile
	./src/_chkroot.sh
	${SEVENZIPBINPATH} x -aoa pkg/glib-2.76.3.tar.xz
	${SEVENZIPBINPATH} x -aoa -oglib-tmp/ glib-2.76.3.tar
	mv glib-tmp/glib-2.76.3 .
	cd glib-2.76.3 && \
	tar xfmp ../pkg/glib_subprojects.tar.xz && \
	rm -rf _build && \
	mkdir -p _build && \
	CFLAGS="-I${GTK_PREFIX}/include -static $(GCC_POSIX_OPT)" CXXFLAGS="-I${GTK_PREFIX}/include -static $(GXX_POSIX_OPT)" LDFLAGS="-static $(LD_POSIX_OPT) -L${GTK_PREFIX}/lib" meson --prefix=${GTK_PREFIX} --default-library static -Dprefer_static=true -Ddebug=false -Doptimization=2 -Dtests=false -Dforce_posix_threads=$(USE_POSIX_THREAD) _build/ && \
	ninja -j ${JOBS} -C ./_build && \
	ninja -j 1 -C ./_build install

clean:
	rm -rf glib-tmp glib-2.76.3.tar glib-2.76.3

