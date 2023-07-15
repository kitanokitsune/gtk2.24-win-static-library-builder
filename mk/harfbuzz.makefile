ifeq ($(strip $(USE_POSIX_THREAD)),true)
    GCC_POSIX_OPT = -static -static-libgcc
    GXX_POSIX_OPT = -static -static-libgcc -static-libstdc++
    LD_POSIX_OPT = -static
    EXTRA_LIBS = -lstdc++ `pkg-config --static --libs libpng` -lfontconfig
else ifeq ($(strip $(USE_POSIX_THREAD)),false)
    GCC_POSIX_OPT = -Wl,-Bstatic -Wl,-lusp10 -Wl,-lgdiplus -Wl,-lgdi32
    GXX_POSIX_OPT = -Wl,-Bstatic -Wl,-lusp10 -Wl,-lgdiplus -Wl,-lgdi32
    LD_POSIX_OPT =
    EXTRA_LIBS = -lusp10 -lgdiplus -lgdi32
else
    $(error USE_POSIX_THREAD invalid value: $(strip $(USE_POSIX_THREAD)))
endif

harfbuzz: ./mk/harfbuzz.makefile
	tar xf pkg/harfbuzz-7.3.0.tar.xz
	patch -p1 -d harfbuzz-7.3.0 < src/harfbuzz-1-fixes.patch
	cd harfbuzz-7.3.0 && \
	rm -rf _build && \
	mkdir -p _build && \
	PKG_CONFIG="pkg-config --static" CPPFLAGS="-I${GTK_PREFIX}/include" CFLAGS="-I${GTK_PREFIX}/include $(GCC_POSIX_OPT)" CXXFLAGS="-I${GTK_PREFIX}/include $(GXX_POSIX_OPT)" LDFLAGS="$(LD_POSIX_OPT) -static-libgcc -static-libstdc++ -L${GTK_PREFIX}/lib" LIBS="$(EXTRA_LIBS)" meson --buildtype=release --prefix=${GTK_PREFIX} --default-library static -Dprefer_static=true -Doptimization=2 -Dcairo=enabled -Dgdi=enabled -Dtests=disabled -Ddocs=disabled -Dintrospection=disabled _build/ && \
	ninja -j ${JOBS} -C ./_build && \
	ninja -j 1 -C ./_build install

clean:
	rm -rf harfbuzz-7.3.0.tar harfbuzz-tmp harfbuzz-7.3.0

