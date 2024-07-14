include(GenerateExportHeader)
include(GNUInstallDirs)

# List the source files for the library here, after STATIC
add_library(sample_lib STATIC sample_lib.cxx sample_lib_internal.cxx)
add_library(sample_lib::main_lib ALIAS sample_lib)

set(SAMPLE_LIB_PUBLIC_HEADERS sample_lib.hxx)
set(SAMPLE_LIB_PRIVATE_HEADERS sample_lib_.hxx)

list(TRANSFORM SAMPLE_LIB_PRIVATE_HEADERS PREPEND "internal/")

target_precompile_headers(sample_lib INTERFACE <string_view>)
target_link_libraries(sample_lib INTERFACE project_options)

target_include_directories(
  sample_lib
  PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
         $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
  PRIVATE $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/internal>
          $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}/sample_lib_internal>)

include(InstallConfigurations)
