-record(getopt, {
  % required?
  r = false :: boolean(),
  % list?
  l = false :: boolean(),
  % specification
  s = erlang:error(not_initialized) :: {{name}}_cli_getopt:getopt_config()
}).
