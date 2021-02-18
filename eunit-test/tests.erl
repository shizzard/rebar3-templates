-module({{name}}_tests).
-compile([export_all, nowarn_export_all, nowarn_unused_function]).

-include_lib("eunit/include/eunit.hrl").
-include_lib("typr/include/typr_specs_eunit.hrl").

-spec ?eunit_test(test).

-spec ?eunit_test(can_do_test).
can_do_test() ->
    ?assert(true).
