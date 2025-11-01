erl -noshell -eval 'leex:file("daytwo_lexer.xrl"),init:stop().'
erl -noshell -eval 'yecc:file("daytwo_parser.yrl"),init:stop().'

erlc daytwo_lexer.erl daytwo_parser.erl main.erl

erl -noshell -eval 'main:start(),init:stop().'
