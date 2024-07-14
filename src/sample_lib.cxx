#define SAMPLE_LIB_USE_INTERNAL

#include "sample_lib.hxx"
// NOTE: you don't have to specify this is in internal/
#include "sample_lib_.hxx"
#include <iostream>
#include <string_view>

#undef SAMPLE_LIB_USE_INTERNAL

void main_lib::say_hello(HelloLanguage lang) {
  switch(lang){
    case HelloLanguage::English:
      std::cout << "Hello\n";
      break;
    case HelloLanguage::Spanish:
      std::cout << "Hola\n";
      break;
    case HelloLanguage::German:
      std::cout << "Hallo\n";
      break;
  }
}

auto main_lib::get_hello(HelloLanguage lang) -> std::string_view {
  switch(lang){
    case HelloLanguage::English:
      return "Hello";
    case HelloLanguage::Spanish:
      return "Hola";
    case HelloLanguage::German:
      return "Hallo";
    [[unlikely]] default:
      return "I don't know what this language is";
  }
}

auto main_lib::get_lucky_number() -> int {
  return sus_val;
}
