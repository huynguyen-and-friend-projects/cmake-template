cmake_minimum_required(VERSION 3.26)
project(
  my_proj
  LANGUAGES CXX
  VERSION 0.69.420
  DESCRIPTION "Toy project"
  HOMEPAGE_URL "https://github.com/huynguyen-and-friend-projects/cmake-template")

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake/ ${PROJECT_SOURCE_DIR})

add_library(project_options INTERFACE)
target_compile_features(project_options INTERFACE cxx_std_${CMAKE_CXX_STANDARD})
include(CMakeOptions)

install(TARGETS project_options DESTINATION ${CMAKE_INSTALL_LIBDIR})

add_subdirectory(src)
include(CPackConfigurations)
