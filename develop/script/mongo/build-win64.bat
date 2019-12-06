@echo off
call build-setting.bat
call %VC_ENV%
%CUR_DRIVE%
cd %CUR_DIR%
if not exist %CXX_DIR% (
	mkdir %CXX_DIR%
)
if not exist %C_DIR% (
	mkdir %C_DIR%
)
if not exist %MONGOC_DIR% (
	7z x %MONGOC_ARC%.tar.gz -so | 7z x -si -ttar
)
cd %MONGOC_DIR%
mkdir cmake-build
cd cmake-build
cmake .. -G"Visual Studio 15 2017 Win64" -DCMAKE_INSTALL_PREFIX=../../%C_DIR% -DCMAKE_PREFIX_PATH=../../%C_DIR%
cmake --build . --config %PRJ_CFG% --target install
cd %CUR_DIR%
if not exist %MONGO_DIR% (
	7z x %MONGO_ARC%.tar.gz -so | 7z x -si -ttar
)
cd %MONGO_DIR%/build
cmake .. -G"Visual Studio 15 2017 Win64" -DCMAKE_INSTALL_PREFIX=../../%CXX_DIR% -DCMAKE_PREFIX_PATH=%CX_DIR% -DBOOST_ROOT=%BOOST_DIR% -DCMAKE_CXX_STANDARD=11 -DCMAKE_CXX_FLAGS="/D_ENABLE_EXTENDED_ALIGNED_STORAGE /EHsc /Zc:__cplusplus"
cmake --build . --config %PRJ_CFG% --target install
cd ..
pause
@echo on
