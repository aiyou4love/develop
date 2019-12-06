#!/bin/sh
ARCHIVE_NAME=openssl-1.1.1d
ARCHIVE_DIR=openssl-1.1.1d
OUT_DIR=~/ssl.amd64
CPP_DIR=~/unseen-cpp
source /opt/rh/devtoolset-7/enable
tar -xzvf $ARCHIVE_NAME.tar.gz
cd $ARCHIVE_DIR
./config no-shared no-ssl3 no-asm no-comp no-hw no-engine --prefix=$OUT_DIR
make depend
make all
make install
cd ..
rm -rf $CPP_DIR/libraries/amd64/libcrypto.a
rm -rf $CPP_DIR/libraries/amd64/libssl.a
cp -f $OUT_DIR/lib/libcrypto.a $CPP_DIR/libraries/amd64/libcrypto.a
cp -f $OUT_DIR/lib/libssl.a $CPP_DIR/libraries/amd64/libssl.a
# rm -rf $OUT_DIR
rm -rf $ARCHIVE_DIR
