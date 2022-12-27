
:- use_module(library(lists)).

isEmpty([]).
empty(Board, [X, Y]):-
    nth0(Y, Board, Row),
    nth0(X, Row, Value),
    Value == 0.

within_bounds(GameState, [NewX, NewY]):-
    length(GameState, L),
    NewX < L, NewY < L, NewX >= 0, NewY >= 0.

valid_move(GameState, [NewX, NewY]) :-
    within_bounds(GameState, [NewX, NewY]),
    empty(GameState, [NewX, NewY]).

check_if_empty(GameState,List,FinalList) :-
    isEmpty(List) ->
    length(GameState, L),
    check_lines(GameState, 0, L, 0, L,[],NewList),
    FinalList = NewList;
    FinalList = List.

%find_valid_moves(+GameState, [+LastX, +LastY], -ListOfMoves)
valid_moves(GameState, [LastX, LastY], ListOfMoves) :-
    X is LastX-1,
    LX is LastX+2,
    Y is LastY-1,
    LY is LastY+2,
    check_lines(GameState, X, LX, Y, LY,[],List),
    check_if_empty(GameState,List,FinalList),
    ListOfMoves = FinalList.


check_adjacent_line(_,_,XF,XF, List, Result) :-  Result = List,!.
check_adjacent_line(GameState,Y,X,XF ,List, Result) :-
    write(Y),nl,
    valid_move(GameState,[X,Y]) ->
    append(List,[[X,Y]],NewList),
    X1 is X+1,
    check_adjacent_line(GameState,Y,X1,XF, NewList,Result);
    X1 is X+1,
    check_adjacent_line(GameState,Y,X1,XF, List,Result).


check_lines(GameState, X,LastX, LY,LY, List, LineList) :- LineList = List,!.
check_lines(GameState, X,LastX, CurrY,LastY, List, LineList) :- 
    check_adjacent_line(GameState,CurrY,X,LastX, List, Result),
    Y is CurrY+1,
    check_lines(GameState, X,LastX ,Y,LastY, Result, LineList).


