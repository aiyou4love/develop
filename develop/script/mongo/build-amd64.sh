#!/bin/sh
MONGOC_NAME=mongo-c-driver-1.14.0
MONGOC_DIR=mongo-c-driver-1.14.0
MONGOC_OUT=~/mongo-c-driver

MONGO_NAME=mongo-cxx-driver-r3.4.0
MONGO_DIR=mongo-cxx-driver-r3.4.0
MONGO_OUT=~/mongo-cxx-driver

CPP_DIR=~/develop
source /opt/rh/devtoolset-7/enable
mkdir $MONGOC_OUT
mkdir $MONGO_OUT

tar -xzvf $MONGOC_NAME.tar.gz
tar -xzvf $MONGO_NAME.tar.gz
cd $MONGOC_DIR
mkdir cmake-build && cd cmake-build
cmake3 .. -DENABLE_AUTOMATIC_INIT_AND_CLEANUP=OFF -DCMAKE_INSTALL_PREFIX=$MONGOC_OUT -DCMAKE_PREFIX_PATH=$MONGOC_OUT
make && make install
cd ../../$MONGO_DIR/build
cmake3 .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$MONGO_OUT -DCMAKE_PREFIX_PATH=$MONGOC_OUT
make && make install
cd ../..

rm -rf $CPP_DIR/includes/bsoncxx
rm -rf $CPP_DIR/includes/mongocxx

rm -rf $CPP_DIR/libraries/amd64/libbson.so
rm -rf $CPP_DIR/libraries/amd64/libbsoncxx.so
rm -rf $CPP_DIR/libraries/amd64/libmongoc.so
rm -rf $CPP_DIR/libraries/amd64/libmongocxx.so

rm -rf $CPP_DIR/binaries/amd64/libbson-1.0.so.0
rm -rf $CPP_DIR/binaries/amd64/libbsoncxx.so._noabi
rm -rf $CPP_DIR/binaries/amd64/libmongoc-1.0.so.0
rm -rf $CPP_DIR/binaries/amd64/libmongocxx.so._noabi

cp -r $MONGO_OUT/include/bsoncxx/v_noabi/bsoncxx $CPP_DIR/includes/
cp -r $MONGO_OUT/include/mongocxx/v_noabi/mongocxx $CPP_DIR/includes/

cp -f $MONGOC_OUT/lib64/libbson-1.0.so $CPP_DIR/libraries/amd64/libbson.so
cp -f $MONGO_OUT/lib64/libbsoncxx.so $CPP_DIR/libraries/amd64/libbsoncxx.so
cp -f $MONGOC_OUT/lib64/libmongoc-1.0.so $CPP_DIR/libraries/amd64/libmongoc.so
cp -f $MONGO_OUT/lib64/libmongocxx.so $CPP_DIR/libraries/amd64/libmongocxx.so

cp -f $MONGOC_OUT/lib64/libbson-1.0.so.0 $CPP_DIR/binaries/amd64/libbson-1.0.so.0
cp -f $MONGO_OUT/lib64/libbsoncxx.so._noabi $CPP_DIR/binaries/amd64/libbsoncxx.so._noabi
cp -f $MONGOC_OUT/lib64/libmongoc-1.0.so.0 $CPP_DIR/binaries/amd64/libmongoc-1.0.so.0
cp -f $MONGO_OUT/lib64/libmongocxx.so._noabi $CPP_DIR/binaries/amd64/libmongocxx.so._noabi
