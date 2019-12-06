@echo off
call build-setting.bat
call %VC_ENV%
%CUR_DRIVE%
cd %CUR_DIR%
if not exist boost (
	7z x -so %BOOST_NAME%.tar.bz2 | 7z x -si -ttar
	ren %BOOST_DIR% boost
)
cd boost
call bootstrap.bat
b2 stage address-model=64 link=static runtime-link=shared threading=multi debug
xcopy /r /e /y boost ..\..\..\..\includes\boost\
copy /y stage\lib\libboost*.lib ..\..\..\..\libraries\win64\libboost*.lib
cd ..
pause
@echo on
