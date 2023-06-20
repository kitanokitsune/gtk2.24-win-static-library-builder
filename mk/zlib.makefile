
zlib: ./mk/zlib.makefile
	tar xf pkg/zlib-1.2.13.tar.xz
	patch -p1 -d zlib-1.2.13 < src/zlib-1.2.13-win32-static.patch
	cd zlib-1.2.13 && \
	./configure --prefix=${GTK_PREFIX} --static && \
	make -j 1 install

clean:
	rm -rf zlib-1.2.13

