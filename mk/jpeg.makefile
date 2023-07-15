
jpeg: ./mk/jpeg.makefile
	tar xf pkg/jpegsrc.v9e.tar.gz
	patch -p1 -d jpeg-9e < src/jpeg-1-fixes.patch
	patch -p1 -d jpeg-9e < src/jpeg-2-jmorecfg.patch
	cd jpeg-9e && \
	./configure --host=${CPUARCH}-w64-mingw32 --prefix=${GTK_PREFIX} --enable-static=yes --disable-shared CFLAGS="-O2" CXXFLAGS="-O2" ac_cv_prog_HAVE_DOXYGEN="false" && \
	make -j ${JOBS} sbin_PROGRAMS= noinst_PROGRAMS= man_MANS= && \
	make -j 1 install sbin_PROGRAMS= noinst_PROGRAMS= man_MANS=

clean:
	rm -rf jpeg-9e

