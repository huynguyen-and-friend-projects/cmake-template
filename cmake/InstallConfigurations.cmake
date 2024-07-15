# ##############################################################################
# Configure installation
# ##############################################################################

include(GNUInstallDirs)

install(
  TARGETS sample_lib
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
  PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
  PRIVATE_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/sample_lib)

install(TARGETS sample_exe DESTINATION ${CMAKE_INSTALL_BINDIR})

configure_file(${PROJECT_SOURCE_DIR}/sample_lib.pc.in
               ${PROJECT_BINARY_DIR}/sample_lib.pc @ONLY)
install(
  FILES ${PROJECT_BINARY_DIR}/sample_lib.pc
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig
  COMPONENT sample_lib)

configure_file(${PROJECT_SOURCE_DIR}/sample_lib.1.in
               ${PROJECT_BINARY_DIR}/sample_lib.1)
install(
  FILES ${PROJECT_BINARY_DIR}/sample_lib.1.in
  DESTINATION ${CMAKE_INSTALL_MANDIR}
  COMPONENT sample_exe)

install(TARGETS sample_exe DESTINATION ${CMAKE_INSTALL_BINDIR})

# NOTE: please configure to install better docs
install(
  FILES ${PROJECT_SOURCE_DIR}/README.md
  DESTINATION ${CMAKE_INSTALL_DOCDIR}
  COMPONENT sample_lib_doc)

include(CMakePackageConfigHelpers)

configure_package_config_file(
  ${PROJECT_SOURCE_DIR}/cmake/SampleLibConfig.cmake.in
  ${PROJECT_BINARY_DIR}/SampleLibConfig.cmake
  INSTALL_DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/cmake/sample_lib)

write_basic_package_version_file(
  "${PROJECT_BINARY_DIR}/SampleLibConfigVersion.cmake"
  VERSION ${PROJECT_VERSION}
  COMPATIBILITY SameMajorVersion)

install(FILES ${PROJECT_BINARY_DIR}/SampleLibConfig.cmake
              ${PROJECT_BINARY_DIR}/SampleLibConfigVersion.cmake
        DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/cmake/sample_lib)
