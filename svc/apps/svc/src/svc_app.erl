-module('{{name}}_app').
-behaviour(application).

-include_lib("typr/include/typr_specs_application.hrl").

-export([start/2, stop/1]).



%% Interface



start(_StartType, _StartArgs) ->
  {{name}}_sup:start_link().



stop(_State) ->
  ok.



%% Internals
