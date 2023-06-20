
harfbuzz: ./mk/harfbuzz.makefile
	tar xf pkg/harfbuzz-5.0.1.tar.xz
	patch -p1 -d harfbuzz-5.0.1 < src/harfbuzz-1-fixes.patch
	cd harfbuzz-5.0.1 && \
	rm -rf _build && \
	mkdir -p _build && \
	PKG_CONFIG="pkg-config --static" CPPFLAGS="-I${GTK_PREFIX}/include" CFLAGS="-I${GTK_PREFIX}/include" CXXFLAGS="-I${GTK_PREFIX}/include" LDFLAGS="-static-libgcc -static-libstdc++ -L${GTK_PREFIX}/lib" meson --buildtype=release --prefix=${GTK_PREFIX} --default-library static -Dprefer_static=true -Doptimization=2 -Dcairo=enabled -Dgdi=enabled -Dtests=disabled -Ddocs=disabled -Dintrospection=disabled _build/ && \
	ninja -j ${JOBS} -C ./_build && \
	ninja -j 1 -C ./_build install

clean:
	rm -rf harfbuzz-5.0.1.tar harfbuzz-tmp harfbuzz-5.0.1

