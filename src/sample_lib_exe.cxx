#define SAMPLE_LIB_USE_INTERNAL

#include "sample_lib.hxx"
#include "sample_lib_.hxx"
#include "sample_lib_exe_.hxx"
#include <cstdint>
#include <iostream>
#include <cstddef>
#include <string_view>
#include <span>
#include <type_traits>

#undef SAMPLE_LIB_USE_INTERNAL

enum class CmdOpt : std::uint8_t {
  Help = 1,
  GetHello = 2,
  LuckyNumber = 4,
};

struct CmdBitField {
  std::uint8_t options;
};

namespace {

void print_help() {
  std::cout << help_str;
}

constexpr auto cmdopt_value(CmdOpt opt) -> std::underlying_type_t<CmdOpt> {
  return static_cast<std::underlying_type_t<CmdOpt>>(opt);
}

constexpr auto has_value(std::uint8_t val, CmdOpt opt) -> bool {
  return (val & cmdopt_value(opt)) == cmdopt_value(opt);
}

auto parse_arguments(int argc, char *argv[]) -> CmdBitField { // NOLINT
  CmdBitField ret{};
  auto args = std::span(argv, static_cast<std::size_t>(argc));

  for(const char* val : args){
    const std::string_view str = val;
    if(str == "--help" || str == "-h"){
      ret.options |= static_cast<std::underlying_type_t<CmdOpt>>(CmdOpt::Help);    
      continue;
    }
    if(str == "--lucky-number" || str == "-ln"){
      ret.options |= static_cast<std::underlying_type_t<CmdOpt>>(CmdOpt::LuckyNumber);
      continue;
    }
  }

  return ret;
}

}

auto main (int argc, char *argv[])->int {
  if(argc == 0){
    print_help();
    return 1;
  }
  const CmdBitField bfield = parse_arguments(argc, argv);
  if(has_value(bfield.options, CmdOpt::Help)){
    print_help();
    return 0;
  }
  if(has_value(bfield.options, CmdOpt::LuckyNumber)) {
    std::cout << "Lucky number is " << main_lib::get_lucky_number() << "\n";
    return 0;
  }
  print_help();
  return 0;
}
