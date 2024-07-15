# ##############################################################################
# Configure CPack
# ##############################################################################

include(InstallRequiredSystemLibraries)
set(CPACK_RESOURCE_FILE_LICENSE ${PROJECT_SOURCE_DIR}/LICENSE)
set(CPACK_PACKAGE_VERSION_MAJOR ${PROJECT_VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${PROJECT_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${PROJECT_VERSION_PATCH})
set(CPACK_GENERATOR "TGZ;ZIP")
set(CPACK_SOURCE_GENERATOR "TGZ;ZIP")
include(CPack)
