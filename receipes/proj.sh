#!/bin/bash
lib=proj-4.8.0

if [ ! -e "sources/${lib}" ]
then
    curl -O http://download.osgeo.org/proj/${lib}.tar.gz
    tar -xzf ${lib}.tar.gz -C sources
    rm ${lib}.tar.gz
fi

cd "sources/${lib}"
make clean

echo

./configure \
    --prefix=${install_dir} \
    --enable-shared=no \
    --enable-static=yes \
    --host=$host \
|| exit

make -j 8
make install
