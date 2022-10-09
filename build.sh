!/bin/bash 
rm -rvf build 
mkdir build 
cd build 
conan install .. --build=missing
conan build ..
cd .. 
cp build/*.pyd python/