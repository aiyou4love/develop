@echo off
call build-setting.bat
%CUR_DRIVE%
cd %CUR_DIR%
del /f /s /q ..\..\arm64\libcrypto.a
del /f /s /q ..\..\arm64\libssl.a
pscp.exe -p -r -v -pw %LINUX_PWD% %SSL_NAME%.tar.gz %LINUX_NAME%@%LINUX_IP%:/home/%LINUX_NAME%
echo export ANDROID_NDK=/home/%LINUX_NAME%/%NDK_DIR%>>build.txt
echo export PATH=$ANDROID_NDK/toolchains/aarch64-linux-android-%NDK_TOOL%/prebuilt/linux-x86_64/bin:$PATH>>build.txt
echo tar xzf %SSL_NAME%.tar.gz>>build.txt
echo rm -rf %SSL_NAME%.tar.gz>>build.txt
echo cd %SSL_DIR%>>build.txt
echo ./Configure android-arm64 no-shared no-ssl3 no-asm no-comp no-hw no-engine -D__ANDROID_API__=%ANDROID_API% --prefix=/home/%LINUX_NAME%/ssl.arm64>>build.txt
echo make depend>>build.txt
echo make all>>build.txt
echo make install>>build.txt
echo cd ..>>build.txt
echo rm -rf %SSL_DIR%>>build.txt
plink -v -m build.txt %LINUX_NAME%@%LINUX_IP% -pw %LINUX_PWD%
pscp.exe -p -r -v -pw %LINUX_PWD% %LINUX_NAME%@%LINUX_IP%:/home/%LINUX_NAME%/ssl.arm64 .
del /f /s /q build.txt
copy /Y ssl.arm64\lib\libcrypto.a ..\..\arm64\libcrypto.a
copy /Y ssl.arm64\lib\libssl.a ..\..\arm64\libssl.a
pause
@echo on
