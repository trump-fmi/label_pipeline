mkdir bin

# change into the bin directory and compile the binaries
cd bin
ln -sf ../scripts/pipeline.sh pipeline.sh
chmod +x pipeline.sh
cmake -DCMAKE_BUILD_TYPE=Release ..
make -j4

