# Define cmake version
cmake_minimum_required(VERSION 3.16)


set(CMAKE_CXX_STANARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE CMAKE_CXX_EXTENSIONS OFF)

project (python_boost)

set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)
set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreadedDLL")

find_package(Boost MODULE REQUIRED)

set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR})

add_subdirectory(src)

add_library(project_interface INTERFACE)

target_include_directories(project_interface INTERFACE 
    "inc"
    ${Boost_INCLUDE_DIRS}
)

target_link_libraries(project_interface INTERFACE 
    Boost::Boost
)

add_library(project_lib "")
target_link_libraries(project_lib PRIVATE 
    project_interface
    demo_object
)

add_subdirectory(python_wrapper)