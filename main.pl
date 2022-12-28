% MOVES EXECUTION
% move(+GameState, +Move, -NewGameState)
%% Move composed by [Row,Col]
move(GameState, [X,Y], Player, NewGameState) :-
    nth0(Y, GameState, Row),
    nth0(X, Row, Value),
    Value1 is Player,
    add_piece(Row, X, Value1, NewRow),
    add_piece(GameState, Y, NewRow, NewGameState).

add_piece([_|T], 0, Value, [Value|T]).
add_piece([H|T], Pos, Value, [H|R]) :-
    Pos > 0,
    Pos1 is Pos-1,
    add_piece(T, Pos1, Value, R).

% COMPUTER MOVE
% choose_move(+GameState, +Player, +Level, -Move)
%% user random on ListOfMoves

% GAME MODOS
%% player_vs_player(+GameState)
%% player_vs_computer(+GameState)
%% computer_vs_computer(+GameState)

player_vs_player(GameState, PlayerTurn, LastMove) :-
    print_board(GameState),
    \+ game_over(GameState,Winner),
    valid_moves(GameState, LastMove, ListOfMoves),
    read_move_input(PlayerTurn,ListOfMoves,NewRow,NewCol),
    move(GameState, [NewCol,NewRow], PlayerTurn, NewGameState),
    change_player(PlayerTurn, NewPlayerTurn),
    player_vs_player(NewGameState, NewPlayerTurn, [NewCol, NewRow]).


% PLAYER VS PLAYER
%% read_move_input(-Row,-Col)
read_move_input(PlayerTurn,ListOfMoves,Row,Col) :-
    repeat,
    write_player_turn(PlayerTurn),
    write('where do you want do put your new piece?'), nl,
    read_row_input(Row),
    read_col_input(Col),
    validate_move(Row,Col,ListOfMoves),
    !.

write_player_turn(1) :- write('Player 1, ').
write_player_turn(-1) :- write('Player 2, ').

read_row_input(RowInput) :-
    repeat,
    write('Row: '),
    read(RowInput),
    number(RowInput),
    !.

read_col_input(ColInput) :-
    repeat,
    write('Column: '),
    read(ColInput),
    number(ColInput),
    !.

%% validate_move(+Row,+Col,+ListOfMoves) --> checkar se está dentro do range e se está na ListOfMoves
%% to check if the move is valid:
%%  - has to be within the list of valid moves
%%  - cell has to be empty

validate_move(Row,Col,ListOfMoves) :-
    memberchk([Row,Col],ListOfMoves).

validate_move(_,_,_) :-
    write('Not a valid move.'), nl, fail.

%% change_player(+OldPlayerTurn,-NewPlayerTurn)
change_player(1,-1).
change_player(-1,1).