Nonterminals input operation.

Terminals number x.

Rootsymbol input.

input -> operation : {input, '$1'}.

operation -> number x number x number           : [{extract('$1'), extract('$3'), extract('$5')}].
operation -> number x number x number operation : [{extract('$1'), extract('$3'), extract('$5')}|'$6'].

Erlang code.

ast(Ast) -> Ast.

extract({number, Num}) -> list_to_integer(Num).
