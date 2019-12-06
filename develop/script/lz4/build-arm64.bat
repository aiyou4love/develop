@echo off
call build-setting.bat
%CUR_DRIVE%
cd %CUR_DIR%
rd /s /q ..\..\..\includes\lz4
del /f /s /q ..\..\..\libraries\arm64\liblz4.a
rd /s /q lz4.arm64
pscp.exe -p -r -v -pw %LINUX_PWD% %CURL_NAME%.zip %BUILD_SH64%.sh %LINUX_NAME%@%LINUX_IP%:/home/%LINUX_NAME%
echo export NDK_ROOT=/home/%LINUX_NAME%/%NDK_DIR%>>build.txt
echo unzip %CURL_NAME%.zip>>build.txt
echo rm -rf %CURL_NAME%.zip>>build.txt
echo chmod a+x %BUILD_SH64%.sh>>build.txt
echo . ./%BUILD_SH64%.sh>>build.txt
echo cd %CURL_DIR%>>build.txt
echo make>>build.txt
echo make DESTDIR=/home/%LINUX_NAME%/lz4.arm64 install>>build.txt
echo cd ..>>build.txt
echo rm -rf %CURL_DIR%>>build.txt
echo rm -rf %BUILD_SH64%.sh>>build.txt
plink -v -m build.txt %LINUX_NAME%@%LINUX_IP% -pw %LINUX_PWD%
pscp.exe -p -r -v -pw %LINUX_PWD% %LINUX_NAME%@%LINUX_IP%:/home/%LINUX_NAME%/lz4.arm64 .
del /f /s /q build.txt
xcopy /r /e /y lz4.arm64\include ..\..\..\includes\
copy /y lz4.arm64\lib\liblz4.a ..\..\..\libraries\arm64\liblz4.a
pause
@echo on
