
atk: ./mk/atk.makefile
	tar xf pkg/atk-2.38.0.tar.xz
	patch -p1 -d atk-2.38.0 < src/atk-1-fixes.patch && \
	cd atk-2.38.0 && \
	mkdir -p _build && \
	CPPFLAGS="-I${GTK_PREFIX}/include" CFLAGS="-I${GTK_PREFIX}/include" CXXFLAGS="-I${GTK_PREFIX}/include" LDFLAGS="-L${GTK_PREFIX}/lib" meson --prefix=${GTK_PREFIX} --default-library static -Dprefer_static=true -Ddebug=false -Doptimization=2 -Dintrospection=false _build/ && \
	ninja -j ${JOBS} -C ./_build && \
	ninja -j 1 -C ./_build install

clean:
	rm -rf atk-2.38.0

