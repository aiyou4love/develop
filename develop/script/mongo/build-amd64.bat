@echo off
call build-setting.bat
%CUR_DRIVE%
cd %CUR_DIR%
rd /s /q %C_DIR%
pscp.exe -p -r -v -pw %LINUX_PWD% %MONGOC_ARC%.tar.gz %MONGO_ARC%.tar.gz %LINUX_NAME%@%LINUX_IP%:/home/%LINUX_NAME%
echo source /opt/rh/devtoolset-7/enable>>build.txt
echo tar -xzvf %MONGOC_ARC%.tar.gz>>build.txt
echo tar -xzvf %MONGO_ARC%.tar.gz>>build.txt
echo rm -rf %MONGOC_ARC%.tar.gz>>build.txt
echo rm -rf %MONGO_ARC%.tar.gz>>build.txt
echo cd %MONGOC_DIR%>>build.txt
echo mkdir cmake-build && cd cmake-build>>build.txt
echo cmake3 .. -DENABLE_AUTOMATIC_INIT_AND_CLEANUP=OFF -DCMAKE_INSTALL_PREFIX=../../%C_DIR% -DCMAKE_PREFIX_PATH=../../%C_DIR%>>build.txt
echo make && make install>>build.txt
echo cd ../..>>build.txt
echo %CXX_DIR%/build>>build.txt
echo cmake3 .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=../../%CXX_DIR% -DCMAKE_PREFIX_PATH=%CX_DIR1% -DBOOST_ROOT=%BOOST_DIR1%>>build.txt
echo make && make install>>build.txt
echo cd ../..>>build.txt
plink -v -m build.txt %LINUX_NAME%@%LINUX_IP% -pw %LINUX_PWD%
del /f /s /q build.txt
pause
@echo on
