#!/bin/bash
root=`pwd`
build_root_dir=`pwd`/build
mkdir sources

for library in "proj" "geos" "gdal" "log4cpp" "xml2" "ssl" "curl"; do	
	for arch in "i386" "x86_64" "armv7" "armv7s" "arm64"; do
		cd $root && . setup.sh

		if [ $arch = "arm64" ]
		then
		    host="arm-apple-darwin"
		else
		    host="${arch}-apple-darwin"
		fi

		install_dir="${build_root_dir}/${arch}"
		mkdir -p $install_dir

		echo "Building ${library} for ${arch}..."
		cd $root && . receipes/${library}.sh >> log.txt 2>&1
	done
done

cd $root && . merge.sh
echo "Done"
