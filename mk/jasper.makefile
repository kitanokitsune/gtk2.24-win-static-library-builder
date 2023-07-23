
jasper: ./mk/jasper.makefile
	tar xf pkg/jasper-4.0.0.tar.gz
	cd jasper-4.0.0 && \
	mkdir -p _build && \
	cd _build && \
	cmake ../ -G "MinGW Makefiles" -C ${GTK_PREFIX}/share/cmake/mxe-conf.cmake -DCMAKE_INSTALL_PREFIX=${GTK_PREFIX} -DJAS_STDC_VERSION="`${CPUARCH}-w64-mingw32-gcc -dM -E - < /dev/null | grep __STDC_VERSION__ | sed 's/^\([^ ]\+ \)\{2\}//;'`" -DJAS_ENABLE_SHARED=OFF -DJAS_ENABLE_LIBJPEG=ON -DJAS_ENABLE_OPENGL=OFF -DJAS_ENABLE_AUTOMATIC_DEPENDENCIES=OFF -DJAS_ENABLE_DOC=OFF -DJAS_ENABLE_PROGRAMS=OFF && \
	mingw32-make -j ${JOBS} && \
	mingw32-make -j 1 install

clean:
	rm -rf jasper-4.0.0

