
pango: ./mk/pango.makefile
	tar xf pkg/pango-1.50.0.tar.xz
	cd pango-1.50.0 && \
	mkdir -p _build && \
	CPPFLAGS="-I${GTK_PREFIX}/include" CFLAGS="-I${GTK_PREFIX}/include -Wl,-L${GTK_PREFIX}/lib -Wl,-lexpat" CXXFLAGS="-I${GTK_PREFIX}/include -Wl,-L${GTK_PREFIX}/lib -Wl,-lexpat" LDFLAGS="-static-libgcc -L${GTK_PREFIX}/lib" LIBS="-lexpat" meson --buildtype=release --prefix=${GTK_PREFIX} --default-library static -Dprefer_static=true -Doptimization=2 -Dintrospection=disabled _build/ && \
	ninja -j ${JOBS} -C ./_build && \
	ninja -j 1 -C ./_build install

clean:
	rm -rf pango-1.50.0

