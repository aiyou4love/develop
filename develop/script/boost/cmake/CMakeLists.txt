cmake_minimum_required(VERSION 3.11)
project(boost)

include_directories(../boost)

add_subdirectory(exception)
add_subdirectory(system)
add_subdirectory(date_time)
