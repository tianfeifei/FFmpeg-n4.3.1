#!/bin/bash

NDK=/Users/tianfei/Library/Android/sdk/ndk/21.1.6352462
TOOLCHAIN=/Users/tianfei/Library/Android/sdk/ndk/21.1.6352462/toolchains/llvm/prebuilt/darwin-x86_64


ANDROID_LIB_PATH="$(pwd)/android"

API=21
./autogen.sh
function build_android_arm
{
echo "build for android $CPU"
./configure \
--host=$HOST \
--disable-shared \
--enable-static \
--prefix="$ANDROID_LIB_PATH/$CPU" 

make clean
make -j8
make install
echo "building for android $CPU completed"
}

CPU=armv8-a
HOST=aarch64-linux-android
export AR=$TOOLCHAIN/bin/aarch64-linux-android-ar
export AS=$TOOLCHAIN/bin/aarch64-linux-android-as
export LD=$TOOLCHAIN/bin/aarch64-linux-android-ld
export RANLIB=$TOOLCHAIN/bin/aarch64-linux-android-ranlib
export STRIP=$TOOLCHAIN/bin/aarch64-linux-android-strip
export CC=$TOOLCHAIN/bin/aarch64-linux-android$API-clang
export CXX=$TOOLCHAIN/bin/aarch64-linux-android$API-clang++
export CFLAGS="-Os -fpic $OPTIMIZE_CFLAGS"
export CPPFLAGS="-Os -fpic $OPTIMIZE_CFLAGS"

build_android_arm