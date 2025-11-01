Definitions.

UP    = \^
DOWN  = v
LEFT  = <
RIGHT = >
WS    = [\s\n\r\t]+

Rules.

{UP}     : {token, {up, TokenChars}}.
{DOWN}   : {token, {down, TokenChars}}.
{LEFT}   : {token, {left, TokenChars}}.
{RIGHT}  : {token, {right, TokenChars}}.
{WS}     : skip_token.

Erlang code.

tokens(Tokens) -> Tokens.
