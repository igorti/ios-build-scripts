This is a set of scripts used to compile various C++ libraries for all architectures needed in iOS developmenet.

Following libraries are curently supported, but it should be easy to add receipes for new libraries. 

`proj` `geos` `gdal` `log4cpp` `xml2` `ssl` `curl`

Invoke script by running `./build.sh`. 

The script will download libraries, setup all needed environment variables and run receipe for each library which will configure and compile it. Finally it will merge all architectures of each library into one fat library file. 



