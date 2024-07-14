# ##############################################################################
# Fetch GTest when GTest isn't found
# ##############################################################################

# copy-pasted from GTest docs:
# https://google.github.io/googletest/quickstart-cmake.html
if(NOT GTest_DIR)
  message("GTest not found, proceed to installation")
  include(FetchContent)
  FetchContent_Declare(
    googletest
    URL https://github.com/google/googletest/archive/03597a01ee50ed33e9dfd640b249b4be3799d395.zip
        NAME
        gtest)
  # For Windows: Prevent overriding the parent project's compiler/linker
  # settings
  set(gtest_force_shared_crt
      ON
      CACHE BOOL "" FORCE)
  FetchContent_MakeAvailable(googletest)
endif()
