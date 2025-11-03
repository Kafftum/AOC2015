-module(main).

-export([start/0, lex/1]).

start() ->
  Solution = day_one:run("test.txt"),
  io:format("Solution: ~p~n", [accumulator:get_fng(Solution)]).
