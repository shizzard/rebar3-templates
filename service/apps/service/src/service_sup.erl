-module('{{name}}_sup').
-behaviour(supervisor).

-include_lib("typr/include/typr_specs_supervisor.hrl").

-export([start_link/0, init/1]).



%% Interface



-spec start_link() ->
  typr:generic_return(
    OkRet :: pid(),
    ErrorRet :: {already_started, pid()} | {shutdown, term()} | term()
  ).

start_link() ->
  supervisor:start_link({local, ?MODULE}, ?MODULE, []).



init([]) ->
  SupFlags = #{strategy => one_for_one, intensity => 1, period => 5},
  Children = [],
  {ok, {SupFlags, Children}}.



%% Internals
