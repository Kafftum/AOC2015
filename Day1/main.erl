-module(main).

-export([start/0, lex/1]).

-record(accumulator, {total = 0, firstnegfloor = 0}).

start() ->
  Solution = run("test.txt"),
  io:format("Solution: ~p~n", [Solution#accumulator.firstnegfloor]).

run(Input) ->
  io:format("Solving: ~p~n", [Input]),
  solve(read(Input)).

read(Input) -> 
  case file:read_file(Input) of
    {ok, Bin} ->
      Content = configure(Bin),
      lex(Content);
    {error, Reason} ->
      exit(Reason)
  end.

configure(Input) ->
  case Input of
    Binary when is_binary(Binary) -> binary_to_list(Binary);
    Normal -> Normal
  end.

lex(Text) ->
  case dayone_lexer:string(Text) of
    {ok, Tokens, _EndLoc} -> Tokens;
    {error, Reason, Location} -> exit([Reason, Location])
  end.

solve(ParsedInput) ->
  ParseFunc = fun parse_func/2,
  lists:foldl(ParseFunc, #accumulator{}, ParsedInput).

parse_func({up, {Amount, Location}}, Acc) -> 
  NewTotal = Acc#accumulator.total + Amount,
  #accumulator{total = NewTotal, firstnegfloor = Acc#accumulator.firstnegfloor};

parse_func({down, {Amount, Location}}, Acc) -> 
  NewTotal = Acc#accumulator.total - Amount,
  FNG = case Acc#accumulator.firstnegfloor of
    -1 -> Location;
    Any -> undefined
  end,
  case FNG of
    undefined -> 
      #accumulator{total = NewTotal, firstnegfloor = Acc#accumulator.firstnegfloor};
    Some ->
      #accumulator{total = NewTotal, firstnegfloor = Some}
  end.
