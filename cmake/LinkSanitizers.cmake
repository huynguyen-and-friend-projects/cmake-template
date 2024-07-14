# ##############################################################################
# Link enabled sanitizers
# ##############################################################################
function(link_sanitizers)
  if(MSVC)
    message("Cannot use ASan, UBSan or MSan on MSVC")
  else()
    cmake_parse_arguments(LINK_SANITIZER "" "" "TARGETS" ${ARGN})

    if(ENABLE_ASAN)
      message("Enable address sanitizer")
      foreach(target ${LINK_SANITIZER_TARGETS})
        target_compile_options(
          ${target} PRIVATE "-fno-omit-frame-pointer;-fsanitize=address")
        target_link_options(${target} PRIVATE
                            "-fno-omit-frame-pointer;-fsanitize=address")
      endforeach()
    endif()

    if(ENABLE_UBSAN)
      message("Enable undefined behaviour sanitizer")
      foreach(target ${LINK_SANITIZER_TARGETS})
        target_compile_options(
          ${target} PRIVATE "-fno-omit-frame-pointer;-fsanitize=undefined")
        target_link_options(${target} PRIVATE
                            "-fno-omit-frame-pointer;-fsanitize=undefined")
      endforeach()
    endif()
    if(ENABLE_MSAN)
      message("Enable memory sanitizer")
      foreach(target ${LINK_SANITIZER_TARGETS})
        target_compile_options(
          ${target}
          PRIVATE "-fno-omit-frame-pointer;-fsanitize=memory;-fPIE;-pie")
        target_link_options(
          ${target} PRIVATE
          "-fno-omit-frame-pointer;-fsanitize=memory;-fPIE;-pie")
      endforeach()
    endif()
  endif()
endfunction()
