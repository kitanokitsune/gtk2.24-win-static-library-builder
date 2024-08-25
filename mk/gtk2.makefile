ifeq ($(strip $(USE_POSIX_THREAD)),true)
    GCC_POSIX_OPT = -static-libgcc -Wl,-Bstatic -lwinpthread
    GXX_POSIX_OPT = -static-libgcc -static-libstdc++ -Wl,-Bstatic -lwinpthread
    LD_POSIX_OPT = -static-libgcc -static-libstdc++ -Bstatic -lwinpthread
else ifeq ($(strip $(USE_POSIX_THREAD)),false)
    GCC_POSIX_OPT =
    GXX_POSIX_OPT =
    LD_POSIX_OPT =
else
    $(error USE_POSIX_THREAD invalid value: $(strip $(USE_POSIX_THREAD)))
endif

gtk2: ./mk/gtk2.makefile
	tar xf pkg/gtk+-2.24.33.tar.xz
	patch -p1 -d gtk+-2.24.33 < src/gtk2.24.33-1-fixes.patch
	patch -p1 -d gtk+-2.24.33 < src/gtk2.24.33-2-embed_wimp.patch
	patch -p1 -d gtk+-2.24.33 < src/gtk2.24.33-3-ignore-pango-atk-check.patch
	patch -p1 -d gtk+-2.24.33 < src/gtk2.24.33-4-fix-stability-problem-1wj.patch
	cd gtk+-2.24.33 && \
	./configure --host=${CPUARCH}-w64-mingw32 --prefix=${GTK_PREFIX} --enable-static=yes --disable-shared  ac_cv_prog_HAVE_DOXYGEN="false" --enable-gtk-doc=no --enable-gtk-doc-html=no --enable-gtk-doc-pdf=no --enable-explicit-deps --disable-glibtest --disable-modules --disable-cups --disable-test-print-backend --disable-gtk-doc --disable-man --without-x --with-gdktarget=win32 --with-included-immodules --enable-debug=no CPPFLAGS="-O2 -I${GTK_PREFIX}/include" CFLAGS="-O2 -I${GTK_PREFIX}/include -static $(GCC_POSIX_OPT)" CXXFLAGS="-O2 -I${GTK_PREFIX}/include -static $(GXX_POSIX_OPT)" LDFLAGS="-static $(LD_POSIX_OPT) -L${GTK_PREFIX}/lib" PKG_CONFIG="pkg-config --no-cache --static" && \
	sync; sync; sync && \
	sed -i 's/-lfreetype_too/-lfreetype/g' ./gtk/Makefile && \
	sed -i 's/-lharfbuzz_too/-lharfbuzz/g' ./gtk/Makefile && \
	sed -i 's/-lharfbuzz/-lharfbuzz -lusp10 -lgdi32 -lrpcrt4/g' ./gtk/Makefile && \
	make -j ${JOBS} noinst_PROGRAMS= check_PROGRAMS= man_MANS= man1_MANS= man2_MANS= man3_MANS= man4_MANS= man5_MANS= man6_MANS= man7_MANS= man8_MANS= man9_MANS= dist_man_MANS= dist_man1_MANS= dist_man2_MANS= dist_man3_MANS= dist_man4_MANS= dist_man5_MANS= dist_man6_MANS= dist_man7_MANS= dist_man8_MANS= dist_man9_MANS= nodist_man_MANS= nodist_man1_MANS= nodist_man2_MANS= nodist_man3_MANS= nodist_man4_MANS= nodist_man5_MANS= nodist_man6_MANS= nodist_man7_MANS= nodist_man8_MANS= nodist_man9_MANS= notrans_dist_man_MANS= MANLINKS= info_TEXINFOS= doc_DATA= dist_doc_DATA= html_DATA= dist_html_DATA= && \
	sync; sync; sync && \
	mkdir -p ${GTK_PREFIX}/lib/gtk-2.0/2.10.0 && \
	cp -f ./modules/input/immodules.cache ${GTK_PREFIX}/lib/gtk-2.0/2.10.0 && \
	make -j 1 install noinst_PROGRAMS= check_PROGRAMS= man_MANS= man1_MANS= man2_MANS= man3_MANS= man4_MANS= man5_MANS= man6_MANS= man7_MANS= man8_MANS= man9_MANS= dist_man_MANS= dist_man1_MANS= dist_man2_MANS= dist_man3_MANS= dist_man4_MANS= dist_man5_MANS= dist_man6_MANS= dist_man7_MANS= dist_man8_MANS= dist_man9_MANS= nodist_man_MANS= nodist_man1_MANS= nodist_man2_MANS= nodist_man3_MANS= nodist_man4_MANS= nodist_man5_MANS= nodist_man6_MANS= nodist_man7_MANS= nodist_man8_MANS= nodist_man9_MANS= notrans_dist_man_MANS= MANLINKS= info_TEXINFOS= doc_DATA= dist_doc_DATA= html_DATA= dist_html_DATA=


clean:
	rm -rf gtk+-2.24.33

