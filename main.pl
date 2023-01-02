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


computer_vs_computer(GameState, PlayerTurn, LastMove) :-
    print_board(GameState),
    \+ game_over(GameState,Winner),
    choose_move(GameState,LastMove, Player, 1, Move),
    move(GameState, Move, PlayerTurn, NewGameState),
    change_player(PlayerTurn, NewPlayerTurn),
    computer_vs_computer(NewGameState, NewPlayerTurn, Move).


%% change_player(+OldPlayerTurn,-NewPlayerTurn)
change_player(1,-1).
change_player(-1,1).