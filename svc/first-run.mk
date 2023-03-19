################################################################################
# Prepare

.EXPORT_ALL_VARIABLES:
.ONESHELL:
.DELETE_ON_ERROR:
.SHELLFLAGS := -eu -o pipefail -c
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules
SHELL := bash

################################################################################
# Default target

REBAR := $({{name_upper}}_DIR_ROOT)/rebar3
REBAR_LOCK := $({{name_upper}}_DIR_ROOT)/rebar.lock
{{name_upper}}_DIR_GIT := $({{name_upper}}_DIR_ROOT)/.git

ifeq (, $(shell which rebar3))
$(error "No rebar3 found in PATH")
endif

all: rm $(REBAR_LOCK) $({{name_upper}}_DIR_GIT)

.PHONY: rm
rm:
	rm first-run.mk
	sed '/first-run/{N;N;N;d;}' Makefile > Makefile.out
	mv Makefile.out Makefile

$(REBAR):
	cp `which rebar3` .

$(REBAR_LOCK): $(REBAR)
	./rebar3 get-deps

$({{name_upper}}_DIR_GIT):
	git init
	git add .
	git commit -m "Initial commit"
	git tag 0.0.0
