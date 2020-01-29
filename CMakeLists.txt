## Metadata
cmake_minimum_required(VERSION 3.10.2)

set(THIS main) # Name of project
project(${THIS} CXX)

set(CMAKE_CXX_COMPILER clang++) # compiler

set(CMAKE_CXX_STANDARD 11) # code standard
SET(CMAKE_POSITION_INDEPENDENT_CODE ON)

enable_testing()

## Variables for files
file(GLOB_RECURSE HEADERS "includes/*.hpp")
file(GLOB_RECURSE SRC "src/*.cpp")

## Executable recipes
add_executable(${THIS}-debug ${SRC} ${HEADERS})
add_executable(${THIS}-clean ${SRC} ${HEADERS})

target_compile_options(${THIS}-debug PUBLIC -O0 -g -Wall)
target_compile_options(${THIS}-clean PUBLIC -O3 -Wall)

## Tests
add_test(NAME run COMMAND ./${This}-debug WORKING_DIRECTORY ${CMAKE_BINARY_DIR})
