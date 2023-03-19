-module('{{name}}_cli').
-include("{{name}}_cli.hrl").

-export([main/1, exit/1, exit/2, exit/3, {{name}}_nodename/0]).



-spec main(Args :: [term()]) -> ok.

main(Args) ->
  Nodename = local_nodename(),
  net_kernel:start([Nodename, shortnames]),
  erlang:set_cookie(Nodename, {{name}}), %% magic here
  case net_adm:ping({{name}}_nodename()) of
    pong ->
      try
        {{name}}_cli_getopt:dispatch(Args),
        ?MODULE:exit(?EXIT_CODE_OK)
      catch T:E:S ->
        ?MODULE:exit(?EXIT_CODE_UNKNOWN, "Unexpected error: ~p:~p~n~p", [T, E, S])
      end;
    pang ->
      ?MODULE:exit(?EXIT_CODE_NODE_INACCESSIBLE, "Node ~p is not accessible (dead?)", [{{name}}_nodename()])
  end.



-spec exit(Code :: non_neg_integer()) ->
  no_return().

exit(Code) -> halt(Code).



-spec exit(Code :: pos_integer(), Reason :: list()) ->
  no_return().

exit(Code, Reason) ->
  ?MODULE:exit(Code, Reason, []).



-spec exit(Code :: non_neg_integer(), Reason :: list(), Args :: list()) ->
  no_return().

exit(0, Reason, Args) ->
  {{name}}_cli_log:log(Reason, Args),
  ?MODULE:exit(0);

exit(Code, Reason, Args) ->
  {{name}}_cli_log:error(Reason, Args),
  ?MODULE:exit(Code).



-spec {{name}}_nodename() -> atom().

{{name}}_nodename() ->
  nodename("{{name}}").



%% Internals



local_nodename() ->
  %% {{name}}-DDDDD, e.g. {{name}}-27635
  nodename(
    filename:basename(escript:script_name()) ++ "-"
    ++ erlang:integer_to_list(rand:uniform(99999))
  ).

nodename(Prefix) ->
  Host = net_adm:localhost(),
  list_to_atom(Prefix ++ "@" ++ Host).
