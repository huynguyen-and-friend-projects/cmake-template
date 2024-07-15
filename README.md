# Cmake-template

## What's this

- A rather minimal CMake template project that you can use for your C or C++ project.

## Dependencies

> [!NOTE]
> You can actually get away without anything but Conan and Make installed.

- CMake (obviously)
- Make (optional, mainly for the convenience [Makefile](./Makefile))
- Ninja (default generator)
- ccmake (for the configured `make configure` convenience command to work)
- Conan (optional, but heavily recommended, for easy package managing)

## "Features"

- Some integration with ccache (universal).
- Some integration with lld, libASan, libUBSan and libMSan (gcc/clang only).
- Automatically configure and generate a pkg-config entry.
- Automatically configure and generate a man entry.
- Automatically configure and generate config and version config files for installation.
- Packing with CPack.
- Unit testing with Google Test.
- Download dependencies with Conan.
- Predefined convenient commands in [the Makefile](./Makefile)

## What to change

- [The main CMakeLists](./CMakeLists.txt):
  - At the very least, change the `project` configurations.

- Anything in the [source directory](./src/) and [test directory](./test/), obviously.

- The [installation config CMake module](./cmake/InstallConfigurations.cmake):
  - If you don't need a convenient installation for others to use, simply remove
  the `include(InstallConfigurations)` at the bottom of [the src CMakeLists](./src/CMakeLists.txt)

- The man page:
  - `@SAMPLE_LIB_MAN_HELP@` and `@SAMPLE_LIB_LICENSE@` are defined in the
  [installtion CMake module](./cmake/InstallConfigurations.cmake). `@SAMPLE_LIB_HELP_STRING@`
  is in [source CMakeLists](./src/CMakeLists.txt)
  - `@SAMPLE_LIB_LICENSE@` simply reads content of the license and
  remove the license header (in this case, "MIT License\n\n")
  - If you don't wish to have a man page, simply remove the
  `configure_file` and `install` of the man page in
  [installtion CMake module](./cmake/InstallConfigurations.cmake)

- Configuration option ([at cmake/ConfigureOptions](./cmake/ConfigureOptions.cmake)
[and CMakeOptions](./CMakeOptions.cmake)). Optional.
  - If you add/remove options in [CMakeOptions](./CMakeOptions.cmake), be sure to
  remove the matching configuration inside [cmake/ConfigureOptions](./cmake/ConfigureOptions.cmake)

- Add more options for [the Makefile](./Makefile). Optional.

## Options

> [!NOTE]
> Use `ccmake` or `cmake`-gui to more easily configure options

- Options and their defaults are defined in [CMakeOptions.cmake](./CMakeOptions.cmake).

- Extra notes for options:
  - Only turn on at max one of `ENABLE_ASAN`, `ENABLE_UBSAN`, or `ENABLE_MSAN`.
  - For `ccache` and `lld` options (`ENABLE_CCACHE` and `ENABLE_LLD` respectively),
  make sure these programs are installed on your machine, and is included in `PATH`.
  - There is a high chance `lld` doesn't work with `MSVC`, so it's currently just
  turned off for `MSVC`.
  - If you're debugging heavily templated code, turning off optimizations
  (`ENABLE_OPTIMIZATION=OFF`) is recommended.
  - If you're installing your library, please:
    1. Turn off testing (`ENABLE_TESTING=OFF`).
    2. Use some kind of Release mode (for obvious reasons).

## Other

- Q: How to configure options with `cmake` command?
- A: Pass each of them in as `-D${OPTION NAME}=${VALUE}`

- Q: The text editor keeps giving red squiggles.
- A: Try generate with `CMAKE_EXPORT_COMPILE_COMMANDS=ON`.
  - `ccmake`: Turn on advanced options and look for `CMAKE_EXPORT_COMPILE_COMMANDS`.
  - `cmake`: Pass in `-DCMAKE_EXPORT_COMPILE_COMMANDS=ON`.
  - NOTE: VS Code's CMake extension is somewhat stupid, so,
  use either of the listed two methods for consistent results.

- Q: How about Catch instead of Google Test?
- A: You're on your own. But here's [the Catch2 documentation for CMake](https://github.com/catchorg/Catch2/blob/devel/docs/cmake-integration.md#top).

- Q: How to use Conan?
- A: You can use the premade Makefile:
  - `make conan-install [CONAN_OPTIONS="[LIST OF OPTIONS]"]`
    - View options and their defaults with the command `make conan-option`
    - Check which packages of which versions are installed in [conanfile.py](./conanfile.py)
    - Example: `CONAN_OPTIONS="install_cmake=False install_ninja=True install_ccache=False"`
  - After that, run the newly symlinked file.

- Q: How to use a different generator?
- A: Say, you want to use Ninja.
  1. Delete the file `${YOUR BUILD DIR}/CMakeCache.txt`.
  2. If you use `ccmake`: `ccmake -B ${YOUR BUILD DIR} -G Ninja`.
  3. If you use `cmake`: `cmake -G Ninja -B ${YOUR BUILD DIR} ${ALL OTHER OPTIONS}`.

- Q: How to use a different compiler?
- A: Say, you want to use clang.
  1. Delete the file `${YOUR BUILD DIR}/CMakeCache.txt`.
  2. If you use `ccmake`:
  `ccmake -B ${YOUR BUILD DIR} -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_C_COMPILER=clang`.
  3. If you use `cmake`:
  `cmake -B ${YOUR BUILD DIR}
  -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_C_COMPILER=clang ${ALL OTHER OPTIONS}`.

- Q: Not liking CMake.
- A: Same :sob:.

## To-do

- Document the options inside the [Makefile](./Makefile)
  - For now, you need to read through the Makefile a little bit.
