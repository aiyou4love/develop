#!/bin/sh
if [ ! -d "build" ]; then
    mkdir build
fi
cd build
source /opt/rh/devtoolset-7/enable
cmake3 .. -DARCH_NAME=amd64
cmake3 --build . --config Debug
