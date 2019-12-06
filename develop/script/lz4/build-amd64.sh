#!/bin/sh
ARCHIVE_NAME=lz4-1.9.2
ARCHIVE_DIR=lz4-1.9.2

OUT_DIR=~/lz4.amd64
CPP_DIR=~/develop

source /opt/rh/devtoolset-7/enable
tar -xzvf $ARCHIVE_NAME.tar.gz
cd $ARCHIVE_DIR
make
make DESTDIR=$OUT_DIR install
cd ..

mkdir $CPP_DIR/includes/lz4
cp -r $OUT_DIR/usr/local/include/* $CPP_DIR/includes/lz4/
cp -f $OUT_DIR/usr/local/lib/liblz4.a $CPP_DIR/libraries/amd64/liblz4.a
rm -rf $OUT_DIR
rm -rf $ARCHIVE_DIR
