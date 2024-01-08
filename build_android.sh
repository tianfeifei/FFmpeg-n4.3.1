#!/bin/bash
# 以下路径需要修改成自己的NDK目录
NDK=/Users/tianfei/Library/Android/sdk/ndk/android-ndk-r21e
TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/darwin-x86_64
# 最低支持的android sdk版本
API=21
# 交叉编译树的根目录(查找相应头文件和库用)
SYSROOT="${TOOLCHAIN}/sysroot"



# arm64-v8a，这个指令集最低支持api21
 OUTPUT_FOLDER="arm64-v8a"
 ARCH="aarch64"
 CPU="armv8-a"
 TOOL_CPU_NAME=aarch64
 TOOL_PREFIX="$TOOLCHAIN/bin/${TOOL_CPU_NAME}-linux-android"
 OPTIMIZE_CFLAGS="-mfloat-abi=softfp -mfpu=vfp -marm -march=$CPU "

PREFIX="${PWD}/android/$OUTPUT_FOLDER"
CC="${TOOL_PREFIX}${API}-clang"
CXX="${TOOL_PREFIX}${API}-clang++"
CROSS_PREFIX=$TOOLCHAIN/bin/aarch64-linux-android-

#第三方库
FDK_INCLUDE=${PWD}/fdk-aac_副本/android/$CPU/include
FDK_LIB=${PWD}/fdk-aac_副本/android/$CPU/lib
X264_INCLUDE=${PWD}/x264_副本/android/$CPU/include
X264_LIB=${PWD}/x264_副本/android/$CPU/lib
# 定义执行configure的shell方法
function build_android() {
    ./configure \
    --prefix=$PREFIX \
    --disable-asm \
    --enable-hwaccels  \
    --enable-gpl   \
    --disable-postproc \
    --enable-static \
    --disable-shared \
    --enable-debug \
    --disable-stripping \
    --enable-small \
    --enable-jni \
    --disable-mediacodec \
    --disable-doc \
    --disable-ffmpeg \
    --disable-ffplay \
    --disable-ffprobe \
    --disable-avdevice \
    --disable-doc \
    --disable-symver \
    --enable-libx264 \
    --enable-libfdk-aac \
    --enable-nonfree \
    --enable-muxers \
    --enable-decoders \
    --enable-demuxers \
    --enable-parsers \
    --enable-protocols \
    --cross-prefix=$CROSS_PREFIX \
    --target-os=android \
    --arch=$ARCH \
    --cpu=$CPU \
    --cc=$CC \
    --cxx=$CXX \
    --enable-cross-compile \
    --sysroot=$SYSROOT \
    --extra-cflags="-I$X264_INCLUDE -I$FDK_INCLUDE -Os -fpic $OPTIMIZE_CFLAGS" \
    --extra-ldflags="-lm -L$FDK_LIB -L$X264_LIB $ADDI_LDFLAGS" 

    make clean
    make -j12
    make install
}

 build_android


