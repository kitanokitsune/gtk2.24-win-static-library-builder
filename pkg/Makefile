SUPPL := giflib-sourceforge-mingw-master.zip glib_subprojects.tar.xz libpcre-8.41.tar.xz

GTK_SRC_PKGS := atk-2.38.0.tar.xz bzip2-1.0.8.tar.gz cairo-1.17.4.tar.xz expat-2.5.0.tar.bz2 fontconfig-2.14.2.tar.xz freetype-2.13.1.tar.xz fribidi-1.0.13.tar.xz gdk-pixbuf-2.42.10.tar.xz gettext-0.22.tar.lz glib-2.76.3.tar.xz gtk+-2.24.33.tar.xz harfbuzz-7.3.0.tar.xz icu4c-74_2-src.tgz jasper-4.0.0.tar.gz jpegsrc.v9e.tar.gz libffi-3.4.4.tar.gz libiconv-1.17.tar.gz libpng-1.6.40.tar.xz libwebp-1.3.1.tar.gz lzo-2.10.tar.gz pango-1.50.11.tar.xz pixman-0.42.2.tar.gz tiff-4.5.1.tar.xz xz-5.6.2.tar.xz zlib-1.2.13.tar.xz



all: $(GTK_SRC_PKGS)
 	

atk-2.38.0.tar.xz:
	wget https://download.gnome.org/sources/atk/2.38/atk-2.38.0.tar.xz

bzip2-1.0.8.tar.gz:
	wget https://sourceware.org/pub/bzip2/bzip2-1.0.8.tar.gz

cairo-1.17.4.tar.xz:
	wget https://www.cairographics.org/snapshots/cairo-1.17.4.tar.xz

expat-2.5.0.tar.bz2:
	wget https://github.com/libexpat/libexpat/releases/download/R_2_5_0/expat-2.5.0.tar.bz2

fontconfig-2.14.2.tar.xz:
	wget https://www.freedesktop.org/software/fontconfig/release/fontconfig-2.14.2.tar.xz

freetype-2.13.1.tar.xz:
	wget https://sourceforge.net/projects/freetype/files/freetype2/2.13.1/freetype-2.13.1.tar.xz

fribidi-1.0.13.tar.xz:
	wget https://github.com/fribidi/fribidi/releases/download/v1.0.13/fribidi-1.0.13.tar.xz

gdk-pixbuf-2.42.10.tar.xz:
	wget https://download.gnome.org/sources/gdk-pixbuf/2.42/gdk-pixbuf-2.42.10.tar.xz

gettext-0.22.tar.lz:
	wget https://ftp.gnu.org/gnu/gettext/gettext-0.22.tar.lz

glib-2.76.3.tar.xz:
	wget https://download.gnome.org/sources/glib/2.76/glib-2.76.3.tar.xz

gtk+-2.24.33.tar.xz:
	wget https://download.gnome.org/sources/gtk+/2.24/gtk%2B-2.24.33.tar.xz

harfbuzz-7.3.0.tar.xz:
	wget https://github.com/harfbuzz/harfbuzz/releases/download/7.3.0/harfbuzz-7.3.0.tar.xz

icu4c-74_2-src.tgz:
	wget https://github.com/unicode-org/icu/releases/download/release-74-2/icu4c-74_2-src.tgz

jasper-4.0.0.tar.gz:
	wget https://github.com/jasper-software/jasper/releases/download/version-4.0.0/jasper-4.0.0.tar.gz

jpegsrc.v9e.tar.gz:
	wget http://www.ijg.org/files/jpegsrc.v9e.tar.gz

libffi-3.4.4.tar.gz:
	wget https://github.com/libffi/libffi/releases/download/v3.4.4/libffi-3.4.4.tar.gz

libiconv-1.17.tar.gz:
	wget https://ftp.gnu.org/gnu/libiconv/libiconv-1.17.tar.gz

libpng-1.6.40.tar.xz:
	wget https://sourceforge.net/projects/libpng/files/libpng16/1.6.40/libpng-1.6.40.tar.xz

libwebp-1.3.1.tar.gz:
	wget https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-1.3.1.tar.gz

lzo-2.10.tar.gz:
	wget https://www.oberhumer.com/opensource/lzo/download/lzo-2.10.tar.gz

pango-1.50.11.tar.xz:
	wget https://download.gnome.org/sources/pango/1.50/pango-1.50.11.tar.xz

pixman-0.42.2.tar.gz:
	wget https://www.cairographics.org/releases/pixman-0.42.2.tar.gz

tiff-4.5.1.tar.xz:
	wget https://download.osgeo.org/libtiff/tiff-4.5.1.tar.xz

xz-5.6.2.tar.xz:
	wget https://github.com/tukaani-project/xz/releases/download/v5.6.2/xz-5.6.2.tar.xz

zlib-1.2.13.tar.xz:
	wget https://github.com/madler/zlib/releases/download/v1.2.13/zlib-1.2.13.tar.xz


clean:
	rm -f $(GTK_SRC_PKGS)

.PHONY: all clean
