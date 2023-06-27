export MSYS=winsymlinks:lnk

glib: ./mk/glib.makefile
	tar xf pkg/glib-2.76.3.tar.xz
	#patch -p1 -d glib-2.76.3 < src/glib-1-fixes.patch
	#patch -p1 -d glib-2.76.3 < src/glib-2-link-with-libuuid.patch
	#patch -p1 -d glib-2.76.3 < src/glib-3-static-link.patch
	cd glib-2.76.3 && \
	#tar xf ../pkg/glib_subprojects.tar.xz && \
	rm -rf _build && \
	mkdir -p _build && \
	CFLAGS="-I${GTK_PREFIX}/include -static" CXXFLAGS="-I${GTK_PREFIX}/include -static" LDFLAGS="-static -L${GTK_PREFIX}/lib" meson --buildtype=release --prefix=${GTK_PREFIX} --default-library static -Dprefer_static=true -Doptimization=2 -Dtests=false -Dforce_posix_threads=false _build/ && \
	ninja -j ${JOBS} -C ./_build && \
	ninja -j 1 -C ./_build install

clean:
	rm -rf glib-2.76.3

