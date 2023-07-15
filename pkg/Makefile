SUPPL := giflib-sourceforge-mingw-master.zip glib_subprojects.tar.xz libpcre-8.41.tar.xz

GTK_SRC_PKGS := atk-2.36.0.tar.xz bzip2-1.0.8.tar.gz cairo-1.17.6.tar.xz expat-2.4.8.tar.bz2 fontconfig-2.14.2.tar.xz freetype-2.12.1.tar.xz fribidi-v1.0.11.tar.gz gdk-pixbuf-2.42.6.tar.xz gettext-0.22.tar.lz glib-2.76.3.tar.xz gtk+-2.24.33.tar.xz harfbuzz-7.3.0.tar.xz icu4c-release-66.1.tar.gz jasper-version-3.0.6.tar.gz jpegsrc.v9e.tar.gz libffi-3.4.4.tar.gz libiconv-1.17.tar.gz libpng-1.6.40.tar.xz libwebp-1.2.2.tar.gz lzo-2.10.tar.gz pango-1.50.11.tar.xz pixman-0.42.2.tar.gz tiff-4.4.0.tar.xz xz-5.2.5.tar.gz zlib-1.2.13.tar.xz



all: $(GTK_SRC_PKGS)
 	

atk-2.36.0.tar.xz:
	wget https://download.gnome.org/sources/atk/2.36/atk-2.36.0.tar.xz

bzip2-1.0.8.tar.gz:
	wget https://sourceware.org/pub/bzip2/bzip2-1.0.8.tar.gz

cairo-1.17.6.tar.xz:
	wget https://www.cairographics.org/snapshots/cairo-1.17.6.tar.xz

expat-2.4.8.tar.bz2:
	wget https://github.com/libexpat/libexpat/releases/download/R_2_4_8/expat-2.4.8.tar.bz2

fontconfig-2.14.2.tar.xz:
	wget https://www.freedesktop.org/software/fontconfig/release/fontconfig-2.14.2.tar.xz

freetype-2.12.1.tar.xz:
	wget https://sourceforge.net/projects/freetype/files/freetype2/2.12.1/freetype-2.12.1.tar.xz

fribidi-v1.0.11.tar.gz:
	wget https://github.com/fribidi/fribidi/archive/refs/tags/v1.0.11.tar.gz -O fribidi-v1.0.11.tar.gz

gdk-pixbuf-2.42.6.tar.xz:
	wget https://download.gnome.org/sources/gdk-pixbuf/2.42/gdk-pixbuf-2.42.6.tar.xz

gettext-0.22.tar.lz:
	wget https://ftp.gnu.org/gnu/gettext/gettext-0.22.tar.lz

glib-2.76.3.tar.xz:
	wget https://download.gnome.org/sources/glib/2.76/glib-2.76.3.tar.xz

gtk+-2.24.33.tar.xz:
	wget https://download.gnome.org/sources/gtk+/2.24/gtk%2B-2.24.33.tar.xz

harfbuzz-7.3.0.tar.xz:
	wget https://github.com/harfbuzz/harfbuzz/releases/download/7.3.0/harfbuzz-7.3.0.tar.xz

icu4c-release-66.1.tar.gz:
	wget https://pkg.mxe.cc/pkg/icu4c-release-66.1.tar.gz

jasper-version-3.0.6.tar.gz:
	wget https://github.com/jasper-software/jasper/archive/version-3.0.6/jasper-version-3.0.6.tar.gz

jpegsrc.v9e.tar.gz:
	wget http://www.ijg.org/files/jpegsrc.v9e.tar.gz

libffi-3.4.4.tar.gz:
	wget https://github.com/libffi/libffi/releases/download/v3.4.4/libffi-3.4.4.tar.gz

libiconv-1.17.tar.gz:
	wget https://ftp.gnu.org/gnu/libiconv/libiconv-1.17.tar.gz

libpng-1.6.40.tar.xz:
	wget https://sourceforge.net/projects/libpng/files/libpng16/1.6.40/libpng-1.6.40.tar.xz

libwebp-1.2.2.tar.gz:
	wget http://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-1.2.2.tar.gz

lzo-2.10.tar.gz:
	wget https://www.oberhumer.com/opensource/lzo/download/lzo-2.10.tar.gz

pango-1.50.11.tar.xz:
	wget https://download.gnome.org/sources/pango/1.50/pango-1.50.11.tar.xz

pixman-0.42.2.tar.gz:
	wget https://www.cairographics.org/releases/pixman-0.42.2.tar.gz

tiff-4.4.0.tar.xz:
	wget https://download.osgeo.org/libtiff/tiff-4.4.0.tar.xz

xz-5.2.5.tar.gz:
	wget https://tukaani.org/xz/xz-5.2.5.tar.gz

zlib-1.2.13.tar.xz:
	wget https://github.com/madler/zlib/releases/download/v1.2.13/zlib-1.2.13.tar.xz


clean:
	rm -f $(GTK_SRC_PKGS)

.PHONY: all clean
