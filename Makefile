SEVENZIPBINPATH = /c/Program\ Files/7-Zip/7z.exe
#CPUARCH ?= i686
CPUARCH ?= x86_64
GTK_PREFIX ?= /gtk2-dev

CMAKEBINPATH = $(abspath $(shell which cmake))
CMAKEPREFIX = $(patsubst %/bin/,%,$(dir ${CMAKEBINPATH}))

TOOLCHAIN_ARCH = $(CPUARCH)-w64-mingw32
TOOLCHAINPREFIX = $(patsubst %/bin/,%,$(dir $(abspath $(shell which $(TOOLCHAIN_ARCH)-g++))))

PATH := ${GTK_PREFIX}/bin:${PATH}
CPATH = ${GTK_PREFIX}/include
C_INCLUDE_PATH = ${GTK_PREFIX}/include
CPLUS_INCLUDE_PATH = ${GTK_PREFIX}/include
LIBRARY_PATH = ${GTK_PREFIX}/lib:${TOOLCHAINPREFIX}/lib
LD_LIBRARY_PATH=${GTK_PREFIX}/lib:${TOOLCHAINPREFIX}/lib
PKG_CONFIG_PATH = ${GTK_PREFIX}/lib/pkgconfig
PKG_CONFIG_LIBDIR = ${GTK_PREFIX}/lib/pkgconfig
#PKG_CONFIG="pkg-config --static"

ifeq ($(JOBS), )
	JOBS := $(shell expr `grep cpu.cores /proc/cpuinfo | sort -u | sed 's/[^0-9]//g'` + 1 )
endif

export TOOLCHAIN_ARCH
export CC=$(TOOLCHAIN_ARCH)-gcc
export CXX=$(TOOLCHAIN_ARCH)-g++
export GTK_PREFIX
export SEVENZIPBINPATH
export JOBS
export PATH
export CPATH
export C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH
export LIBRARY_PATH
export LD_LIBRARY_PATH
export PKG_CONFIG_PATH
export PKG_CONFIG_LIBDIR
export PKG_CONFIG
export CPUARCH

ALL_TARGETS := atk bzip2 cairo expat fontconfig freetype freetype-bootstrap fribidi gdk-pixbuf gettext giflib glib gtk2 harfbuzz icu4c jasper jpeg libiconv libpng libwebp lzo pango pixman tiff xz zlib

.PHONY: all clean cleanall dlpkg gtkvars test strip fixpc fixla

define CLEAN_PROJECT
	$(shell echo "----------------" 1>&2 && echo "make -f ./mk/$(1).makefile clean" 1>&2 && make -f ./mk/$(1).makefile clean 1>&2)
endef






all: dlpkg gtk2 gtkvars

dlpkg: ./pkg/Makefile
	cd ./pkg && \
	make && \
	cd ..

gtkvars: ./src/_gtkvars.sh
	@echo "#!/bin/bash" > ./gtkvars.sh
	@echo "GTK2DIR=$(GTK_PREFIX)" >> ./gtkvars.sh
	@cat ./src/_gtkvars.sh >> ./gtkvars.sh
	cp -f ./gtkvars.sh $(GTK_PREFIX)

test:
	@echo "" 1>&2
	@echo "========= $(@F) =========" 1>&2
	@echo $(JOBS) 1>&2

