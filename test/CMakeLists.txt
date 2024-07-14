enable_testing()
include(GoogleTest)

add_executable(unit_test unit_test.cxx)
target_link_libraries(unit_test PRIVATE GTest::gtest_main project_options
                                        sample_lib::main_lib)
gtest_discover_tests(unit_test)

# sanitizers
include(LinkSanitizers)
link_sanitizers(TARGETS unit_test)

# cmake --build ${PROJECT_BINARY_DIR} --target test-all
add_custom_target(
  test-all
  COMMAND ${CMAKE_COMMAND} --build ${PROJECT_BINARY_DIR} &&
          ${CMAKE_CTEST_COMMAND} ${CMAKE_CURRENT_BINARY_DIR}
          COMMENT "Build and test everything" USES_TERMINAL)
