# Makefile for the GIFLIB package for Windows
.SUFFIXES: .c .o

OFLAGS = -O0 -g
OFLAGS  = -O2
#CFLAGS  = -std=gnu99 -fPIC -Wall -Wno-format-truncation $(OFLAGS)
CFLAGS  = -Wall

SHELL = /bin/sh
TAR = tar
INSTALL = install

PREFIX = /usr/local
BINDIR = $(PREFIX)/bin
INCDIR = $(PREFIX)/include
LIBDIR = $(PREFIX)/lib
MANDIR = $(PREFIX)/share/man

# No user-serviceable parts below this line

VERSION:=$(shell ./getversion)
LIBMAJOR=7
LIBMINOR=2
LIBPOINT=0
LIBVER=$(LIBMAJOR).$(LIBMINOR).$(LIBPOINT)

SOURCES = dgif_lib.c egif_lib.c gifalloc.c gif_err.c gif_font.c \
	gif_hash.c openbsd-reallocarray.c
HEADERS = gif_hash.h  gif_lib.h  gif_lib_private.h
OBJECTS = $(SOURCES:.c=.o)

USOURCES = qprintf.c quantize.c getarg.c 
UHEADERS = getarg.h
UOBJECTS = $(USOURCES:.c=.o)

# Some utilities are installed
INSTALLABLE = \
	gif2rgb \
	gifbuild \
	giffix \
	giftext \
	giftool \
	gifclrmp

# Some utilities are only used internally for testing.
# There is a parallel list in doc/Makefile.
# These are all candidates for removal in future releases.
UTILS = $(INSTALLABLE) \
	gifbg \
	gifcolor \
	gifecho \
	giffilter \
	gifhisto \
	gifinto \
	gifsponge \
	gifwedge

LDLIBS=-static libgif.a -lm

all: libgif.dll libgif.a libutil.dll libutil.a $(UTILS)
	$(MAKE) -C doc

$(UTILS):: libgif.a libutil.a

libgif.dll: $(OBJECTS) $(HEADERS)
	$(CC) $(CFLAGS) -shared $(LDFLAGS) -Wl,--out-implib,libgif.dll.$(LIBMAJOR) -o libgif.dll $(OBJECTS)

libgif.a: $(OBJECTS) $(HEADERS) libgif.dll
	$(AR) rcs libgif.a $(OBJECTS)

libutil.dll: $(UOBJECTS) $(UHEADERS)
	$(CC) $(CFLAGS) -shared $(LDFLAGS) -Wl,--out-implib,libutil.dll.$(LIBMAJOR) -o libutil.dll $(UOBJECTS) -L. -lgif

libutil.a: $(UOBJECTS) $(UHEADERS) libutil.dll
	$(AR) rcs libutil.a $(UOBJECTS)

