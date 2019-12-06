@echo off
call build-setting.bat
%CUR_DRIVE%
cd %CUR_DIR%
del /f /s /q ..\..\..\libraries\arm64\libboost*.a
if not exist boost (
	7z.exe x %BOOST_NAME%
	ren %BOOST_DIR% boost
)
if not exist build.arm64 (
	mkdir build.arm64
)
cd build.arm64
cmake ../cmake -G"Ninja" -DCMAKE_TOOLCHAIN_FILE=../../../cmake/arm64-droid.cmake
cmake --build . --config %PRJ_CFG% --clean-first
copy /y exception\libboost_exception.a ..\..\..\..\libraries\arm64\libboost_exception.a
copy /y system\libboost_system.a ..\..\..\..\libraries\arm64\libboost_system.a
copy /y date_time\libboost_date_time.a ..\..\..\..\libraries\arm64\libboost_date_time.a
cd ..
pause
@echo on
