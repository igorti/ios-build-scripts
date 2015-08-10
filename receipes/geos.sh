#!/bin/bash
lib=geos-3.4.2

if [ ! -e "sources/${lib}" ]
then
    curl -O http://download.osgeo.org/geos/${lib}.tar.bz2
    tar -xzf ${lib}.tar.bz2 -C sources
    rm ${lib}.tar.bz2
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
