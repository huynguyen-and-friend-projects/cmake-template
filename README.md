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
- Unit testing with Google Test.
- Download dependencies with Conan.
- Predefined convenient commands in [the Makefile](./Makefile)

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
- A: You're on your own. But here's [the Catch2 documentation on CMake](https://github.com/catchorg/Catch2/blob/devel/docs/cmake-integration.md#top).

- Q: How to use Conan?

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
- A: Same :sad:.
