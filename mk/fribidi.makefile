
fribidi: ./mk/fribidi.makefile
	tar xf pkg/fribidi-v1.0.11.tar.gz
	cd fribidi-1.0.11 && \
	mkdir -p _build && \
	CPPFLAGS="-I${GTK_PREFIX}/include" CFLAGS="-I${GTK_PREFIX}/include" CXXFLAGS="-I${GTK_PREFIX}/include" meson --buildtype=release --prefix=${GTK_PREFIX} --default-library static --optimization 2 -Dtests=false -Ddocs=false _build/ && \
	ninja -j ${JOBS} -C ./_build && \
	ninja -j 1 -C ./_build install

clean:
	rm -rf fribidi-1.0.11

