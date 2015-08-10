#!/bin/bash
lib=gdal-1.11.2

if [ ! -e "sources/${lib}" ]
then
    curl -O http://download.osgeo.org/gdal/1.11.2/${lib}.tar.gz
    tar -xzf ${lib}.tar.gz -C sources
    rm ${lib}.tar.gz
fi

cd "sources/${lib}"
make clean

./configure \
    --prefix=${install_dir} \
    --host=$host \
    --disable-shared \
    --enable-static \
    --with-hide-internal-symbols \
    --with-unix-stdio-64=no \
    --with-geos=no \
    --without-pg \
    --without-grass \
    --without-libgrass \
    --without-cfitsio \
    --without-pcraster \
    --without-netcdf \
    --without-ogdi \
    --without-fme \
    --without-hdf4 \
    --without-hdf5 \
    --without-jasper \
    --without-kakadu \
    --without-grib \
    --without-mysql \
    --without-ingres \
    --without-xerces \
    --without-odbc \
    --without-curl \
    --without-idb \
    --without-sde \
    --with-sse=no \
    --with-avx=no \
|| exit

time make -j 8
make install
