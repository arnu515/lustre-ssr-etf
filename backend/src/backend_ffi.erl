-module(backend_ffi).

-export([get_port/0]).

get_port() ->
    case string:to_integer(os:getenv("PORT", "5000")) of
        {Port, _} when is_integer(Port) -> Port;
        _ -> 5000
    end.
