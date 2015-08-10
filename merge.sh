#!/bin/bash

root=`pwd`

mkdir -p merged/bin
mkdir -p merged/lib
mkdir -p merged/include
mkdir -p merged/share

cd build/arm64/lib

for file in *.a; do
	lipo -create \
	$root/build/armv7/lib/$file \
	$root/build/armv7s/lib/$file \
	$root/build/arm64/lib/$file \
	$root/build/i386/lib/$file \
	$root/build/x86_64/lib/$file \
	-output "$root/merged/lib/$file"
done

cd $root

cp -R build/armv7/include merged
cp -R build/armv7/bin merged
cp -R build/armv7/share merged
