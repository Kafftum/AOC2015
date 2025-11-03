-module(accumulator).

-export([new/0, new/2, edit/3, get_total/1, get_fng/1]).

-record(accumulator, {total = 0, firstnegfloor = 0}).

new() -> #accumulator{}.
new(Total, FNG) -> #accumulator{total = Total, firstnegfloor = FNG}.

edit(#accumulator{}, Total, FNG) -> #accumulator{total = Total, firstnegfloor = FNG}.

get_total(Acc = #accumulator{}) -> Acc#accumulator.total.
get_fng(Acc = #accumulator{}) -> Acc#accumulator.firstnegfloor.