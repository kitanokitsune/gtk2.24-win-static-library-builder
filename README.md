# gtk2.24-win-static-library-builder
Build gtk+2.24.33 static library for windows

## Requirement
+ 7-zip ( C\:\\Program Files\\7-Zip\\7z.exe )
+ msys2 environment (make, mingw32-make, cmake, meson, ninja, etc.)
+ mingw-w64 gcc and g++ (win32 thread model, dwarf or seh exception model) \: **i686-8.1.0-release-win32-dwarf-rt_v6-rev0** and **x86_64-8.1.0-release-win32-seh-rt_v6-rev0** are tested.

## How to build
Run msys2 (bash) as administrator  
Clone the project  
Edit `SEVENZIPBINPATH`, `CPUARCH` and `GTK_PREFIX` variables in **Makefile** file  
Then `make` in msys2 (bash)
