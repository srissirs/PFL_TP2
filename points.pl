% checks if the piece in cell [X,Y] is the PlayerPiece
% player_piece(+GameState, [+X, +Y], +PlayerPiece)
player_piece(GameState, [X, Y], PlayerPiece):-
    nth0(Y, GameState, Row),
    nth0(X, Row, Value),
    Value == PlayerPiece.

% main function that counts the points of a Player at a given GameState
% value(+GameState, +Player, -Points)
value(GameState, Player, Points) :-
    points_in_rows(GameState, Player, PiecesPointsRows),
    points_in_columns(GameState, Player, PiecesPointsCols),
    points_in_diagonals(GameState, Player, PiecesPointsDiags),
    append(PiecesPointsRows, PiecesPointsCols, PiecesPointsRowsCols),
    append(PiecesPointsRowsCols, PiecesPointsDiags, PiecesPoints),
    remove_duplicates(PiecesPoints, Result),
    length(Result, Points).

% removes duplicate values in a list
% remove_duplicates(+PiecesPoints, -NewPiecesPoints)
remove_duplicates(PiecesPoints, Result) :-
    remove_duplicates(PiecesPoints, [], Result).
remove_duplicates([], _, []).
remove_duplicates([Piece | Tail], Aux, Result) :-  % checks if the head element of the list is a member of the auxiliary list. If it is, it skips it and continues the recursion with the rest of the list. 
    member(Piece, Aux),
    !,
    remove_duplicates(Tail, Aux, Result).
remove_duplicates([Piece | Tail], Aux, [Piece|Result]) :-
    remove_duplicates(Tail, [Piece | Aux], Result).

% creates a list of the position of pieces of the given Player that belong 
% to a 4 in a row made in lines 
% points_in_rows(+GameState, +Player, -PiecesPoints)
points_in_rows(GameState, Player, PiecesPoints) :-
    length(GameState, BoardSize),
    iterate_rows(GameState, 0, 0, BoardSize, Player, [], 0, PiecesPoints).

% iterates through all rows, looking for a 4 in a row in a line
% iterate_rows(+GameState, +X, +Y, +BoardSize, +PlayerPiece, -PointsAux, +NumPieces, -PointsFinal) 
iterate_rows(_,_,BoardSize,BoardSize,_,PointsAux,_,PointsFinal) :- PointsFinal = PointsAux,!.
iterate_rows(GameState,X,Y,BoardSize,Player,PointsAux,NumPieces,PointsFinal) :-
    X >= BoardSize ->
    Y1 is Y+1, 
    iterate_rows(GameState,0,Y1,BoardSize,Player,PointsAux,0,PointsFinal)
    ; player_piece(GameState, [X, Y], Player) ->
        X1 is X+1,
        NumPieces1 is NumPieces+1,
        ( NumPieces1 = 4 ->
            append_rows(PointsAux, [X,Y], PointsAux1)
        ; NumPieces1 = 5 ->
            take_last_4(PointsAux, PointsAux1)
        ; PointsAux1 = PointsAux
        ),
        iterate_rows(GameState,X1,Y,BoardSize,Player,PointsAux1,NumPieces1,PointsFinal)
    ; X1 is X+1, iterate_rows(GameState,X1,Y,BoardSize,Player,PointsAux,0,PointsFinal)
    ;
    !.

