ifeq ($(strip $(USE_POSIX_THREAD)),true)
    GCC_POSIX_OPT = -Wl,-L$(GTK_PREFIX)/lib -Wl,-lexpat
    GXX_POSIX_OPT = -Wl,-L$(GTK_PREFIX)/lib -Wl,-lexpat
    LD_POSIX_OPT = -static -static-libgcc -static-libstdc++ -lwinpthread -L${GTK_PREFIX}/lib
    EXTRA_LIBS = -lexpat
else ifeq ($(strip $(USE_POSIX_THREAD)),false)
    GCC_POSIX_OPT =
    GXX_POSIX_OPT =
    LD_POSIX_OPT =
    EXTRA_LIBS =
else
    $(error USE_POSIX_THREAD invalid value: $(strip $(USE_POSIX_THREAD)))
endif

pango: ./mk/pango.makefile
	tar xf pkg/pango-1.50.11.tar.xz
	cd pango-1.50.11 && \
	mkdir -p _build && \
	CPPFLAGS="-I$(GTK_PREFIX)/include" CFLAGS="-I$(GTK_PREFIX)/include $(GCC_POSIX_OPT)" CXXFLAGS="-I${GTK_PREFIX}/include $(GXX_POSIX_OPT)" LDFLAGS="$(LD_POSIX_OPT)" LIBS="$(EXTRA_LIBS)" meson --prefix=${GTK_PREFIX} --default-library static -Dprefer_static=true -Ddebug=false -Doptimization=2 -Dintrospection=disabled _build/ && \
	ninja -j ${JOBS} -C ./_build && \
	ninja -j 1 -C ./_build install

clean:
	rm -rf pango-1.50.11

