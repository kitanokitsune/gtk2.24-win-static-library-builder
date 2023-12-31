
pixman: ./mk/pixman.makefile
	tar xzf pkg/pixman-0.42.2.tar.gz
	cd pixman-0.42.2 && \
	./configure --host=${CPUARCH}-w64-mingw32 --prefix=${GTK_PREFIX} --enable-static --disable-shared --enable-static-testprogs ac_cv_prog_HAVE_DOXYGEN="false" CPPFLAGS="-I${GTK_PREFIX}/include" CFLAGS="-O2 -I${GTK_PREFIX}/include -static -static-libgcc" CXXFLAGS="-O2 -I${GTK_PREFIX}/include -static -static-libgcc -static-libstdc++" LDFLAGS="-static -static-libgcc -static-libstdc++ -L${GTK_PREFIX}/lib" && \
	make -j ${JOBS} sbin_PROGRAMS= noinst_PROGRAMS= && \
	make -j 1 install sbin_PROGRAMS= noinst_PROGRAMS=

clean:
	rm -rf pixman-0.42.2

