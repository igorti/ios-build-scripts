#!/bin/bash
lib=curl-7.43.0

if [ ! -e "sources/${lib}" ]
then
    curl -O http://curl.haxx.se/download/${lib}.tar.gz
    tar -xzf ${lib}.tar.gz -C sources
    rm ${lib}.tar.gz
fi

cd "sources/${lib}"
make clean

./configure \
    --prefix=${install_dir} \
    --disable-shared \
    --enable-static \
    --host=$host \
|| exit

make -j 8
make install
