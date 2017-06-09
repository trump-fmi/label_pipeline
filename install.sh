# amalgamate the jsoncpp binaries
(cd vendor/osm_input/vendor/jsoncpp && python amalgamate.py)

mkdir bin

# cp the scripts to the bin directory
cp scripts/* bin

# change into the bin directory and compile the binaries
cd bin
cmake -DCMAKE_BUILD_TYPE=Release ..
make -j4

