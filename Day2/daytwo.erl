-module(daytwo).

-export([run/1, run2/1]).

run(Input) ->
  solve(read(Input)).

run2(Input) ->
  solve_complete(read(Input)).

solve({input, ParsedInput}) ->
  CalcPaper = fun calc_paper/2,
  lists:foldl(CalcPaper, 0, ParsedInput).

solve_complete({input, ParsedInput}) ->
  CalcRibbon = fun calc_ribbon/2,
  lists:foldl(CalcRibbon, 0, ParsedInput).

calc_paper(CurrElem = {L, W, H}, Acc) ->
  First = (L * W),
  Second = (W * H),
  Third = (L * H),

  Smallest = get_smallest(First, Second, Third),

  %%io:format("First side: ~p~nSecond side: ~p~nThird side: ~p~nSmallest side: ~p~n", [First, Second, Third, Smallest]),

  Acc + ((2 * First) + (2 * Second) + (2 * Third) + Smallest).

calc_ribbon(CurrElem = {L, W, H}, Acc) ->
  {LRes, RRes} = get_two_smallest(L, W, H),
  Acc + (2 * LRes) + (2 * RRes) + (L * W * H).

get_smallest(First, Second, Third) ->
  case First < Second of
    true -> case First < Third of
              true -> First;
              false -> Third
            end;
    false -> case Second < Third of
               true -> Second;
               false -> Third
             end
  end.

get_two_smallest(First, Second, Third) ->
  FirstSmallest =
    case First < Second of
      true -> First;
      false -> Second
    end,

  SecondSmallest = 
    case Second < Third of
      true when FirstSmallest == Second -> 
        case First < Third of
          true -> First;
          false -> Third
        end;
      true when FirstSmallest == First -> 
        case Second < Third of
          true -> Second;
          false -> Third
        end;
      false -> Third
    end,

  {FirstSmallest, SecondSmallest}.