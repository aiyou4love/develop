@echo off
call build-setting.bat
%CUR_DRIVE%
cd %CUR_DIR%
rd /s /q ..\..\..\includes\curl
del /f /s /q ..\..\..\libraries\armv7\libcurl.a
rd /s /q curl.arm32
pscp.exe -p -r -v -pw %LINUX_PWD% %CURL_NAME%.zip %BUILD_SH32%.sh %LINUX_NAME%@%LINUX_IP%:/home/%LINUX_NAME%
echo export NDK_ROOT=/home/%LINUX_NAME%/%NDK_DIR%>>build.txt
echo unzip %CURL_NAME%.zip>>build.txt
echo rm -rf %CURL_NAME%.zip>>build.txt
echo chmod a+x %BUILD_SH32%.sh>>build.txt
echo . ./%BUILD_SH32%.sh>>build.txt
echo cd %CURL_DIR%>>build.txt
echo ./configure --host=arm-linux-androideabi --target=arm-linux-androideabi \>>build.txt
echo             --prefix=/home/%LINUX_NAME%/curl.arm32 \>>build.txt
echo             --with-ssl=%SSL32_PATH% \>>build.txt
echo             --enable-static \>>build.txt
echo             --disable-shared \>>build.txt
echo             --disable-verbose \>>build.txt
echo             --enable-threaded-resolver \>>build.txt
echo             --enable-ipv6>>build.txt
echo make>>build.txt
echo make install>>build.txt
echo cd ..>>build.txt
echo rm -rf %CURL_DIR%>>build.txt
echo rm -rf %BUILD_SH32%.sh>>build.txt
plink -v -m build.txt %LINUX_NAME%@%LINUX_IP% -pw %LINUX_PWD%
pscp.exe -p -r -v -pw %LINUX_PWD% %LINUX_NAME%@%LINUX_IP%:/home/%LINUX_NAME%/curl.arm32 .
del /f /s /q build.txt
xcopy /r /e /y curl.arm32\include ..\..\..\includes\
copy /y curl.arm32\lib\libcurl.a ..\..\..\libraries\armv7\libcurl.a
pause
@echo on
