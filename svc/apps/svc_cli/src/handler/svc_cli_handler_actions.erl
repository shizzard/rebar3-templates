-module({{name}}_cli_handler_actions).
-behavior({{name}}_cli_handler).
-include("{{name}}_cli.hrl").
-include("{{name}}_cli_getopt.hrl").
-include("{{name}}_cli_handler.hrl").



%% Interface



config() ->
  [].

additional_help_string() -> "".

dispatch(_ParsedArgs, _Rest) ->
  {{name}}_cli_log:log(lists:flatten([
    io_lib:format("~-20s ~s~n", [Action, HelpString]) || {Action, _Module, HelpString}
    <- {{name}}_cli_getopt:actions()
  ])).



%% Internals
