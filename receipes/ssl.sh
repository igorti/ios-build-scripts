#!/bin/sh

#  Automatic build script for libssl and libcrypto 
#  for iPhoneOS and iPhoneSimulator
#
#  Created by Felix Schulze on 16.12.10.
#  Copyright 2010-2015 Felix Schulze. All rights reserved.
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#  http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#
VERSION="1.0.2d"													      #
SDKVERSION=`xcrun -sdk iphoneos --show-sdk-version`														  #


CURRENTPATH=`pwd`
DEVELOPER=`xcode-select -print-path`
MIN_SDK_VERSION="9.0"

set -e
if [ ! -e sources/openssl-${VERSION} ]; then
    curl -O https://www.openssl.org/source/openssl-${VERSION}.tar.gz
    tar zxf openssl-${VERSION}.tar.gz -C sources
	rm openssl-${VERSION}.tar.gz
fi


cd sources/openssl-${VERSION}

if [[ "${arch}" == "i386" || "${arch}" == "x86_64" ]];
then
	PLATFORM="iPhoneSimulator"
else
	sed -ie "s!static volatile sig_atomic_t intr_signal;!static volatile intr_signal;!" "crypto/ui/ui_openssl.c"
	PLATFORM="iPhoneOS"
fi

export CROSS_TOP="${DEVELOPER}/Platforms/${PLATFORM}.platform/Developer"
export CROSS_SDK="${PLATFORM}${SDKVERSION}.sdk"
export BUILD_TOOLS="${DEVELOPER}"

if [ "${SDKVERSION}" == "9.0" ]; then
	export CC="${BUILD_TOOLS}/usr/bin/gcc -arch ${arch} -fembed-bitcode"
else
	export CC="${BUILD_TOOLS}/usr/bin/gcc -arch ${arch}"
fi

make clean

set +e
if [ "${arch}" == "x86_64" ]; then
    ./Configure no-asm darwin64-x86_64-cc --openssldir="${install_dir}"
else
    ./Configure iphoneos-cross --openssldir="${install_dir}"
fi

if [ $? != 0 ];
then 
	echo "Problem while configure - Please check log"
	exit 1
fi
# add -isysroot to CC=
sed -ie "s!^CFLAG=!CFLAG=-isysroot ${CROSS_TOP}/SDKs/${CROSS_SDK} -miphoneos-version-min=${MIN_SDK_VERSION} !" "Makefile"

make -j 8

if [ $? != 0 ];
then 
	echo "Problem while make - Please check ${LOG}"
	exit 1
fi

set -e
make install
