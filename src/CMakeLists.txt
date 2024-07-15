# List the source files for the library here, after STATIC
add_library(sample_lib sample_lib.cxx sample_lib_internal.cxx)
add_library(sample_lib::main_lib ALIAS sample_lib)

set_target_properties(
  sample_lib
  PROPERTIES VERSION ${PROJECT_VERSION}
             PUBLIC_HEADER sample_lib.hxx
             PRIVATE_HEADER internal/sample_lib_.hxx)

target_precompile_headers(sample_lib INTERFACE <string_view>)
target_link_libraries(sample_lib INTERFACE project_options)

target_include_directories(
  sample_lib
  PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
         $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
  PRIVATE $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/internal>
          $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}/sample_lib>)

set(SAMPLE_LIB_HELP_STRING
    "\"List of options:\\n\"
    \"\t-h|--help: Prints this list of options\\n\"
    \"\t-ln|--lucky-number: Prints the lucky number\\n\"")
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/internal/sample_lib_exe_.hxx.in
               ${PROJECT_BINARY_DIR}/src/internal/sample_lib_exe_.hxx @ONLY)

add_executable(sample_exe sample_lib_exe.cxx)

set_target_properties(
  sample_exe
  PROPERTIES VERSION ${PROJECT_VERSION})
target_link_libraries(sample_exe PRIVATE project_options sample_lib)

target_include_directories(
  sample_exe
  PRIVATE $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/src/internal>
          $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/internal>
          $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}/sample_lib>)

include(InstallConfigurations)
