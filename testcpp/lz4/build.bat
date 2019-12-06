@echo off
if not exist build (
    mkdir build
)
cd build
cmake .. -G"Visual Studio 15 2017 Win64" -DARCH_NAME=win64
cmake --build . --config Debug
call Debug\startup.exe
pause
@echo on
