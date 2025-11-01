Nonterminals input moves move.

Terminals up down left right.

Rootsymbol input.

input -> moves : {input, '$1'}.

moves -> move       : ['$1'].
moves -> move moves : ['$1'|'$2'].

move -> up    : up.
move -> down  : down.
move -> left  : left.
move -> right : right.

Erlang code.

ast(AST) -> AST.

