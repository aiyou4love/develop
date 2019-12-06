@echo off
call build-setting.bat
call %VC_ENV%
%CUR_DRIVE%
cd %CUR_DIR%
if not exist %CURL_NAME% (
	REM 7z.exe x %CURL_NAME%.zip
	7z x -so %CURL_NAME%.tar.bz2 | 7z x -si -ttar
)
cd %CURL_NAME%\winbuild
nmake /f Makefile.vc mode=dll MACHINE=x64
xcopy /r /e /y ..\builds\libcurl-vc-x64-release-dll-ipv6-sspi-winssl\include ..\..\..\..\..\includes\
copy /Y ..\builds\libcurl-vc-x64-release-dll-ipv6-sspi-winssl\lib\libcurl.lib ..\..\..\..\..\libraries\win64\curl.lib
copy /Y ..\builds\libcurl-vc-x64-release-dll-ipv6-sspi-winssl\bin\libcurl.dll ..\..\..\..\..\binaries\win64\libcurl.dll
cd ..\..
rd /s /q %CURL_NAME%
pause
@echo on
