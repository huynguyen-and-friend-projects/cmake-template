# ##############################################################################
# Option configurations
# ##############################################################################

# if build type is not yet set
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  message("No build type is configured! Default to Debug")
  set(CMAKE_BUILD_TYPE
      "Debug"
      CACHE STRING
            "Choose a build type (Debug, Release, MinSizeRel, RelWithDebInfo)"
            FORCE)
  set_property(CACHE CMAKE_BUILD_TYPE
               PROPERTY STRINGS "Debug;Release;MinSizeRel;RelWithDebInfo")
endif()

# ccache
if(ENABLE_CCACHE)
  find_program(CCACHE ccache)
  if(NOT CCACHE)
    message("Cannot find ccache")
  else()
    message("Found ccache and is using it")
    set(CMAKE_CXX_COMPILER_LAUNCHER ${CCACHE})
  endif()
endif()

# lld
if(ENABLE_LLD)
  message("Using lld")
  find_program(LLD lld)
  if(NOT LLD)
    message("Cannot find lld. Proceed to still use the compiler default")
  else()
    add_link_options("-fuse-ld=lld")
  endif()
endif()

# PCH
if(ENABLE_PRECOMPILE_HEADER)
  message("Using precompiled headers")
  # add stuff as needed.
  #
  # Here are the stuff I think any sane person would include anyways.
  target_precompile_headers(project_options INTERFACE <memory> <utility>)
endif()

# warnings
if(ENABLE_WARNINGS)
  message("Turning on more warnings")
  if(MSVC)
    # target_compile_options(project_options INTERFACE "/W4")
    add_compile_options("/W4")
  else(MSVC)
    # gcc or clang hopefully target_compile_options(project_options INTERFACE
    # "-Wall;-Wextra;-Wshadow;-Wformat=2")
    add_compile_options("-Wall;-Wextra;-Wshadow;-Wformat=2")
  endif()
endif()

# warnings as errors
if(WARNINGS_AS_ERR)
  message("Turning on warnings-as-errors compile option")
  if(MSVC)
    # target_compile_options(project_options INTERFACE "/WX")
    add_compile_options("/WX")
  else(MSVC)
    # target_compile_options(project_options INTERFACE "-Werror")
    add_compile_options("-Werror")
  endif()
endif()

# enable build unit test executables
if(ENABLE_UNIT_TEST)
  message("Finding GTest. If not successfully found, will download GTest.")
  find_package(GTest)
  if(NOT GTest_DIR)
    include(FetchGTest)
  endif()
  add_subdirectory(${PROJECT_SOURCE_DIR}/test)
endif()

if(NOT ENABLE_OPTIMIZATION)
  message("Disabling optimization.")
  if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
    if(MSVC)
      add_compile_options("/Od")
    else(MSVC)
      add_compile_options("-O0")
    endif()
  else()
    message("Build type forces optimization. Skipping this action.")
  endif()
endif()
