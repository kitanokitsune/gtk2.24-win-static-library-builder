
giflib: ./mk/giflib.makefile
	unzip -o pkg/giflib-sourceforge-mingw-master.zip
	cp -f src/giflib/Makefile-win.make giflib-sourceforge-mingw-master
	cd giflib-sourceforge-mingw-master && \
	make -j 1 -f Makefile-win.make PREFIX=${GTK_PREFIX} CFLAGS="-O2 -I${GTK_PREFIX}/include" CXXFLAGS="-O2 -I${GTK_PREFIX}/include" LDFLAGS="-L${GTK_PREFIX}/lib" && \
	make -j 1 -f Makefile-win.make install PREFIX=${GTK_PREFIX} CFLAGS="-O2 -I${GTK_PREFIX}/include" CXXFLAGS="-O2 -I${GTK_PREFIX}/include" LDFLAGS="-L${GTK_PREFIX}/lib"

clean:
	rm -rf giflib-sourceforge-mingw-master

