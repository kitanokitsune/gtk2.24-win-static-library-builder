# gtk2.24-win-static-library-builder
Build tool of gtk+-2.24.33 static library for windows, using [MXE](https://mxe.cc/) patches.  
It is useful to build [gerbv](https://github.com/gerbv/gerbv).

## Requirement
+ 7-zip ( C\:\\Program Files\\7-Zip\\7z.exe )
+ msys2 environment (bash, make, mingw32-make, cmake, meson, ninja, etc.)
+ mingw-w64 gcc and g++ \: [**i686-8.1.0-release-win32-dwarf-rt_v6-rev0**](https://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win32/Personal%20Builds/mingw-builds/8.1.0/threads-win32/dwarf/) and [**x86_64-8.1.0-release-win32-seh-rt_v6-rev0**](https://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win64/Personal%20Builds/mingw-builds/8.1.0/threads-win32/seh/) are tested.

## How to build
1. Clone this project  
2. Edit `SEVENZIPBINPATH`, `CPUARCH` and `GTK_PREFIX` variables in **Makefile** file  
3. Run msys2 (bash) ***as administrator***,  then `make` in the msys2 (bash)
4. Wait for hours

## How to use the library
Exec `source ${GTK_PREFIX}/gtkvars.sh` before use

