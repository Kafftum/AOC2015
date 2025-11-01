Definitions.

NUMBER = [0-9]+
X      = x
WS     = [\n\s\t\r]+

Rules.

{NUMBER} : {token, {number, TokenChars}}.
{X}      : {token, {x, TokenLen}}.
{WS}     : skip_token.

Erlang code.

tokens(Tokens) -> Tokens.