clean:
	rm -f $(UTILS) $(TARGET) libgetarg.a libgif.a libgif.dll libutil.a libutil.dll *.o
	rm -f libgif.dll.$(LIBMAJOR).$(LIBMINOR).$(LIBPOINT)
	rm -f libgif.dll.$(LIBMAJOR)
	rm -fr doc/*.1 *.html doc/staging

check: all
	$(MAKE) -C tests

# Installation/uninstallation

install: all install-bin install-include install-lib install-man
install-bin: $(UTILS)
	$(INSTALL) -d "$(DESTDIR)$(BINDIR)"
	$(INSTALL) $^ "$(DESTDIR)$(BINDIR)"
install-include:
	$(INSTALL) -d "$(DESTDIR)$(INCDIR)"
	$(INSTALL) -m 644 gif_lib.h "$(DESTDIR)$(INCDIR)"
install-lib:
	$(INSTALL) -d "$(DESTDIR)$(LIBDIR)"
	$(INSTALL) -m 644 libgif.a "$(DESTDIR)$(LIBDIR)/libgif.a"
	$(INSTALL) -m 755 libgif.dll "$(DESTDIR)$(LIBDIR)/libgif.dll.$(LIBVER)"
	ln -sf libgif.dll.$(LIBVER) "$(DESTDIR)$(LIBDIR)/libgif.dll.$(LIBMAJOR)"
	ln -sf libgif.dll.$(LIBMAJOR) "$(DESTDIR)$(LIBDIR)/libgif.dll"

	$(INSTALL) -m 644 libutil.a "$(DESTDIR)$(LIBDIR)/libutil.a"
	$(INSTALL) -m 755 libutil.dll "$(DESTDIR)$(LIBDIR)/libutil.dll.$(LIBVER)"
	ln -sf libutil.dll.$(LIBVER) "$(DESTDIR)$(LIBDIR)/libutil.dll.$(LIBMAJOR)"
	ln -sf libutil.dll.$(LIBMAJOR) "$(DESTDIR)$(LIBDIR)/libutil.dll"
install-man:
	$(INSTALL) -d "$(DESTDIR)$(MANDIR)/man1"
	$(INSTALL) -m 644 doc/*.1 "$(DESTDIR)$(MANDIR)/man1"
uninstall: uninstall-man uninstall-include uninstall-lib uninstall-bin
uninstall-bin:
	cd "$(DESTDIR)$(BINDIR)" && rm -f $(UTILS)
uninstall-include:
	rm -f "$(DESTDIR)$(INCDIR)/gif_lib.h"
uninstall-lib:
	cd "$(DESTDIR)$(LIBDIR)" && \
		rm -f libgif.a libgif.dll libgif.dll.$(LIBMAJOR) libgif.dll.$(LIBVER) \
		libutil.a libutil.dll libutil.dll.$(LIBMAJOR) libutil.dll.$(LIBVER)
uninstall-man:
	cd "$(DESTDIR)$(MANDIR)/man1" && rm -f $(shell cd doc >/dev/null && echo *.1)

# Make distribution tarball
#
# We include all of the XML, and also generated manual pages
# so people working from the distribution tarball won't need xmlto.

EXTRAS =     README \
	     NEWS \
	     TODO \
	     COPYING \
	     getversion \
	     ChangeLog \
	     build.adoc \
	     history.adoc \
	     control \
	     doc/whatsinagif \
	     doc/gifstandard \

DSOURCES = Makefile *.[ch]
DOCS = doc/*.xml doc/*.1 doc/*.html doc/index.html.in doc/00README doc/Makefile
ALL =  $(DSOURCES) $(DOCS) tests pic $(EXTRAS)
giflib-$(VERSION).tar.gz: $(ALL)
	$(TAR) --transform='s:^:giflib-$(VERSION)/:' -czf giflib-$(VERSION).tar.gz $(ALL)
giflib-$(VERSION).tar.bz2: $(ALL)
	$(TAR) --transform='s:^:giflib-$(VERSION)/:' -cjf giflib-$(VERSION).tar.bz2 $(ALL)

dist: giflib-$(VERSION).tar.gz giflib-$(VERSION).tar.bz2

# build-dist
build-dist:
	cd "$(DESTDIR)$(PREFIX)" && \
	$(TAR) --transform='s:^:giflib-$(VERSION)/:' -czf giflib-$(VERSION).tar.gz *

# Auditing tools.

# Check that getversion hasn't gone pear-shaped.
version:
	@echo $(VERSION)

# cppcheck should run clean
cppcheck:
	cppcheck --inline-suppr --template gcc --enable=all --suppress=unusedFunction --force *.[ch]

# Verify the build
distcheck: all
	$(MAKE) giflib-$(VERSION).tar.gz
	tar xzvf giflib-$(VERSION).tar.gz
	$(MAKE) -C giflib-$(VERSION)
	rm -fr giflib-$(VERSION)

# release using the shipper tool
release: all distcheck
	$(MAKE) -C doc website
	shipper --no-stale version=$(VERSION) | sh -e -x
	rm -fr doc/staging

# Refresh the website
refresh: all
	$(MAKE) -C doc website
	shipper --no-stale -w version=$(VERSION) | sh -e -x
	rm -fr doc/staging
