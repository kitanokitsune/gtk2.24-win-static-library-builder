###########################################################
##                                                       ##
##   GTK+2.24.33 static library build tool for Windows   ##
##                                                       ##
## Usage: make && make strip && make fixpc && make fixla ##
##                                                       ##
###########################################################


# /-------------------/
# /   User Settings   /
# /-------------------/

### PATH TO 7-ZIP
SEVENZIPBINPATH ?= /c/Program\ Files/7-Zip/7z.exe

### CPU ARCHITECTURE [i686, x86_64]
CPUARCH?=$(MSYSTEM_CARCH)

### INSTALL PATH
GTK_PREFIX?=/gtk2-static$(MSYSTEM_PREFIX)

### NUMBER OF PROCESSES TO UTILZE (auto detect cpu cores if empty)
# JOBS?=2


# ============================================================================

GCC_THREAD_MODEL?=win32 # posix or win32. perhaps win32 is always sufficient

CMAKEBINPATH=$(abspath $(shell which cmake))
CMAKEPREFIX=$(patsubst %/bin/,%,$(dir $(CMAKEBINPATH)))

TOOLCHAIN_ARCH=$(CPUARCH)-w64-mingw32
TOOLCHAINPREFIX=$(patsubst %/bin/,%,$(dir $(abspath $(shell which $(TOOLCHAIN_ARCH)-g++))))


PATH:=$(GTK_PREFIX)/bin:$(PATH)
CPATH:=$(GTK_PREFIX)/include
C_INCLUDE_PATH:=$(GTK_PREFIX)/include
CPLUS_INCLUDE_PATH:=$(GTK_PREFIX)/include
LIBRARY_PATH:=$(GTK_PREFIX)/lib:$(TOOLCHAINPREFIX)/lib
LD_LIBRARY_PATH:=$(GTK_PREFIX)/lib:$(TOOLCHAINPREFIX)/lib
PKG_CONFIG_PATH:=$(GTK_PREFIX)/lib/pkgconfig
PKG_CONFIG_LIBDIR:=$(GTK_PREFIX)/lib/pkgconfig
CMAKE_LIBRARY_PATH:=$(GTK_PREFIX)
CMAKE_PREFIX_PATH:=$(GTK_PREFIX)

ifneq ($(strip $(shell expr 0 \< $(JOBS) + 0 2>/dev/null)),1)
  JOBS := $(shell expr `grep physical.id /proc/cpuinfo | sort -u | wc -l` \
          \* `grep cpu.cores /proc/cpuinfo | sort -u | sed 's/.\+://'` + 0 )
  ifeq ($(strip $(JOBS)),)
    JOBS := 1
  endif
endif

ifeq ($(strip $(GCC_THREAD_MODEL)),posix)
    USE_POSIX_THREAD = true
else ifeq ($(strip $(GCC_THREAD_MODEL)),win32)
    USE_POSIX_THREAD = false
else ifeq ($(strip $(GCC_THREAD_MODEL)),windows)
    USE_POSIX_THREAD = false
else
    $(error GCC_THREAD_MODEL invalid value: $(strip $(GCC_THREAD_MODEL)))
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
#export PKG_CONFIG
export CPUARCH
export USE_POSIX_THREAD
export CMAKE_LIBRARY_PATH
export CMAKE_PREFIX_PATH

ALL_TARGETS := atk bzip2 cairo expat fontconfig freetype freetype-bootstrap fribidi gdk-pixbuf gettext giflib glib gtk2 harfbuzz icu4c jasper jpeg libffi libiconv libpng libwebp lzo pango pixman tiff xz zlib

.PHONY: all clean cleanall chkreq dlpkg gtkvars test strip fixpc fixla fixbin fixharfbuzz touch everything

define CLEAN_PROJECT
	$(shell echo "----------------" 1>&2 && echo "make -f ./mk/$(1).makefile clean" 1>&2 && make -f ./mk/$(1).makefile clean USE_POSIX_THREAD=$(strip $(USE_POSIX_THREAD)) 1>&2)
endef






all: chkreq dlpkg gtk2 gtkvars

everything: all strip fixpc fixla fixbin fixharfbuzz touch

chkreq:
	@echo "" 1>&2
	@echo "========= $(@F) =========" 1>&2
	@echo "-> check 7-zip: SEVENZIPBINPATH=$(SEVENZIPBINPATH)" 1>&2
	@expr "$(SEVENZIPBINPATH)" != "" > /dev/null
	@ls $(SEVENZIPBINPATH) > /dev/null
	@$(SEVENZIPBINPATH) > /dev/null
	@echo "   OK!" 1>&2
	@echo "" 1>&2
	@echo "-> check administrative privileges" 1>&2
	@./src/_chkroot.sh 1>&2
	@echo "" 1>&2


dlpkg: ./pkg/Makefile
	@echo "" 1>&2
	@echo "========= $(@F) =========" 1>&2
	cd ./pkg && \
	make && \
	cd ..

gtkvars: ./src/_gtkvars.sh
	@echo "" 1>&2
	@echo "========= $(@F) =========" 1>&2
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
	./src/_fixpc.sh $(GTK_PREFIX)

fixla:
	@echo "" 1>&2
	@echo "========= $(@F) =========" 1>&2
	./src/_fixla.sh $(GTK_PREFIX)

fixbin:
	@echo "" 1>&2
	@echo "========= $(@F) =========" 1>&2
	./src/_fixbin.sh $(GTK_PREFIX)

fixharfbuzz:
	@echo "" 1>&2
	@echo "========= $(@F) =========" 1>&2
	./src/_fixharfbuzz.sh $(GTK_PREFIX)

touch:
	@echo "" 1>&2
	@echo "========= $(@F) =========" 1>&2
	find  $(GTK_PREFIX) -type f -exec touch {} +





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

glib: ./mk/glib.makefile gettext libffi libiconv zlib
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
	mkdir -p $(GTK_PREFIX)/share/cmake/modules
	cp -f ./src/cmake/configure_file.cmake $(GTK_PREFIX)/share/cmake/modules
	cp -f ./src/cmake/modules/* $(GTK_PREFIX)/share/cmake/modules
	mkdir -p $(GTK_PREFIX)/share/cmake/mxe-conf.d
	touch $(GTK_PREFIX)/share/cmake/mxe-conf.d/.gitkeep
	cat ./src/cmake/mxe-conf.cmake.template | sed -e "s|@CMAKEBINPATH@|$(CMAKEBINPATH)|g" -e "s|@CPUARCH@|CPUARCH|g" -e "s|@CMAKEPREFIX@|$(CMAKEPREFIX)|g" -e "s|@TOOLCHAINPREFIX@|$(TOOLCHAINPREFIX)|g" -e "s|@TOOLCHAININCLUDE@|$(TOOLCHAINPREFIX)/$(TOOLCHAIN_ARCH)/include|g" -e "s|@GTKPREFIX@|$(GTK_PREFIX)|g" -e "s|@TOOLCHAINARCH@|$(TOOLCHAIN_ARCH)|g" > $(GTK_PREFIX)/share/cmake/mxe-conf.cmake
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

libffi: ./mk/libffi.makefile
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

