
gdk-pixbuf: ./mk/gdk-pixbuf.makefile
	./src/_chkroot.sh
	${SEVENZIPBINPATH} x -aoa pkg/gdk-pixbuf-2.42.6.tar.xz
	${SEVENZIPBINPATH} x -aoa -ogdk-tmp/ gdk-pixbuf-2.42.6.tar
	mv gdk-tmp/gdk-pixbuf-2.42.6 .
	patch -p1 -d gdk-pixbuf-2.42.6 < src/gdk-pixbuf-1-fixes.patch
	sed -i 's/not meson.is_cross_build()/false/g' gdk-pixbuf-2.42.6/meson.build
	sed -i 's/not meson.is_cross_build()/false/g' gdk-pixbuf-2.42.6/gdk-pixbuf/meson.build
	cd gdk-pixbuf-2.42.6 && \
	rm -rf _build && \
	mkdir -p _build && \
	CPPFLAGS="-DGDK_PIXBUF_RELOCATABLE -I${GTK_PREFIX}/include" CFLAGS="-DGDK_PIXBUF_RELOCATABLE -I${GTK_PREFIX}/include -static -static-libgcc" CXXFLAGS="-DGDK_PIXBUF_RELOCATABLE -I${GTK_PREFIX}/include -static -static-libgcc -static-libstdc++" LDFLAGS="-static -static-libgcc -static-libstdc++ -L${GTK_PREFIX}/lib" PKG_CONFIG="pkg-config --static" meson --buildtype=release --prefix=${GTK_PREFIX} --default-library static -Dprefer_static=true -Drelocatable=true -Doptimization=2 -Dgio_sniffing=false -Dinstalled_tests=false -Dintrospection=disabled -Dman=false -Dnative_windows_loaders=true -Dbuiltin_loaders=all _build/ && \
	ninja -j ${JOBS} -C ./_build && \
	ninja -j 1 -C ./_build install
#	sed -i 's|\( \([^ ]\+\) \([^ ]\+\) \([^ ]\+\) \([^ ]\+\)\)\( \2 \3 \4 \5\)\+| \2 \3 \4 \5|g' ${GTK_PREFIX}/lib/pkgconfig/gdk-pixbuf-2.0.pc

clean:
	rm -rf gdk-tmp gdk-pixbuf-2.42.6.tar gdk-pixbuf-2.42.6

