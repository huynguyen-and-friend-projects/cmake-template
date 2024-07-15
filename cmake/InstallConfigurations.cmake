# WARNING: calling "install" with ENABLE_TESTING will install the entire GTest
# suite also
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
               ${PROJECT_BINARY_DIR}/sample_lib.1.in)
install(FILES ${PROJECT_BINARY_DIR}/sample_lib.1.in
        DESTINATION ${CMAKE_INSTALL_MANDIR}
        COMPONENT sample_exe)

install(
  FILES ${PROJECT_SOURCE_DIR}/cmake/sample_lib-config.cmake
        ${PROJECT_SOURCE_DIR}/cmake/sample_lib-config-version.cmake
  DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/cmake/sample_lib
  COMPONENT sample_lib)
install(
  TARGETS sample_exe
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
  PRIVATE_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/sample_lib)

# NOTE: please configure to install better docs
install(
  FILES ${PROJECT_SOURCE_DIR}/README.md
  DESTINATION ${CMAKE_INSTALL_DOCDIR}
  COMPONENT sample_lib_doc)
