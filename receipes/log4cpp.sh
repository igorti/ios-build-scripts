#!/bin/bash
lib=log4cpp
	
if [ ! -e "sources/${lib}" ]
then
    curl -O http://garr.dl.sourceforge.net/project/log4cpp/log4cpp-1.1.x%20%28new%29/log4cpp-1.1/log4cpp-1.1.1.tar.gz
    tar -xzf log4cpp-1.1.1.tar.gz -C sources
    rm log4cpp-1.1.1.tar.gz
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
