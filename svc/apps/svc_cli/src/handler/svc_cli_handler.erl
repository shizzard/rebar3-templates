-module({{name}}_cli_handler).

-callback config() ->
  {{name}}_cli_getopt:getopt_config().
-callback dispatch(ParsedArgs :: list(), Rest :: list()) ->
  ok.
-callback additional_help_string() ->
  string().
