@echo off
call build-setting.bat
%CUR_DRIVE%
cd %CUR_DIR%
del /f /s /q ..\..\..\libraries\amd64\libcrypto.a
del /f /s /q ..\..\..\libraries\amd64\libssl.a
pscp.exe -p -r -v -pw %LINUX_PWD% %SSL_NAME%.tar.gz %LINUX_NAME%@%LINUX_IP%:/home/%LINUX_NAME%
echo source /opt/rh/devtoolset-7/enable>>build.txt
echo tar xzf %SSL_NAME%.tar.gz>>build.txt
echo rm -rf %SSL_NAME%.tar.gz>>build.txt
echo cd %SSL_DIR%>>build.txt
echo ./config no-shared no-ssl3 no-asm no-comp no-hw no-engine --prefix=/home/%LINUX_NAME%/ssl.amd64>>build.txt
echo make depend>>build.txt
echo make all>>build.txt
echo make install>>build.txt
echo cd ..>>build.txt
echo rm -rf %SSL_DIR%>>build.txt
plink -v -m build.txt %LINUX_NAME%@%LINUX_IP% -pw %LINUX_PWD%
pscp.exe -p -r -v -pw %LINUX_PWD% %LINUX_NAME%@%LINUX_IP%:/home/%LINUX_NAME%/ssl.amd64 .
del /f /s /q build.txt
copy /Y ssl.amd64\lib\libcrypto.a ..\..\..\libraries\amd64\libcrypto.a
copy /Y ssl.amd64\lib\libssl.a ..\..\..\libraries\amd64\libssl.a
pause
@echo on
