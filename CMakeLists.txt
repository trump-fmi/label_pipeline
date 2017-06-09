cmake_minimum_required(VERSION 3.0)

project(pipeline)

set(OSM_INPUT_PATH "${CMAKE_SOURCE_DIR}/vendor/osm_input")
set(GB_PATH "${CMAKE_SOURCE_DIR}/vendor/growing_balls")

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${OSM_INPUT_PATH}/cmake/Modules/")

add_subdirectory(${OSM_INPUT_PATH})
add_subdirectory(${GB_PATH})
