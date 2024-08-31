# gtk+-2.24.33-win-static-library-builder
GTK+-2.24.33 Static Library Build Tool for Windows using [MXE](https://mxe.cc/) patches,  
 and  
Complete Static Library Files built by gcc 8.1.0 in [release page](https://github.com/kitanokitsune/gtk2.24-win-static-library-builder/releases)  

It is useful to build [gerbv](https://github.com/gerbv/gerbv).

## Requirement to build
+ [**7-zip**](https://www.7-zip.org/) ( C\:\\Program Files\\7-Zip\\7z.exe )
+ [**msys2 environment**](https://www.msys2.org/) with appropriate packages (`pacman -S make autotools gettext-devel gperf patch unzip lzip` for _msys_, `pacman -S mingw-w64-i686-meson mingw-w64-i686-ninja mingw-w64-i686-cmake mingw-w64-i686-make` for _mingw32_, `pacman -S mingw-w64-x86_64-meson mingw-w64-x86_64-ninja mingw-w64-x86_64-cmake mingw-w64-x86_64-make` for _mingw64_)
+ **mingw-w64 gcc and g++** compilers\: [i686-8.1.0-release-win32-dwarf-rt_v6-rev0](https://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win32/Personal%20Builds/mingw-builds/8.1.0/threads-win32/dwarf/) and [x86_64-8.1.0-release-win32-seh-rt_v6-rev0](https://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win64/Personal%20Builds/mingw-builds/8.1.0/threads-win32/seh/) are tested.

## Build and Install
1. Clone this project  
2. Edit variables `SEVENZIPBINPATH` and `CPUARCH` in _Makefile_ appropriately  
3. Set installation path to `GTK_PREFIX` variable in _Makefile_  
4. Run _mingw32.exe_ (32bit) / _mingw64.exe_ (64bit) ***as administrator***,  then `make everything` in it
5. Wait for hours until completion

## Use the library
Execute `source ${GTK_PREFIX}/gtkvars.sh` to set environment variables before use the library

