
icu4c: ./mk/icu4c.makefile
	rm -fv ${GTK_PREFIX}/bin/libicu*.a ${GTK_PREFIX}/bin/libicu*.dll ${GTK_PREFIX}/bin/libicu*.dll.a ${GTK_PREFIX}/bin/libsicu*.a ${GTK_PREFIX}/bin/libsicu*.dll ${GTK_PREFIX}/bin/libsicu*.dll.a ${GTK_PREFIX}/bin/icu*.a ${GTK_PREFIX}/bin/icu*.dll ${GTK_PREFIX}/bin/icu*.dll.a ${GTK_PREFIX}/lib/libicu*.a ${GTK_PREFIX}/lib/libicu*.dll ${GTK_PREFIX}/lib/libicu*.dll.a ${GTK_PREFIX}/lib/libsicu*.a ${GTK_PREFIX}/lib/libsicu*.dll ${GTK_PREFIX}/lib/libsicu*.dll.a ${GTK_PREFIX}/lib/icu*.a ${GTK_PREFIX}/lib/icu*.dll ${GTK_PREFIX}/lib/icu*.dll.a
	tar xzf pkg/icu4c-release-66.1.tar.gz
	cd icu/source && \
	./configure --host=${CPUARCH}-w64-mingw32 --enable-rpath --prefix=${GTK_PREFIX} --enable-static --disable-shared ac_cv_prog_HAVE_DOXYGEN="false" --enable-icu-config=no CPPFLAGS="-I${GTK_PREFIX}/include" CFLAGS="-I${GTK_PREFIX}/include -static" CXXFLAGS="-std=gnu++11 -I${GTK_PREFIX}/include -static" LDFLAGS="-L${GTK_PREFIX}/lib -static" SHELL=bash LIBS="-lstdc++" && \
	sync; sync; sync && \
	sed -i 's/#include <condition_variable>/#include "mingw.condition_variable.h"/g' ./common/umutex.h && \
	sed -i 's/#include <mutex>/#include "mingw.mutex.h"/g' ./common/umutex.h && \
	cp ../../src/icu4c/*.h common && \
	make -j 1 install VERBOSE=1 SO_TARGET_VERSION_SUFFIX=

clean:
	rm -rf icu

