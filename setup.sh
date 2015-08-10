#!/bin/bash
default_iphoneos_version=8.0

if [[ $arch = "i386" || $arch = "x86_64" ]]
then
    platform=iphonesimulator
    extra_cflags="-mios-simulator-version-min=${default_iphoneos_version}"
else
    platform=iphoneos
    extra_cflags="-miphoneos-version-min=${default_iphoneos_version}"
fi

platform_sdk_dir=`xcrun -find -sdk ${platform} --show-sdk-path`

export CC=`xcrun -find -sdk iphoneos gcc`
export CFLAGS="-Wno-error=implicit-function-declaration -arch ${arch} -pipe -Os -gdwarf-2 -isysroot ${platform_sdk_dir} ${extra_cflags}"
export LDFLAGS="-arch ${arch} -isysroot ${platform_sdk_dir} ${extra_cflags}"
export CXX=`xcrun -find -sdk iphoneos g++`
export CXXFLAGS="${CFLAGS}"
export CPP=`xcrun -find -sdk iphoneos cpp`
export CXXCPP="${CPP}"
