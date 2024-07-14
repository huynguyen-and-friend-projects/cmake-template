#include <gtest/gtest.h>
#include "sample_lib.hxx"

TEST(test, sample_lib){
  main_lib::say_hello(main_lib::HelloLanguage::English);

  ASSERT_EQ(main_lib::get_hello(main_lib::HelloLanguage::English), "Hello");
  ASSERT_EQ(main_lib::get_hello(main_lib::HelloLanguage::German), "Hallo");
  ASSERT_EQ(main_lib::get_hello(main_lib::HelloLanguage::Spanish), "Hola");
  ASSERT_EQ(main_lib::get_lucky_number(), 42);
}
