@echo off
call build-setting.bat
%CUR_DRIVE%
cd %CUR_DIR%
del /f /s /q ..\..\..\libraries\armv7\libboost*.a
if not exist boost (
	7z.exe x %BOOST_NAME%
	ren %BOOST_DIR% boost
)
if not exist build.armv7 (
	mkdir build.armv7
)
cd build.armv7
cmake ../cmake -G"Ninja" -DCMAKE_TOOLCHAIN_FILE=../../../cmake/armv7-droid.cmake
cmake --build . --config %PRJ_CFG% --clean-first
copy /y exception\libboost_exception.a ..\..\..\..\libraries\armv7\libboost_exception.a
copy /y system\libboost_system.a ..\..\..\..\libraries\armv7\libboost_system.a
copy /y date_time\libboost_date_time.a ..\..\..\..\libraries\armv7\libboost_date_time.a
cd ..
pause
@echo on
