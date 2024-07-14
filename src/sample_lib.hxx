#ifndef SAMPLE_LIB_HXX
#define SAMPLE_LIB_HXX

#include <string_view>
#include <cstdint>

namespace main_lib {
  enum class HelloLanguage : std::uint8_t {
    English = 0,
    Spanish = 1,
    German = 2,
  };

  /**
   * @brief Prints out the Hello of the specified language
   */
  void say_hello(HelloLanguage lang);
  /**
   * @brief Gets the Hello string translated to the specified language 
   */
  auto get_hello(HelloLanguage lang) -> std::string_view;

  auto get_lucky_number() -> int;
};

#endif // !SAMPLE_LIB_HXX
