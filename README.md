# GTK+-2.24.33-win-static-library-builder
+ Build tool for Windows, using [MXE](https://mxe.cc/) patches.
+ Pre-compiled static library files built by MinGW-w64 gcc 8.1.0 in [release page](https://github.com/kitanokitsune/gtk2.24-win-static-library-builder/releases). It is useful to build [gerbv](https://github.com/gerbv/gerbv).  

(v1.2) Stability problem ([issue #1](https://github.com/kitanokitsune/gtk2.24-win-static-library-builder/issues/1)) was fixed by [wjaguar's patch](https://github.com/wjaguar/mtPaint/blob/master/gtk/gtk22429_1wj.patch).


## Requirement to build
+ [**7-Zip**](https://www.7-zip.org/) ( C\:\\Program Files\\7-Zip\\7z.exe )
+ [**MSYS2 environment**](https://www.msys2.org/) with appropriate packages (`pacman -S make autotools gettext-devel gperf patch unzip lzip` for _msys_, `pacman -S mingw-w64-i686-meson mingw-w64-i686-ninja mingw-w64-i686-cmake mingw-w64-i686-make` for _mingw32_, `pacman -S mingw-w64-x86_64-meson mingw-w64-x86_64-ninja mingw-w64-x86_64-cmake mingw-w64-x86_64-make` for _mingw64_)
+ **MinGW-w64 gcc and g++** compilers\: [i686-8.1.0-release-win32-dwarf-rt_v6-rev0](https://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win32/Personal%20Builds/mingw-builds/8.1.0/threads-win32/dwarf/) and [x86_64-8.1.0-release-win32-seh-rt_v6-rev0](https://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win64/Personal%20Builds/mingw-builds/8.1.0/threads-win32/seh/) are tested.

## Build and Install
1. Clone this project or download the project as a ZIP file and unzip it.  
2. Edit variables `SEVENZIPBINPATH` and `CPUARCH` in __Makefile__ if needed.  
3. Set desired installation path to `GTK_PREFIX` variable in __Makefile__.  
4. Run bash with administrative privileges (Right click __mingw32.exe__ or __mingw64.exe__ and *run as Administrator*).
5. In the bash, go to the project direcotry and start build & installation by `make everything`.
6. Wait for hours until finish.

## Use the library in MSYS2
If you use the library in *MSYS2*, execute `source ${GTK_PREFIX}/gtkvars.sh` to set environment variables.

