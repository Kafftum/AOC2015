-module(fs).

-export([read/1]).
-define(LEXER, dayone_lexer).

read(Input) ->
  case file:open_file(Input) of
    {ok, Bin} -> lex(configure(Bin));
    {error, Reason} -> exit(Reason)
  end.

configure(Input) ->
  case Input of
    Binary when is_binary(Binary) -> binary_to_list(Binary);
    Normal -> Normal
  end.

lex(Text) ->
  case ?LEXER:string(Text) of
    {ok, Tokens, _EndLoc} -> Tokens;
    {error, Reason, Location} -> exit([Reason, Location])
  end.