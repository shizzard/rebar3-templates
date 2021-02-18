REBAR := $(abspath ./)/rebar3
ifeq ($(wildcard $(REBAR)),)
	REBAR := $(shell which rebar)
endif

.EXPORT_ALL_VARIABLES:

RELX_REPLACE_OS_VARS ?= true
{{name_upper}}_VMARGS_SNAME ?= {{name}}
{{name_upper}}_VMARGS_COOKIE ?= {{name}}
{{name_upper}}_VMARGS_LIMIT_ETS ?= 1024
{{name_upper}}_VMARGS_LIMIT_PROCESSES ?= 100000
{{name_upper}}_VMARGS_LIMIT_PORTS ?= 10000
{{name_upper}}_VMARGS_LIMIT_ATOMS ?= 100000
{{name_upper}}_VMARGS_ASYNC_THREADS ?= 8
{{name_upper}}_VMARGS_KERNEL_POLL ?= true
{{name_upper}}_APP_LOGGER_LOG_LEVEL ?= debug

define print_app_env
	@printenv | grep ^{{name_upper}} | grep -v print_app_env
endef

.PHONY: all get-deps compile release release-test release-prod shell run-release
.PHONY: check dialyze unit-tests integration-tests clean distclean

all: get-deps compile release

get-deps:
	$(REBAR) get-deps

compile:
	$(REBAR) compile

release:
	$(REBAR) release

release-test:
	$(REBAR) as test release

release-prod:
	$(REBAR) as prod release

shell: compile
	$(REBAR) shell

run-release: release
	$(call print_app_env)
	_build/default/rel/{{name}}/bin/{{name}} console

check: dialyze unit-tests integration-tests

dialyze:
	@echo "===== DIALYZER RUN ====="
	$(REBAR) as test dialyzer
	@echo "===== DIALYZER END ====="

unit-tests: release-test
	@echo "=====   EUNIT RUN  ====="
	$(REBAR) as test eunit
	@echo "=====   EUNIT END  ====="

integration-tests: release-test
	@echo "=====    CT RUN    ====="
	$(call print_app_env)
	$(REBAR) as test ct
	@echo "=====    CT END    ====="

clean:
	$(REBAR) clean -a

distclean:
	rm -rf _build

