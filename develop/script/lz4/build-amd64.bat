@echo off
call build-setting.bat
%CUR_DRIVE%
cd %CUR_DIR%
rd /s /q ..\..\..\includes\lz4
del /f /s /q ..\..\..\libraries\amd64\liblz4.a
rd /s /q lz4.amd64
pscp.exe -p -r -v -pw %LINUX_PWD% %CURL_NAME%.tar.gz %LINUX_NAME%@%LINUX_IP%:/home/%LINUX_NAME%
echo source /opt/rh/devtoolset-7/enable>>build.txt
echo tar -xzvf %CURL_NAME%.tar.gz>>build.txt
echo rm -rf %CURL_NAME%.zip>>build.txt
echo cd %CURL_DIR%>>build.txt
echo make>>build.txt
echo make DESTDIR=/home/%LINUX_NAME%/lz4.amd64 install>>build.txt
echo cd ..>>build.txt
echo rm -rf %CURL_DIR%>>build.txt
plink -v -m build.txt %LINUX_NAME%@%LINUX_IP% -pw %LINUX_PWD%
pscp.exe -p -r -v -pw %LINUX_PWD% %LINUX_NAME%@%LINUX_IP%:/home/%LINUX_NAME%/lz4.amd64 .
del /f /s /q build.txt
xcopy /r /e /y lz4.amd64\include ..\..\..\includes\
copy /y lz4.amd64\lib\liblz4.a ..\..\..\libraries\amd64\liblz4.a
pause
@echo on
