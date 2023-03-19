################################################################################
# Prepare

.EXPORT_ALL_VARIABLES:
.ONESHELL:
.DELETE_ON_ERROR:
.SHELLFLAGS := -eu -o pipefail -c
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules
SHELL := bash

ERLC := $(shell which erlc)
DOCKER := $(shell which docker)

{{name_upper}}_DIR_ROOT := $(abspath ./)
{{name_upper}}_DIR_APPS := $({{name_upper}}_DIR_ROOT)/apps
{{name_upper}}_DIR_CONFIG := $({{name_upper}}_DIR_ROOT)/config
{{name_upper}}_DIR_TESTS := $({{name_upper}}_DIR_ROOT)/tests
{{name_upper}}_DIR_BUILD := $({{name_upper}}_DIR_ROOT)/_build
{{name_upper}}_DIR_TOOLS := $({{name_upper}}_DIR_ROOT)/_tools
{{name_upper}}_DIR_LOGS := $({{name_upper}}_DIR_ROOT)/_logs

ifeq (, $(ERLC))
$(warning "No erlc found, is erlang installed?")
endif
ifeq (, $(DOCKER))
$(warning "No docker found, is it installed?")
endif

REQUIRED_DIRS = $({{name_upper}}_DIR_TOOLS) $({{name_upper}}_DIR_LOGS)
_MKDIRS := $(shell for d in $(REQUIRED_DIRS); do \
		[[ -d $$d ]] || mkdir -p $$d; \
	done)

define print_app_env
	@printenv | grep ^{{name_upper}} | grep -v print_app_env
endef

include env-vars.mk

################################################################################
# Default target

RELEASE_BIN := $({{name_upper}}_DIR_BUILD)/default/rel/{{name}}/bin/{{name}}
RELEASE_BIN_CLI := $({{name_upper}}_DIR_BUILD)/default/bin/{{name}}

RELEASE_TEST_BIN := $({{name_upper}}_DIR_BUILD)/test/rel/{{name}}/bin/{{name}}
RELEASE_TEST_BIN_CLI := $({{name_upper}}_DIR_BUILD)/test/bin/{{name}}

RELEASE_PROD_BIN := $({{name_upper}}_DIR_BUILD)/prod/rel/{{name}}/bin/{{name}}
RELEASE_PROD_BIN_CLI := $({{name_upper}}_DIR_BUILD)/prod/bin/{{name}}

SOURCE := $(shell find apps -iname "*.erl" -or -iname "*.hrl" -or -iname "*.app.src")
CONFIG := $({{name_upper}}_DIR_ROOT)/rebar.config $({{name_upper}}_DIR_CONFIG)/sys.config $({{name_upper}}_DIR_CONFIG)/vm.args

first-run:
	$(MAKE) -f first-run.mk
	$(MAKE)

.PHONY: all
all: $(CONFIG) $(RELEASE_BIN) $(RELEASE_BIN_CLI)

################################################################################
# Tools

{{name_upper}}_DIR_TOOLS_LUX := $({{name_upper}}_DIR_TOOLS)/lux
TOOL_LUX := $({{name_upper}}_DIR_TOOLS_LUX)/bin/lux
$(TOOL_LUX):
	git clone https://github.com/hawk/lux.git $({{name_upper}}_DIR_TOOLS_LUX)
	@cd $({{name_upper}}_DIR_TOOLS_LUX) && autoconf && ./configure && make

################################################################################
# Helpers

.PHONY: version
version:
	@echo $(shell git describe --tags)

################################################################################
# Erlang build

REBAR := $(abspath ./)/rebar3

$(RELEASE_BIN): $(SOURCE) $(CONFIG)
	$(REBAR) release

$(RELEASE_BIN_CLI): $(SOURCE) $(CONFIG)
	$(REBAR) escriptize

$(RELEASE_TEST_BIN): $(SOURCE) $(CONFIG)
	$(REBAR) as test release

$(RELEASE_TEST_BIN_CLI): $(SOURCE) $(CONFIG)
	$(REBAR) as test escriptize

$(RELEASE_PROD_BIN):
	$(REBAR) as prod release

$(RELEASE_PROD_BIN_CLI):
	$(REBAR) as prod escriptize

# latter targets are for production builds

.PHONY: release-prod
release-prod: $(RELEASE_PROD_BIN) $(RELEASE_PROD_BIN_CLI)

.PHONY: dockerize
dockerize:
	$(DOCKER) build --tag '{{name}}:$(shell git describe --tags)' $({{name_upper}}_DIR_ROOT)

################################################################################
# Erlang run

.PHONY: shell
shell: compile
	$(REBAR) shell

.PHONY: run
run: $(RELEASE_BIN)
	$(call print_app_env)
	$(RELEASE_BIN) console

################################################################################
# Erlang test

.PHONY: check
check: dialyze unit-tests integration-tests lux-tests

.PHONY: dialyze
dialyze:
	@echo "===== DIALYZER RUN ====="
	$(REBAR) as test dialyzer
	@echo "===== DIALYZER END ====="

.PHONY: unit-tests
unit-tests: $(RELEASE_TEST_BIN) $(RELEASE_TEST_BIN_CLI)
	@echo "=====   EUNIT RUN  ====="
	$(REBAR) as test eunit
	@echo "=====   EUNIT END  ====="

.PHONY: integration-tests
integration-tests: $(RELEASE_TEST_BIN) $(RELEASE_TEST_BIN_CLI)
	@echo "=====    CT RUN    ====="
	$(call print_app_env)
	$(REBAR) as test ct
	@echo "=====    CT END    ====="

.PHONY: lux-tests
{{name_upper}}_DIR_TESTS_LUX := $({{name_upper}}_DIR_TESTS)/lux
lux-tests: $(RELEASE_TEST_BIN) $(RELEASE_TEST_BIN_CLI) $(TOOL_LUX)
	@echo "=====    LUX RUN   ====="
	@$(foreach dir,\
		$(shell $(TOOL_LUX) --mode=list_dir $({{name_upper}}_DIR_TESTS_LUX)),\
		echo; echo " -> TESTCASE $(dir)"; $(MAKE) -C $(dir) build all; echo;)
	@echo "=====    LUX END   ====="

################################################################################
# Erlang clean

.PHONY: clean
clean:
	$(REBAR) clean -a

.PHONY: dist-clean
dist-clean: clean
	$(REBAR) unlock
	rm -rf _build
