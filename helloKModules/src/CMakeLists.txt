cmake_minimum_required(VERSION 3.0.0 FATAL_ERROR)

project(helloKModules VERSION 0.1.0 LANGUAGES C)
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

#call external cmake file to locate kernel header dirs
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/../../cmake")
find_package(KernelHeaders REQUIRED)
include_directories(${KERNEL_HEADERS_INCLUDE_DIRS})

set(MODULE_OBJ_FILE hello.ko)
set(KBUILD_CMD  $(MAKE) -C ${KERNEL_HEADERS_DIR} M=${CMAKE_CURRENT_BINARY_DIR} src=${CMAKE_CURRENT_SOURCE_DIR})

#generate the Kbuild file through cmake
FILE(WRITE ${CMAKE_CURRENT_BINARY_DIR}/Kbuild "obj-m := hello.m")

add_custom_command(OUTPUT ${MODULE_OBJ_FILE}
    COMMAND ${KBUILD_CMD} WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    DEPENDS hello.c VERBATIM)

add_custom_target(helloKModules ALL DEPENDS ${MODULE_OBJ_FILE})