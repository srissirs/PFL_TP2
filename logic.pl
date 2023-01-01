:- use_module(library(lists)).

isEmpty([]).

% checks if the cell of the Move is empty
% empty(+GameState, +Move)
empty(GameState, [X, Y]):-
    nth0(Y, GameState, Row),
    nth0(X, Row, Value),
    Value == 0.

% checks if the Move is within bounds of the board
% within_bounds(+GameState, +Move)
within_bounds(GameState, [NewX, NewY]):-
    length(GameState, L),
    NewX < L, NewY < L, NewX >= 0, NewY >= 0.

% checks if a move is valid ( if it's within bounds of the board and if the cell is empty)
% valid_move(+GameState, +Move)
valid_move(GameState, [NewX, NewY]) :-
    within_bounds(GameState, [NewX, NewY]),
    empty(GameState, [NewX, NewY]).

% checks a line for empty cells in a given range of the board
% check_line(+GameState, +Y, +X, +LastX , +List, -Result) 
check_line(_,_, LastX, LastX, List, Result) :-  Result = List,!.
check_line(GameState, Y, X, LastX , List, Result) :-
    valid_move(GameState,[X,Y]) ->
    append(List,[[X,Y]],NewList),
    NewX is X+1,
    check_line(GameState,Y,NewX,LastX, NewList,Result);
    NewX is X+1,
    check_line(GameState,Y,NewX,LastX, List,Result).

% checks for empty cells in a given range of the board
% check_for_empty_cells(+GameState, +X, +LastX, +Y,+LastY, +List, -FinalList)
check_for_empty_cells(_, _,_, LastY,LastY, List, FinalList) :- FinalList = List,!.
check_for_empty_cells(GameState, X, LastX, Y,LastY, List, FinalList) :- 
    check_line(GameState,CurrY,X,LastX, List, Result),
    NewY is Y+1,
    check_for_empty_cells(GameState, X,LastX ,NewY,LastY, Result, FinalList).

% checks if it exists avaliable moves adjacent to the last move; if not returns list of moves with all the available cells in the board
% check_if_empty(+GameState,+AdjacentListOfMoves,-FinalList)
check_if_empty(GameState,AdjacentListOfMoves,FinalList) :-
    isEmpty(AdjacentListOfMoves) ->
    length(GameState, L),
    check_for_empty_cells(GameState, 0, L, 0, L,[],NewList),
    FinalList = NewList;
    FinalList = AdjacentListOfMoves.


% predicate that returns all the available moves for the next player
% valid_moves(+GameState, +LastMove, -ListOfMoves)
valid_moves(GameState, [], ListOfMoves):-
    length(GameState, L),
    check_for_empty_cells(GameState, 0, L, 0, L,[],NewList),
    ListOfMoves = NewList.
valid_moves(GameState, [LastX, LastY], ListOfMoves) :-
    X is LastX-1,
    LX is LastX+2,
    Y is LastY-1,
    LY is LastY+2,
    check_for_empty_cells(GameState, X, LX, Y, LY,[],AdjacentListOfMoves),
    check_if_empty(GameState,AdjacentListOfMoves,FinalList),
    ListOfMoves = FinalList.



