-module(main).

-export([start/1, run/1, run2/1]).

-record(santaAcc, {santa = {{0,0},[]}, robo = {{0,0},[]}}).

start(Input = "input.txt") ->
  Basic = 
    fun(Elem) ->
        case Elem of
          {{_,_}, Times} when Times > 0 -> true
        end
    end,    

  Complex =
    fun(Elem) ->
      case Elem of
        {{_,_}, Times} when Times > 0 -> true
      end
    end,

  Solution = run(Input),
  BasicAnswer = length(lists:filter(Basic, Solution)),
  io:format("Solution: ~p~n", [BasicAnswer]),

  ComplSolution = run2(Input),
  ComplexAnswer = lists:filter(Complex, ComplSolution),
  io:format("Completed: ~p~n", [ComplSolution]).

run(Input) ->
  solve(read(Input)).

run2(Input) ->
  solve_complete(read(Input)).

read(Input) ->
  File = case file:read_file(Input) of
           {ok, Bin} -> configure(Bin);
           {error, Reason} -> exit(Reason)
         end,

  Tokens = lex(File),

  Ast = parse(Tokens),

  Ast.

configure(Binary) when is_binary(Binary) -> binary_to_list(Binary);
configure(Content) -> Content.

lex(File) ->
  case daythree_lexer:string(File) of
    {ok, Tokens, _L} -> Tokens;
    {error, Reason, EndLoc} -> exit([Reason, EndLoc])
  end.

parse(Tokens) ->
  case daythree_parser:parse(Tokens) of
    {ok, Ast} -> Ast;
    {error, Reason} -> exit(Reason)
  end.

solve({input, ParsedInput}) ->
  NormalFunc = fun normal_func/2,
  SecondFunc = fun second_func/2,

  Res = lists:foldl(NormalFunc, {{0, 0}, []}, ParsedInput),

  NewRes = 
    case Res of
      {Pos = {_,_}, Hist = [_|_]} -> 
        NewHist = [Pos|Hist],
        lists:reverse(NewHist);
      Any -> 
        io:format("~p~n", Any),
        exit("Was unable to properly form history data")
    end,

  lists:foldl(SecondFunc, [], NewRes).

normal_func(up, {Pos = {X, Y}, Hist}) when is_list(Hist) -> {{X, Y - 1}, [Pos|Hist]};
normal_func(down, {Pos = {X, Y}, Hist}) when is_list(Hist) -> {{X, Y + 1}, [Pos|Hist]};
normal_func(left, {Pos = {X, Y}, Hist}) when is_list(Hist) -> {{X - 1, Y}, [Pos|Hist]};
normal_func(right, {Pos = {X, Y}, Hist}) when is_list(Hist) -> {{X + 1, Y}, [Pos|Hist]}.

second_func(Coords = {_,_}, Acc) when is_list(Acc) ->
  {Flag, Record} = in(Coords, Acc),

  case Flag of
    true -> update(Record, Acc);
    false -> add(Coords, Acc)
  end.

in(_Element, []) -> {false, []};
in(Element, [Head|Rest]) -> 
  case Head of
    {Coords, Times} -> 
      case Coords == Element of
        true -> {true, Head};
        false -> in(Element, Rest)
      end;
    Any -> exit("Malformed array")
  end.

update(Element = {{X,Y}, Times}, Array) when is_list(Array) -> [{{X, Y}, Times + 1}|lists:subtract(Array, [Element])].

add(Element = {_,_}, Array) when is_list(Array) -> [{Element, 1}|Array].

solve_complete(ParsedInput) ->
  FirstFold = 
    fun(Elem, Acc) ->
        Santa = 
          case Elem of
            up -> {X, Y - 1};
            down -> {X, Y + 1};
            left -> {X - 1, Y};
            right -> {X + 1, Y}
          end, 

        RoboSanta =
          case Elem of
            up -> {X, Y - 1};
            down -> {X, Y + 1};
            left -> {X - 1, Y};
            right -> {X + 1, Y}
          end,

        NewSanta =
          {Santa, [Santa|Acc#santaAcc.santa]},

        NewRobo =
          {RoboSanta, [RoboSanta|Acc#santaAcc.robo]},

        #santaAcc{santa = NewSanta, robo = NewRobo}
    end,

  SecondFold = 
    fun(Elem, Acc) ->
      io:format("~p~n", [Elem])
      []
    end,

  FirstRes = lists:foldl(FirstFold, #santaAcc{}, ParsedInput),
  SecondRes = lists:foldl(SecondFold, [], FirstRes)


