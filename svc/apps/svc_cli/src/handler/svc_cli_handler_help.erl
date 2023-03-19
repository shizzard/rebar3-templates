-module('{{name}}_cli_handler_help').
-behavior('{{name}}_cli_handler').
-dialyzer({nowarn_function, [config/0, dispatch/2]}).

-include("{{name}}_cli.hrl").
-include("{{name}}_cli_getopt.hrl").
-include("{{name}}_cli_handler.hrl").



%% Interface



config() ->
  [
    #getopt{s = {target, undefined, undefined, string, "Print help for action"}}
  ].

additional_help_string() -> "".

dispatch(#{target := Action}, _Rest) ->
  case lists:keyfind(Action, 1, {{name}}_cli_getopt:actions()) of
    {Action, Module, _HelpString} ->
      getopt:usage(
        {{name}}_cli_getopt:extract_getopt_config(
          [#getopt{s = {verbose, $v, "verbose", {boolean, false}, "Verbose"}} | Module:config()]
        ),
        escript:script_name() ++ " " ++ Action
      ),
      {{name}}_cli_log:log(Module:additional_help_string(), []);
    false ->
      {{name}}_cli:exit(?EXIT_CODE_INVALID_ACTION, "Invalid action: '~s'", [Action])
  end;

dispatch(#{}, _Rest) ->
  {{name}}_cli_getopt:default_help().



%% Internals
