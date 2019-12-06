@echo off
call ndk-setting.bat
%CUR_DRIVE%
cd %CUR_DIR%
pscp.exe -p -r -v -pw %LINUX_PWD% %NDK_NAME%.zip %LINUX_NAME%@%LINUX_IP%:/home/%LINUX_NAME%
echo unzip %NDK_NAME%.zip>>ndk.txt
echo rm -rf %NDK_NAME%.zip>>ndk.txt
plink -v -m ndk.txt %LINUX_NAME%@%LINUX_IP% -pw %LINUX_PWD%
del /f /s /q ndk.txt
pause
@echo on
