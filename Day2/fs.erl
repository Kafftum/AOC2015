-module(fs).

-export([read/1, readp/1]).

-define(LEXER, daytwo_lexer).
-define(PARSER, daytwo_parser).

read(Input) ->
  lex(configure(open(Input))).

readp(Input) ->
  parse(lex(configure(open(Input)))).

open(File) ->
  case file:open_file(File) of
    {ok, Bin} -> Bin;
    {error, Reason} -> exit(Reason)
  end.

convert(Binary) when is_binary(Binary) -> binary_to_list(Binary);
convert(Content) -> Content.

lex(Text) ->
  case ?LEXER:string(Text) of
    {ok, Tokens, _EndLoc} -> Tokens;
    {error, Reason, Location} -> exit([Reason, Location])
  end.

parse(Tokens) ->
  case ?PARSER:parse(Tokens) of
    {ok, ParserResult} -> ParserResult;
    {error, Reason} -> exit(Reason)
  end.
