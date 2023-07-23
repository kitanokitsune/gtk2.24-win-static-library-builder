
tiff: ./mk/tiff.makefile
	tar xf pkg/tiff-4.5.1.tar.xz
	cd tiff-4.5.1 && \
	./configure --host=${CPUARCH}-w64-mingw32 --prefix=${GTK_PREFIX} --disable-rpath --enable-static --disable-shared  ac_cv_prog_HAVE_DOXYGEN="false" --without-x CPPFLAGS="-I${GTK_PREFIX}/include" CFLAGS="-O2 -I${GTK_PREFIX}/include -static" CXXFLAGS="-O2 -I${GTK_PREFIX}/include -static" LDFLAGS="-L${GTK_PREFIX}/lib -static" && \
	make -j ${JOBS} sbin_PROGRAMS= noinst_PROGRAMS= check_PROGRAMS= man_MANS= man1_MANS= man2_MANS= man3_MANS= man4_MANS= man5_MANS= man6_MANS= man7_MANS= man8_MANS= man9_MANS= dist_man_MANS= dist_man1_MANS= dist_man2_MANS= dist_man3_MANS= dist_man4_MANS= dist_man5_MANS= dist_man6_MANS= dist_man7_MANS= dist_man8_MANS= dist_man9_MANS= nodist_man_MANS= nodist_man1_MANS= nodist_man2_MANS= nodist_man3_MANS= nodist_man4_MANS= nodist_man5_MANS= nodist_man6_MANS= nodist_man7_MANS= nodist_man8_MANS= nodist_man9_MANS= notrans_dist_man_MANS= MANLINKS= info_TEXINFOS= doc_DATA= dist_doc_DATA= html_DATA= dist_html_DATA= dist_bin_SCRIPTS= bin_PROGRAMS= && \
	make -j 1 install sbin_PROGRAMS= noinst_PROGRAMS= check_PROGRAMS= man_MANS= man1_MANS= man2_MANS= man3_MANS= man4_MANS= man5_MANS= man6_MANS= man7_MANS= man8_MANS= man9_MANS= dist_man_MANS= dist_man1_MANS= dist_man2_MANS= dist_man3_MANS= dist_man4_MANS= dist_man5_MANS= dist_man6_MANS= dist_man7_MANS= dist_man8_MANS= dist_man9_MANS= nodist_man_MANS= nodist_man1_MANS= nodist_man2_MANS= nodist_man3_MANS= nodist_man4_MANS= nodist_man5_MANS= nodist_man6_MANS= nodist_man7_MANS= nodist_man8_MANS= nodist_man9_MANS= notrans_dist_man_MANS= MANLINKS= info_TEXINFOS= doc_DATA= dist_doc_DATA= html_DATA= dist_html_DATA= dist_bin_SCRIPTS= bin_PROGRAMS=

clean:
	rm -rf tiff-4.5.1

