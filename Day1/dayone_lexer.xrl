Definitions.

OPEN_PAREN  = \(
CLOSE_PAREN = \)
NL          = [\n\s\r\t]+

Rules.

{OPEN_PAREN}+   : {token, {up, {TokenLen, TokenLoc}}}.
{CLOSE_PAREN}+  : {token, {down, {TokenLen, TokenLoc}}}.
{NL}            : skip_token.

Erlang code.

tokens(Tokens) -> Tokens.

