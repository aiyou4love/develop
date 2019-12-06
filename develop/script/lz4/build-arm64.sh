#!/bin/bash

# _ANDROID_EABI="arm-linux-androideabi-4.9"
_ANDROID_EABI="aarch64-linux-android-4.9"

# _ANDROID_TOOL=arm-linux-androideabi
_ANDROID_TOOL=aarch64-linux-android

# _ANDROID_ARCH=arch-arm
_ANDROID_ARCH=arch-arm64

_ANDROID_API=android-21

if [ -z "$NDK_ROOT" ] || [ ! -d "$NDK_ROOT" ]; then
  echo "Error: NDK_ROOT is not a valid path. Please edit this script."
fi

ANDROID_TOOLCHAIN=""
for host in "linux-x86_64" "linux-x86" "darwin-x86_64" "darwin-x86"
do
  if [ -d "$NDK_ROOT/toolchains/$_ANDROID_EABI/prebuilt/$host/bin" ]; then
    ANDROID_TOOLCHAIN="$NDK_ROOT/toolchains/$_ANDROID_EABI/prebuilt/$host/bin"
    break
  fi
done

if [ ! -z "$ANDROID_TOOLCHAIN" ]; then
  export PATH="$ANDROID_TOOLCHAIN":"$PATH"
fi

export SYSROOT=$NDK_ROOT/platforms/$_ANDROID_API/$_ANDROID_ARCH
export CPPFLAGS="-I$SYSROOT/usr/include --sysroot=$SYSROOT"
export CFLAGS="-I$SYSROOT/usr/include --sysroot=$SYSROOT"
export AR=$_ANDROID_TOOL-ar
export AS=$_ANDROID_TOOL-as
export LD=$_ANDROID_TOOL-ld
export RANLIB=$_ANDROID_TOOL-ranlib
export CC=$_ANDROID_TOOL-gcc
export NM=$_ANDROID_TOOL-nm
export CPP=$_ANDROID_TOOL-cpp
export CXX=$_ANDROID_TOOL-g++
