#######################################################################
# Convenient commands
#
# For Windows users: good luck trying to run this without MSYS2/Cygwin.
#######################################################################

override MAKEFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
override MAKEFILE_DIR := $(patsubst %/Makefile,%,$(MAKEFILE_PATH))
override BUILD_DIR := $(MAKEFILE_DIR)/build
BUILD_TYPE := Debug
CONAN_OPTIONS := "install_cmake=False install_ccache=False"
override CONAN_OPTIONS_CMDLINE := $(foreach opt,$(CONAN_OPTIONS),$(patsubst %,-o options/all:%,$(opt)))

override COLOUR_GREEN := \033[32m
override COLOUR_CYAN := \033[36m
override STYLE_BOLD := \033[1m
override COLOUR_AND_STYLE_RESET := \033[0m

# install packages as configured in conanfile.py
.PHONY: conan-install
conan-install:
	mkdir -p $(BUILD_DIR)
	conan install . --output-folder=$(BUILD_DIR) --build=missing \
		--settings=build_type=$(BUILD_TYPE) \
		$(CONAN_OPTIONS_CMDLINE)
	@make conan-venv-help

# list custom options inside the conanfile.py
.PHONY: conan-option
conan-option:
	@echo
	@printf "$(STYLE_BOLD)"
	@cat conanfile.py | \
		tr '\n' ' ' | \
		grep -E -o "(default_)?options = {.*}" | \
  	sed -E "s/[ ]{2,}/\\n/g" | \
		sed -E "s/(.*):/\t\1:/g"
	@printf "$(COLOUR_AND_STYLE_RESET)"
	@echo

.PHONY: conan-venv-help
conan-venv-help:
	@echo
	@printf "$(COLOUR_GREEN)To activate Conan's environment, run the script\
$(COLOUR_AND_STYLE_RESET): $(STYLE_BOLD)$(shell find $(BUILD_DIR) -name "conanbuild.*")\n$(COLOUR_AND_STYLE_RESET)"
	@printf "$(COLOUR_GREEN)To deactivate Conan's environment, run the script\
$(COLOUR_AND_STYLE_RESET): $(STYLE_BOLD)$(shell find $(BUILD_DIR) -name "deactivate_conanbuild.*")\n$(COLOUR_AND_STYLE_RESET)"
	@echo

# Generate CMake with some defaults
.PHONY: generate
generate:
	@mkdir -p $(BUILD_DIR)
	cmake	-DCMAKE_BUILD_TYPE=$(BUILD_TYPE) \
		-DCMAKE_CXX_COMPILER=$(CXX) -DCMAKE_C_COMPILER=$(CC) \
		-DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
		-DCMAKE_TOOLCHAIN_FILE=$(BUILD_DIR)/conan_toolchain.cmake \
		-B $(BUILD_DIR) -S $(MAKEFILE_DIR)

# further configure CMake options
.PHONY: configure
configure: generate
	@ccmake -B build .

.PHONY: build
build:
	@cmake --build $(BUILD_DIR)

.PHONY: test
test:
	@ctest --test-dir $(BUILD_DIR)/test

.PHONY: install
install:
	@cmake --install $(BUILD_DIR)
