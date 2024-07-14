# ##############################################################################
# List of options
# ##############################################################################

option(ENABLE_CCACHE "Use ccache" OFF)
option(ENABLE_LLD "Use lld instead of the compiler-default linker" OFF)
option(ENABLE_PRECOMPILE_HEADER "Use precompiled headers" ON)
option(ENABLE_WARNINGS "Turn on compiler warnings." ON)
option(WARNINGS_AS_ERR "Turn compiler warnings into errors" OFF)

option(ENABLE_UNIT_TEST "Build GTest unit test executable" OFF)
# in my experience, turning this off gives better template debug information
option(
  ENABLE_OPTIMIZATION
  "Turn this off to add -O0 (gcc/clang) or /Od (MSVC) to Debug builds"
  ON)

# WARNING: only link one of ASan, UBSan or MSan at once
option(ENABLE_ASAN "Link libASan to executable" OFF)
option(ENABLE_UBSAN "Link libUBSan to executable" OFF)
option(ENABLE_MSAN "Link libMSan to executable" OFF)

include(ConfigureOptions)
