# Description
This code base demonstrates a hello world example of using Boost's C++ Python wrapper using conan and cmake. 

## How to run
Run the build.sh script that runs the package installation and bulid. Change permissions if necessary with

```
chmod 777 build.sh
```
Once run, you can test the demo Python program with 
```
python python/demo.py
```
which should result in 'hello world'

## Walkthrough
### Program Structure
- src -> cpp source files built into static libraries
- inc -> cpp header files for the src files
- python_wrapper -> cpp source files for converting the src libraries to Python
- python -> demo Python program to show importing & using the resulting library

### conanfile.py
This is where we define our requirements for the project, including Boost. This makes Boost available to cmake through find_package and automatically deals with the paths. 

### CMakeLists.txt
These files define the build for the program. This includes library linking, include directories, etc. 

### CMake Build Process
1. [build script / Conan] Install Boost using Conan. The `--build=missing` flag takes care of building Boost with the right flags that allow it to use Boost.Python
2. [Conan] Tell CMake to build
3. [CMake] Create a static library for your code in /src and /inc, which is completely independent of the Python wrapper. This is useful because it can be tested independently. 
4. [CMake] Create a shared library with the code from /python_wrapper which pulls in the static library and relevant headers. 
5. [CMake] Convert the '.dll' to '.pyd' which is the format Python expects
6. [build script] Copy the .pyd to the Python directory where you want to import it