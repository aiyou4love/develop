#!/bin/sh
ARCHIVE_NAME=boost_1_71_0
ARCHIVE_DIR=boost_1_71_0

CPP_DIR=~/develop

source /opt/rh/devtoolset-7/enable
tar --bzip2 -xf $ARCHIVE_NAME.tar.bz2
cd $ARCHIVE_DIR

chmod +x bootstrap.sh
./bootstrap.sh
./b2 stage address-model=64 link=static runtime-link=shared threading=multi release

cp -r boost $CPP_DIR/includes/
cp -f stage/lib/libboost_*.a $CPP_DIR/libraries/amd64/
cd ..
# rm -rf $ARCHIVE_DIR
