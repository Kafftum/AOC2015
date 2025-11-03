-module(day_one).

-export([run/1]).

run(Input) ->
  io:format("Solving: ~p~n", [Input]),
  solve(fs:read(Input)).

solve(ParsedInput) ->
  ParseFunc = fun parse_func/2,
  lists:foldl(ParseFunc, accumulator:new(), ParsedInput).

parse_func({up, {Amount, Location}}, Acc) -> 
  NewTotal = accumulator:get_total(Acc) + Amount,
  accumulator:new(NewTotal, accumulator:get_fng(Acc));

parse_func({down, {Amount, Location}}, Acc) -> 
  NewTotal = accumulator:get_total(Acc) - Amount,
  
  FNG = 
    case Acc#accumulator.firstnegfloor of
      Place when Place =< -1 -> Location;
      Any -> undefined
    end,

  case FNG of
    undefined -> accumulator:new(NewTotal, accumulator:get_fng(Acc));
    Some -> accumulator:edit(Acc, NewTotal, Some)
  end.