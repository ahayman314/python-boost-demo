
add_library(demo_object OBJECT demo.cpp)

target_link_libraries(demo_object PRIVATE project_interface)