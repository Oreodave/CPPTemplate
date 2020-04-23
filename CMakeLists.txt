## Metadata
cmake_minimum_required(VERSION 3.10.2)

set(THIS main) # Name of project
project(${THIS} CXX)

set(CMAKE_CXX_COMPILER clang++) # compiler

set(CMAKE_CXX_STANDARD 11) # code standard
SET(CMAKE_POSITION_INDEPENDENT_CODE ON)

## Variables for files
file(GLOB_RECURSE HEADERS "includes/*.hpp")
file(GLOB_RECURSE SRC "src/*.cpp")

## Debug and release flags
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Werror")
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -Wall -Werror -O0")

## Executable recipes
add_executable(${THIS} ${SRC} ${HEADERS})

## SDL2 INCLUDE
# find_package(SDL2 REQUIRED)
# find_package(SDL2_image REQUIRED)
# include_directories(${SDL2_INCLUDE_DIRS} ${SDL2_IMAGE_INCLUDE_DIRS})
# target_link_libraries(${THIS} ${SDL2_LIBRARIES} ${SDL2_IMAGE_LIBRARIES})
## SFML INCLUDE
# find_package(SFML 2.5 COMPONENTS graphics REQUIRED)
# target_link_libraries(${THIS} sfml-graphics)
## FMT INCLUDE
# find_package(fmt)
# target_link_libraries(${THIS} fmt::fmt)
