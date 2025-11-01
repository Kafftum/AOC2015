erl -noshell -eval 'leex:file("dayone_lexer.xrl"),init:stop().'

erlc dayone_lexer.erl main.erl

erl -noshell -eval 'main:start(),init:stop().'
