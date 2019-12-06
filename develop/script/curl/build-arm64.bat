@echo off
call build-setting.bat
%CUR_DRIVE%
cd %CUR_DIR%
rd /s /q ..\..\..\includes\curl
del /f /s /q ..\..\..\libraries\arm64\libcurl.a
rd /s /q curl.arm64
pscp.exe -p -r -v -pw %LINUX_PWD% %CURL_NAME%.zip %BUILD_SH64%.sh %LINUX_NAME%@%LINUX_IP%:/home/%LINUX_NAME%
echo export NDK_ROOT=/home/%LINUX_NAME%/%NDK_DIR%>>build.txt
echo unzip %CURL_NAME%.zip>>build.txt
echo rm -rf %CURL_NAME%.zip>>build.txt
echo chmod a+x %BUILD_SH64%.sh>>build.txt
echo . ./%BUILD_SH64%.sh>>build.txt
echo cd %CURL_DIR%>>build.txt
echo ./configure --host=aarch64-linux-android --target=aarch64-linux-android \>>build.txt
echo             --prefix=/home/%LINUX_NAME%/curl.arm64 \>>build.txt
echo             --with-ssl=%SSL64_PATH% \>>build.txt
echo             --enable-static \>>build.txt
echo             --disable-shared \>>build.txt
echo             --disable-verbose \>>build.txt
echo             --enable-threaded-resolver \>>build.txt
echo             --enable-ipv6>>build.txt
echo make>>build.txt
echo make install>>build.txt
echo cd ..>>build.txt
echo rm -rf %CURL_DIR%>>build.txt
echo rm -rf %BUILD_SH64%.sh>>build.txt
plink -v -m build.txt %LINUX_NAME%@%LINUX_IP% -pw %LINUX_PWD%
pscp.exe -p -r -v -pw %LINUX_PWD% %LINUX_NAME%@%LINUX_IP%:/home/%LINUX_NAME%/curl.arm64 .
del /f /s /q build.txt
xcopy /r /e /y curl.arm64\include ..\..\..\includes\
copy /y curl.arm64\lib\libcurl.a ..\..\..\libraries\arm64\libcurl.a
pause
@echo on
