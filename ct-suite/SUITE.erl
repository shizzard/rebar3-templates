-module({{name}}_SUITE).
-compile([export_all, nowarn_export_all, nowarn_unused_function]).

-include_lib("common_test/include/ct.hrl").
-include_lib("eunit/include/eunit.hrl").
-include_lib("typr/include/typr_specs_eunit.hrl").
-include_lib("typr/include/typr_specs_ct.hrl").

-spec ?eunit_test(test).

all() -> [test1].

groups() -> [].

init_per_testcase(_Name, Config) -> Config.

end_per_testcase(_Name, _Config) -> ok.

-spec ?ct_test(test1).
test1(_Config) ->
    true.
