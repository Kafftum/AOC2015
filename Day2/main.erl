-module(main).

-export([start/0]).

start() ->
  Input = "input.txt",

  Solution = daytwo:run("input.txt"),
  io:format("Solution: ~p~n", [Solution]),
  
  ComplSolution = daytwo:run2("input.txt"),
  io:format("Completed: ~p~n", [ComplSolution]).
