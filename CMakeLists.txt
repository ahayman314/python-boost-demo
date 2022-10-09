# Define cmake version
cmake_minimum_required(VERSION 3.16)

# Set C++ standard
set(CMAKE_CXX_STANARD 14)

# Define a project name
project (python_boost)

# Find Boost package to make the libraries and headers avaiable
find_package(Boost MODULE REQUIRED)

# Make the produced libraries go into /build instead of /build/Release
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR})

# Go execute the subdirectory CMakeLists.txt files
add_subdirectory(src)

# Add a library
add_library(project_interface INTERFACE)

# Add the include directories for the static library
target_include_directories(project_interface INTERFACE 
"inc"
)

# Link to libraries for the static library (we don't need any in this case)
target_link_libraries(project_interface INTERFACE 
)

# Build the static library
add_library(project_lib "")
target_link_libraries(project_lib PRIVATE 
    project_interface
    demo_object
)

# Now that we have built our static library, go build the shared Python wrapper library
add_subdirectory(python_wrapper)