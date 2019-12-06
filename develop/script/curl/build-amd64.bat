@echo off
call build-setting.bat
%CUR_DRIVE%
cd %CUR_DIR%
rd /s /q ..\..\..\includes\curl
del /f /s /q ..\..\..\libraries\amd64\libcurl.a
rd /s /q curl.amd64
pscp.exe -p -r -v -pw %LINUX_PWD% %CURL_NAME%.zip %LINUX_NAME%@%LINUX_IP%:/home/%LINUX_NAME%
echo source /opt/rh/devtoolset-7/enable>>build.txt
echo unzip %CURL_NAME%.zip>>build.txt
echo rm -rf %CURL_NAME%.zip>>build.txt
echo cd %CURL_DIR%>>build.txt
echo ./configure --prefix=/home/%LINUX_NAME%/curl.amd64 \>>build.txt
echo             --with-ssl=%AMD64_PATH% \>>build.txt
echo             --enable-static \>>build.txt
echo             --disable-shared \>>build.txt
echo             --disable-verbose \>>build.txt
echo             --enable-threaded-resolver \>>build.txt
echo             --enable-ipv6>>build.txt
echo make>>build.txt
echo make install>>build.txt
echo cd ..>>build.txt
echo rm -rf %CURL_DIR%>>build.txt
plink -v -m build.txt %LINUX_NAME%@%LINUX_IP% -pw %LINUX_PWD%
pscp.exe -p -r -v -pw %LINUX_PWD% %LINUX_NAME%@%LINUX_IP%:/home/%LINUX_NAME%/curl.amd64 .
del /f /s /q build.txt
xcopy /r /e /y curl.amd64\include ..\..\..\includes\
copy /y curl.amd64\lib\libcurl.a ..\..\..\libraries\amd64\libcurl.a
pause
@echo on
