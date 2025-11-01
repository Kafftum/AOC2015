erl -noshell -eval 'leex:file("daythree_lexer.xrl"),init:stop().'
erl -noshell -eval 'yecc:file("daythree_parser.yrl"),init:stop().'

erlc daythree_lexer.erl daythree_parser.erl main.erl

erl -noshell -eval 'main:start(),init:stop().'
