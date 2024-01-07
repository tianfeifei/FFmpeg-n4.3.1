#!/bin/bash

TOOLCHAIN=/Users/tianfei/Library/Android/sdk/ndk/21.1.6352462/toolchains/llvm/prebuilt/darwin-x86_64


ANDROID_LIB_PATH="$(pwd)/android"

API=21


function build_android_arm
{
./configure \
 --host=$HOST \
 --disable-cli \
 --disable-shared \
 --enable-static \
 --prefix="$ANDROID_LIB_PATH/$CPU" \
 --enable-pic \
 --enable-strip \
 --disable-asm \
 --cross-prefix=$CROSS_PREFIX \
 --sysroot=$TOOLCHAIN/sysroot \
 --extra-cflags="$CFALGS -Os -fPIC -DANDROID -Wfatal-errors -Wno-deprecated" \
 # --extra-cflags="-fPIC"

make clean
make -j8
make install
echo "building for android $CPU completed"
}

CPU=armv8-a
HOST=aarch64-linux-android
CFALGS="-march=armv8-a"
CROSS_PREFIX=$TOOLCHAIN/bin/aarch64-linux-android-
# export PATH=$TOOLCHAIN/bin:$PATH
# export AR=$TOOLCHAIN/bin/aarch64-linux-android-ar
# export AS=$TOOLCHAIN/bin/aarch64-linux-android-as
# export LD=$TOOLCHAIN/bin/aarch64-linux-android-ld
# export RANLIB=$TOOLCHAIN/bin/aarch64-linux-android-ranlib
# export STRIP=$TOOLCHAIN/bin/aarch64-linux-android-strip
export CC=$TOOLCHAIN/bin/aarch64-linux-android$API-clang
export CXX=$TOOLCHAIN/bin/aarch64-linux-android$API-clang++
build_android_arm
