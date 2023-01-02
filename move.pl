% replaces the value in cell [X,Y] (Move) with the value of the Player's piece, creating a new GameSate
% move(+GameState, [+X,+Y], +PlayerPiece, -NewGameState)
move(GameState, [X,Y], PlayerPiece, NewGameState) :-
    nth0(Y, GameState, Row),
    Value1 is PlayerPiece,
    add_piece(Row, X, Value1, NewRow),
    add_piece(GameState, Y, NewRow, NewGameState).

% creates a NewList from List with Value at the given Index
% add_piece(+List, +Index, +Value, -NewList)
add_piece([_|T], 0, Value, [Value|T]).
add_piece([H|T], Index, Value, [H|R]) :-
    Index > 0,
    Index1 is Index-1,
    add_piece(T, Index1, Value, R).