strip:
	@echo "" 1>&2
	@echo "========= $(@F) =========" 1>&2
	$(foreach x,$(shell ls $(GTK_PREFIX)/bin/*.exe),strip $(x) 1>&2; )

fixpc:
	@echo "" 1>&2
	@echo "========= $(@F) =========" 1>&2
	./src/_fixpc.sh ${GTK_PREFIX}

fixla:
	@echo "" 1>&2
	@echo "========= $(@F) =========" 1>&2
	./src/_fixla.sh ${GTK_PREFIX}

atk: ./mk/atk.makefile glib
	@echo "" 1>&2
	@echo "========= $(@F) =========" 1>&2
	rm -f $(@F) && \
	make -f ./mk/$(@F).makefile $(@F) && \
	touch $(@F) && \
	make -f ./mk/$(@F).makefile clean

bzip2: ./mk/bzip2.makefile
	@echo "" 1>&2
	@echo "========= $(@F) =========" 1>&2
	rm -f $(@F) && \
	make -f ./mk/$(@F).makefile $(@F) && \
	touch $(@F) && \
	make -f ./mk/$(@F).makefile clean

cairo: ./mk/cairo.makefile fontconfig freetype-bootstrap glib libpng lzo pixman zlib
	@echo "" 1>&2
	@echo "========= $(@F) =========" 1>&2
	rm -f $(@F) && \
	make -f ./mk/$(@F).makefile $(@F) && \
	touch $(@F) && \
	make -f ./mk/$(@F).makefile clean

expat: ./mk/expat.makefile
	@echo "" 1>&2
	@echo "========= $(@F) =========" 1>&2
	rm -f $(@F) && \
	make -f ./mk/$(@F).makefile $(@F) && \
	touch $(@F) && \
	make -f ./mk/$(@F).makefile clean

fontconfig: ./mk/fontconfig.makefile bzip2 expat freetype-bootstrap gettext libpng
	@echo "" 1>&2
	@echo "========= $(@F) =========" 1>&2
	rm -f $(@F) && \
	make -f ./mk/$(@F).makefile $(@F) && \
	touch $(@F) && \
	make -f ./mk/$(@F).makefile clean

freetype: ./mk/freetype.makefile bzip2 harfbuzz libpng zlib
	@echo "" 1>&2
	@echo "========= $(@F) =========" 1>&2
	./src/_chkroot.sh
	rm -f $(@F) && \
	make -f ./mk/$(@F).makefile $(@F) && \
	touch $(@F) && \
	make -f ./mk/$(@F).makefile clean

freetype-bootstrap: ./mk/freetype-bootstrap.makefile
	@echo "" 1>&2
	@echo "========= $(@F) =========" 1>&2
	rm -f $(@F) && \
	make -f ./mk/$(@F).makefile $(@F) && \
	touch $(@F) && \
	make -f ./mk/$(@F).makefile clean

fribidi: ./mk/fribidi.makefile
	@echo "" 1>&2
	@echo "========= $(@F) =========" 1>&2
	rm -f $(@F) && \
	make -f ./mk/$(@F).makefile $(@F) && \
	touch $(@F) && \
	make -f ./mk/$(@F).makefile clean

gdk-pixbuf: ./mk/gdk-pixbuf.makefile glib jasper jpeg libiconv libpng tiff
	@echo "" 1>&2
	@echo "========= $(@F) =========" 1>&2
	./src/_chkroot.sh
	rm -f $(@F) && \
	make -f ./mk/$(@F).makefile $(@F) && \
	touch $(@F) && \
	make -f ./mk/$(@F).makefile clean

gettext: ./mk/gettext.makefile libiconv
	@echo "" 1>&2
	@echo "========= $(@F) =========" 1>&2
	rm -f $(@F) && \
	make -f ./mk/$(@F).makefile $(@F) && \
	touch $(@F) && \
	make -f ./mk/$(@F).makefile clean

giflib: ./mk/giflib.makefile
	@echo "" 1>&2
	@echo "========= $(@F) =========" 1>&2
	rm -f $(@F) && \
	make -f ./mk/$(@F).makefile $(@F) && \
	touch $(@F) && \
	make -f ./mk/$(@F).makefile clean

glib: ./mk/glib.makefile gettext libiconv zlib
	@echo "" 1>&2
	@echo "========= $(@F) =========" 1>&2
	rm -f $(@F) && \
	make -f ./mk/$(@F).makefile $(@F) && \
	touch $(@F) && \
	make -f ./mk/$(@F).makefile clean

gtk2: ./mk/gtk2.makefile atk cairo gdk-pixbuf gettext glib jasper jpeg libpng pango tiff
	@echo "" 1>&2
	@echo "========= $(@F) =========" 1>&2
	rm -f $(@F) && \
	make -f ./mk/$(@F).makefile $(@F) && \
	touch $(@F) && \
	make -f ./mk/$(@F).makefile clean

harfbuzz: ./mk/harfbuzz.makefile cairo freetype-bootstrap glib icu4c
	@echo "" 1>&2
	@echo "========= $(@F) =========" 1>&2
	rm -f $(@F) && \
	make -f ./mk/$(@F).makefile $(@F) && \
	touch $(@F) && \
	make -f ./mk/$(@F).makefile clean

icu4c: ./mk/icu4c.makefile
	@echo "" 1>&2
	@echo "========= $(@F) =========" 1>&2
	rm -f $(@F) && \
	make -f ./mk/$(@F).makefile $(@F) && \
	touch $(@F) && \
	make -f ./mk/$(@F).makefile clean

jasper: ./mk/jasper.makefile jpeg
	@echo "" 1>&2
	@echo "========= $(@F) =========" 1>&2
	rm -f $(@F)
	mkdir -p ${GTK_PREFIX}/share/cmake/modules
	cp -f ./src/cmake/configure_file.cmake ${GTK_PREFIX}/share/cmake/modules
	cp -f ./src/cmake/modules/* ${GTK_PREFIX}/share/cmake/modules
	mkdir -p ${GTK_PREFIX}/share/cmake/mxe-conf.d
	touch ${GTK_PREFIX}/share/cmake/mxe-conf.d/.gitkeep
	cat ./src/cmake/mxe-conf.cmake.template | sed -e "s|@CMAKEBINPATH@|${CMAKEBINPATH}|g" -e "s|@CPUARCH@|CPUARCH|g" -e "s|@CMAKEPREFIX@|${CMAKEPREFIX}|g" -e "s|@TOOLCHAINPREFIX@|${TOOLCHAINPREFIX}|g" -e "s|@TOOLCHAININCLUDE@|${TOOLCHAINPREFIX}/${TOOLCHAIN_ARCH}/include|g" -e "s|@GTKPREFIX@|${GTK_PREFIX}|g" -e "s|@TOOLCHAINARCH@|${TOOLCHAIN_ARCH}|g" > ${GTK_PREFIX}/share/cmake/mxe-conf.cmake
	make -f ./mk/$(@F).makefile $(@F) && \
	touch $(@F) && \
	make -f ./mk/$(@F).makefile clean

jpeg: ./mk/jpeg.makefile
	@echo "" 1>&2
	@echo "========= $(@F) =========" 1>&2
	rm -f $(@F) && \
	make -f ./mk/$(@F).makefile $(@F) && \
	touch $(@F) && \
	make -f ./mk/$(@F).makefile clean

libiconv: ./mk/libiconv.makefile
	@echo "" 1>&2
	@echo "========= $(@F) =========" 1>&2
	rm -f $(@F) && \
	make -f ./mk/$(@F).makefile $(@F) && \
	touch $(@F) && \
	make -f ./mk/$(@F).makefile clean

libpng: ./mk/libpng.makefile zlib
	@echo "" 1>&2
	@echo "========= $(@F) =========" 1>&2
	rm -f $(@F) && \
	make -f ./mk/$(@F).makefile $(@F) && \
	touch $(@F) && \
	make -f ./mk/$(@F).makefile clean

libwebp: ./mk/libwebp.makefile giflib jpeg libpng
	@echo "" 1>&2
	@echo "========= $(@F) =========" 1>&2
	rm -f $(@F) && \
	make -f ./mk/$(@F).makefile $(@F) && \
	touch $(@F) && \
	make -f ./mk/$(@F).makefile clean

lzo: ./mk/lzo.makefile
	@echo "" 1>&2
	@echo "========= $(@F) =========" 1>&2
	rm -f $(@F) && \
	make -f ./mk/$(@F).makefile $(@F) && \
	touch $(@F) && \
	make -f ./mk/$(@F).makefile clean

pango: ./mk/pango.makefile libpng cairo fontconfig freetype glib harfbuzz fribidi
	@echo "" 1>&2
	@echo "========= $(@F) =========" 1>&2
	rm -f $(@F) && \
	make -f ./mk/$(@F).makefile $(@F) && \
	touch $(@F) && \
	make -f ./mk/$(@F).makefile clean

pixman: ./mk/pixman.makefile libpng
	@echo "" 1>&2
	@echo "========= $(@F) =========" 1>&2
	rm -f $(@F) && \
	make -f ./mk/$(@F).makefile $(@F) && \
	touch $(@F) && \
	make -f ./mk/$(@F).makefile clean

tiff: ./mk/tiff.makefile jpeg libwebp zlib xz
	@echo "" 1>&2
	@echo "========= $(@F) =========" 1>&2
	rm -f $(@F) && \
	make -f ./mk/$(@F).makefile $(@F) && \
	touch $(@F) && \
	make -f ./mk/$(@F).makefile clean

xz: ./mk/xz.makefile
	@echo "" 1>&2
	@echo "========= $(@F) =========" 1>&2
	rm -f $(@F) && \
	make -f ./mk/$(@F).makefile $(@F) && \
	touch $(@F) && \
	make -f ./mk/$(@F).makefile clean

zlib: ./mk/zlib.makefile
	@echo "" 1>&2
	@echo "========= $(@F) =========" 1>&2
	rm -f $(@F) && \
	make -f ./mk/$(@F).makefile $(@F) && \
	touch $(@F) && \
	make -f ./mk/$(@F).makefile clean

clean_%: ./mk/%.makefile
	make -f $< clean

clean:
	@echo " make clean_PKG  (clean individual PKG)" 1>&2
	@echo "    or" 1>&2
	@echo " make cleanall   (clean all PKGs)" 1>&2

cleanall:
	$(foreach x,$(ALL_TARGETS),$(call CLEAN_PROJECT,$(x)))
	@echo "----------------------------" 1>&2
	rm -f $(ALL_TARGETS)
	rm -f gtkvars.sh

