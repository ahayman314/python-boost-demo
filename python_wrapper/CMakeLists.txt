# Here, we build the shared library that Python will call

# Find Boost and auto-generate the cmake files
find_package(Boost MODULE REQUIRED)

find_package(Python 3 REQUIRED COMPONENTS Interpreter Development)
message(STATUS "PYTHON_LIBRARIES: ${Python_LIBRARIES}")
message(STATUS "PYTHON_EXE: ${Python_EXECUTABLE}")
message(STATUS "PYTHON_INC_DIRS: ${Python_INCLUDE_DIRS}")

# Create the library from the python wrapper code
add_library(python_demo MODULE python_wrapper.cpp)

# Include the relevant header files
target_include_directories(python_demo PRIVATE
    "${CMAKE_SOURCE_DIR}/inc"
    ${Python_INCLUDE_DIRS}
    ${Boost_INCLUDE_DIRS}
)

# Link to your library and Boost
target_link_libraries(python_demo PRIVATE 
    project_interface
    project_lib
    ${Python_LIBRARIES}
    Boost::Boost 
)

add_custom_command(TARGET python_demo
    POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:python_demo> "${CMAKE_BINARY_DIR}/python_demo.pyd"
    COMMENT "Converting dll to pyd" VERBATIM
)

install(FILES "${CMAKE_BINARY_DIR}/python_demo.pyd" DESTINATION . COMPONENT Libraries)