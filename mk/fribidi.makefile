
fribidi: ./mk/fribidi.makefile
	tar xf pkg/fribidi-1.0.13.tar.xz
	cd fribidi-1.0.13 && \
	mkdir -p _build && \
	CPPFLAGS="-I${GTK_PREFIX}/include" CFLAGS="-I${GTK_PREFIX}/include" CXXFLAGS="-I${GTK_PREFIX}/include" meson --prefix=${GTK_PREFIX} --default-library static -Ddebug=false -Doptimization=2 -Dtests=false -Ddocs=false _build/ && \
	ninja -j ${JOBS} -C ./_build && \
	ninja -j 1 -C ./_build install

clean:
	rm -rf fribidi-1.0.13

