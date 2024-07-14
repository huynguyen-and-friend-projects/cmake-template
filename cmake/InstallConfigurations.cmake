# WARNING: calling "install" with ENABLE_TESTING will install the entire GTest
# suite also
install(TARGETS sample_lib DESTINATION ${CMAKE_INSTALL_LIBDIR})
install(FILES ${SAMPLE_LIB_PUBLIC_HEADERS}
        DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
install(FILES ${SAMPLE_LIB_PRIVATE_HEADERS}
        DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/sample_lib_internal)
configure_file(${PROJECT_SOURCE_DIR}/sample_lib.pc.in
               ${PROJECT_BINARY_DIR}/sample_lib.pc
               @ONLY)
install(FILES ${PROJECT_BINARY_DIR}/sample_lib.pc
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig)