% called when NumPieces (number of player's pieces in a row) is equal to 4;
% adds to the list of points pieces the current piece and the 3 previous pieces in the row
% append_rows(+PointsAux, [+X,+Y], -NewPointsAux)
append_rows(PointsAux, [X,Y], NewPointsAux) :-
    append(PointsAux, [[X,Y]], PointsAux1),
    X1 is X-1,
    append(PointsAux1, [[X1,Y]], PointsAux2),
    X2 is X1-1,
    append(PointsAux2, [[X2,Y]], PointsAux3),
    X3 is X2-1,
    append(PointsAux3, [[X3,Y]], NewPointsAux).

% creates a list of the position of pieces of the given Player that belong 
% to a 4 in a row made in columns 
% points_in_columns(+GameState, +Player, -PiecesPoints)
points_in_columns(GameState, Player, PiecesPoints) :-
    length(GameState, BoardSize),
    iterate_columns(GameState, 0, 0, BoardSize, Player, [], 0, PiecesPoints).

% iterates through all columns, looking for a 4 in a row in a column
% iterate_columns(+GameState, +X, +Y, +BoardSize, +PlayerPiece, -PointsAux, +NumPieces, -PointsFinal) 
iterate_columns(_,BoardSize,_,BoardSize,_,PointsAux,_,PointsFinal) :- PointsFinal = PointsAux,!.
iterate_columns(GameState,X,Y,BoardSize,Player,PointsAux,NumPieces, PointsFinal) :-
    Y >= BoardSize ->
    X1 is X+1, 
    iterate_columns(GameState,X1,0,BoardSize,Player,PointsAux,0,PointsFinal)
    ; player_piece(GameState, [X, Y], Player) ->
        Y1 is Y+1,
        NumPieces1 is NumPieces+1,
        ( NumPieces1 = 4 ->
            append_cols(PointsAux, [X,Y], PointsAux1)
        ; NumPieces1 = 5 ->
            take_last_4(PointsAux, PointsAux1)
        ; PointsAux1 = PointsAux),
        iterate_columns(GameState,X,Y1,BoardSize,Player,PointsAux1,NumPieces1,PointsFinal)
    ; Y1 is Y+1,iterate_columns(GameState,X,Y1,BoardSize,Player,PointsAux,0,PointsFinal)
    ;
    !.

% called when NumPieces (number of player's pieces in a row) is equal to 4;
% adds to the list of points pieces the current piece and the 3 previous pieces in the column
% append_cols(+PointsAux, [+X,+Y], -NewPointsAux)
append_cols(PointsAux, [X,Y], NewPointsAux) :-
    append(PointsAux, [[X,Y]], PointsAux1),
    Y1 is Y-1,
    append(PointsAux1, [[X,Y1]], PointsAux2),
    Y2 is Y1-1,
    append(PointsAux2, [[X,Y2]], PointsAux3),
    Y3 is Y2-1,
    append(PointsAux3, [[X,Y3]], NewPointsAux).


% creates a list of the position of pieces of the given Player that belong 
% to a 4 in a row made in diagonals 
% points_in_diagonals(+GameState, +Player, -PiecesPoints)
points_in_diagonals(GameState, Player, PiecesPoints) :-
    length(GameState, BoardSize),
    iterate_right_diagonals(GameState, 0, 0, 0, 0, BoardSize, Player, [], 0, PointsRight),
    iterate_left_diagonals(GameState, 0, 0, 0, 0, BoardSize, Player, [], 0, PointsLeft),
    append(PointsRight, PointsLeft, PiecesPoints).

% iterates through all diagonals from left to right, looking for a 4 in a row in a diagonal in that direction
% iterate_right_diagonals(+GameState, +X, +Y, +XMov, +YMov, +BoardSize, +PlayerPiece, -PointsAux, +NumPieces, -PointsFinal) 
iterate_right_diagonals(_,_,BoardSize,_,_,BoardSize,_,PointsAux,_,PointsFinal) :- PointsFinal = PointsAux,!.
iterate_right_diagonals(GameState,X,Y,XMov,YMov,BoardSize,Player,PointsAux,NumPieces,PointsFinal) :-
    X >= BoardSize ->
    Y1 is Y+1,
    iterate_right_diagonals(GameState,0,Y1,0,Y1,BoardSize,Player,PointsAux,0,PointsFinal)
    ; XMov >= BoardSize ->
    X1 is X+1,
    iterate_right_diagonals(GameState,X1,Y,X1,Y,BoardSize,Player,PointsAux,0,PointsFinal)
    ; YMov >= BoardSize ->
    X1 is X+1,
    iterate_right_diagonals(GameState,X1,Y,X1,Y,BoardSize,Player,PointsAux,0,PointsFinal)
    ; player_piece(GameState, [XMov, YMov], Player) ->
        XMov1 is XMov+1,
        YMov1 is YMov+1,
        NumPieces1 is NumPieces+1,
        ( NumPieces1 = 4, \+ test_5_right(GameState, [X,Y], Player) ->
            append_right_diagonals(PointsAux, [X,Y], PointsAux1)
        ; NumPieces1 = 5 ->
            take_last_4(PointsAux, PointsAux1)
        ; PointsAux1 = PointsAux),
        iterate_right_diagonals(GameState,X,Y,XMov1,YMov1,BoardSize,Player,PointsAux1,NumPieces1,PointsFinal)
    ; X1 is X+1, 
    iterate_right_diagonals(GameState,X1,Y,X1,Y,BoardSize,Player,PointsAux,0,PointsFinal)
    ;
    !.

% called when NumPieces (number of player's pieces in a row) is equal to 4;
% checks if the current piece has a piece that also belongs to the player in the previous cell on its diagonal
% test_5_right(+GameState, [+X,+Y], +Player)
test_5_right(GameState, [X,Y], Player) :-
    X1 is X-1,
    Y1 is Y-1,
    player_piece(GameState, [X1, Y1], Player).

% called when NumPieces (number of player's pieces in a row) is equal to 4;
% adds to the list of points pieces the current piece and the next 3 pieces in the diagonal (from left to right)
% append_right_diagonals(+PointsAux, [+X,+Y], -NewPointsAux)
append_right_diagonals(PointsAux, [X,Y], NewPointsAux) :-
    append(PointsAux, [[X,Y]], PointsAux1),
    X1 is X+1, Y1 is Y+1,
    append(PointsAux1, [[X1,Y1]], PointsAux2),
    X2 is X1+1, Y2 is Y1+1,
    append(PointsAux2, [[X2,Y2]], PointsAux3),
    X3 is X2+1, Y3 is Y2+1,
    append(PointsAux3, [[X3,Y3]], NewPointsAux).

% iterates through all diagonals from right to left, looking for a 4 in a row in a diagonal in that direction
% iterate_left_diagonals(+GameState, +X, +Y, +XMov, +YMov, +BoardSize, +PlayerPiece, -PointsAux, +NumPieces, -PointsFinal) 
iterate_left_diagonals(_,_,BoardSize,_,_,BoardSize,_,PointsAux,_,PointsFinal) :- PointsFinal = PointsAux,!.
iterate_left_diagonals(GameState,X,Y,XMov,YMov,BoardSize,Player,PointsAux,NumPieces,PointsFinal) :-
    X >= BoardSize ->
    Y1 is Y+1,
    iterate_left_diagonals(GameState,0,Y1,0,Y1,BoardSize,Player,PointsAux,0,PointsFinal)
    ; 0 > XMov ->
    X1 is X+1,
    iterate_left_diagonals(GameState,X1,Y,X1,Y,BoardSize,Player,PointsAux,0,PointsFinal)
    ; YMov >= BoardSize ->
    X1 is X+1,
    iterate_left_diagonals(GameState,X1,Y,X1,Y,BoardSize,Player,PointsAux,0,PointsFinal)
    ; player_piece(GameState, [XMov, YMov], Player) ->
        XMov1 is XMov-1,
        YMov1 is YMov+1,
        NumPieces1 is NumPieces+1,
        ( NumPieces1 = 4, \+ test_5_left(GameState, [X,Y], Player) ->
            append_left_diagonals(PointsAux, [X,Y], PointsAux1)
        ; NumPieces1 = 5 ->
            take_last_4(PointsAux,PointsAux1)
        ; PointsAux1 = PointsAux),
        iterate_left_diagonals(GameState,X,Y,XMov1,YMov1,BoardSize,Player,PointsAux1,NumPieces1,PointsFinal)
    ; X1 is X+1, 
    iterate_left_diagonals(GameState,X1,Y,X1,Y,BoardSize,Player,PointsAux,0,PointsFinal)
    ;
    !.

% called when NumPieces (number of player's pieces in a row) is equal to 4;
% checks if the current piece has a piece that also belongs to the player in the previous cell on its diagonal
% test_5_left(+GameState, [+X,+Y], +Player)
test_5_left(GameState, [X,Y], Player) :-
    X1 is X+1,
    Y1 is Y-1,
    player_piece(GameState, [X1, Y1], Player).

% called when NumPieces (number of player's pieces in a row) is equal to 4;
% adds to the list of points pieces the current piece and the next 3 pieces in the diagonal (from right to left)
% append_left_diagonals(+PointsAux, [+X,+Y], -NewPointsAux)
append_left_diagonals(PointsAux, [X,Y], NewPointsAux) :-
    append(PointsAux, [[X,Y]], PointsAux1),
    X1 is X-1, Y1 is Y+1,
    append(PointsAux1, [[X1,Y1]], PointsAux2),
    X2 is X1-1, Y2 is Y1+1,
    append(PointsAux2, [[X2,Y2]], PointsAux3),
    X3 is X2-1, Y3 is Y2+1,
    append(PointsAux3, [[X3,Y3]], NewPointsAux).

% called when NumPieces (number of player's tiles in a row) is equal to 5;
% removes from list of pieces with points the last 4 pieces, since they belong to a 4+ in a row
% take_last_4(+Points, -NewPoints) :- 
take_last_4(PointsAux, NewPointsAux) :- 
    append(NewPointsAux, Rest, PointsAux),
    length(Rest, 4).