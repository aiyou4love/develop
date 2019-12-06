#!/bin/sh
ARCHIVE_NAME=curl-7.65.3
ARCHIVE_DIR=curl-7.65.3

OUT_DIR=~/curl.amd64
SSL_DIR=~/ssl.amd64
CPP_DIR=~/develop

source /opt/rh/devtoolset-7/enable
tar --bzip2 -xf $ARCHIVE_NAME.tar.bz2
cd $ARCHIVE_DIR

./configure --prefix=$OUT_DIR \
            --with-ssl=$SSL_DIR \
            --enable-static \
            --disable-shared \
            --disable-verbose \
            --enable-threaded-resolver \
            --enable-ipv6
make
make install
cd ..

rm -rf $CPP_DIR/includes/curl
rm -rf $CPP_DIR/libraries/amd64/libcurl.a
cp -r $OUT_DIR/include/curl $CPP_DIR/includes/
cp -f $OUT_DIR/lib/libcurl.a $CPP_DIR/libraries/amd64/libcurl.a
rm -rf $OUT_DIR
rm -rf $SSL_DIR
rm -rf $ARCHIVE_DIR
