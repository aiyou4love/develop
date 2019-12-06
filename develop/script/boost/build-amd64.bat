@echo off
call build-setting.bat
%CUR_DRIVE%
cd %CUR_DIR%
del /f /s /q ..\..\..\libraries\amd64\libboost*.a
pscp.exe -p -r -v -pw %LINUX_PWD% %BOOST_ARC%.tar.bz2 %LINUX_NAME%@%LINUX_IP%:/home/%LINUX_NAME%
echo source /opt/rh/devtoolset-7/enable>>build.txt
echo tar --bzip2 -xf %BOOST_ARC%.tar.bz2>>build.txt
echo rm -rf %BOOST_ARC%.tar.bz2>>build.txt
echo cd %BOOST_DIR%>>build.txt
echo ./bootstrap.sh>>build.txt
echo ./b2 stage address-model=64 --with-log link=static runtime-link=shared threading=multi debug>>build.txt
echo cd ..>>build.txt
plink -v -m build.txt %LINUX_NAME%@%LINUX_IP% -pw %LINUX_PWD%
pscp.exe -p -r -v -pw %LINUX_PWD% %LINUX_NAME%@%LINUX_IP%:/home/%LINUX_NAME%/%BOOST_DIR%/stage/lib/* ../../../libraries/amd64/
del /f /s /q build.txt
pause
@echo on
