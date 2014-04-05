-module(rebar_lol_compiler).
-export([compile/2, compile_lol/3]).

compile(Config, _AppFile) ->
    rebar_base_compiler:run(Config, [], "src", ".lol", "ebin", ".beam", fun compile_lol/3).

compile_lol(Source, Target, Config) ->
    case lol_compile:file(Source, Target) of
        {ok, _Mod, Warns} ->
            rebar_base_compiler:ok_tuple(Config, Source, Warns);
        {error, Errs, Warns} ->
            rebar_base_compiler:error_tuple(Config, Source, Errs, Warns, []);
        _ ->
            rebar_utils:abort()
    end.
