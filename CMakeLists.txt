cmake_minimum_required(VERSION 3.4)

find_package(LLVM REQUIRED CONFIG)
add_definitions(${LLVM_DEFINITIONS})
include_directories(${LLVM_INCLUDE_DIRS})
link_directories(${LLVM_LIBRARY_DIRS})

include_directories(include)
add_subdirectory(src/Transforms)
add_subdirectory(src)
add_subdirectory(include)
