#!/bin/bash
lib=libxml2-2.9.2

if [ ! -e "sources/${lib}" ]
then
    curl -O ftp://xmlsoft.org/libxml2/libxml2-git-snapshot.tar.gz
    tar -xzf libxml2-git-snapshot.tar.gz -C sources
    rm libxml2-git-snapshot.tar.gz
fi

cd "sources/${lib}"
make clean

./configure \
    --prefix=${install_dir} \
    --disable-shared \
    --enable-static \
    --host=$host \
    --without-lzma \
|| exit

make -j 8
make install

