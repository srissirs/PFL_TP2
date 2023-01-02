% in case the current player is a human (level 0)
game(GameState, 0, Player2Type, CurrentPlayerPiece, LastMove) :-
    display_game(GameState),
    \+ game_over(GameState, CurrentPlayerPiece, 0, Winner),
    move_input(GameState, CurrentPlayerPiece, LastMove, Move),
    move(GameState, Move, CurrentPlayerPiece, NewGameState),
    change_player(CurrentPlayerPiece, NewCurrentPlayerPiece),
    game(NewGameState, Player2Type, 0, NewCurrentPlayerPiece, Move).

% in case the current player is a computer level 1
game(GameState, 1, Player2Type, CurrentPlayerPiece, LastMove) :-
    display_game(GameState),
    \+ game_over(GameState, CurrentPlayerPiece, 1, Winner),
    choose_move(GameState,LastMove, Player, 1, Move),
    sleep(3),
    move(GameState, Move, CurrentPlayerPiece, NewGameState),
    change_player(CurrentPlayerPiece, NewCurrentPlayerPiece),
    game(NewGameState, Player2Type, 1, NewCurrentPlayerPiece, Move).

% in case the current player is a computer level 2
game(GameState, 2, Player2Type, CurrentPlayerPiece, LastMove) :-
    display_game(GameState),
    \+ game_over(GameState, CurrentPlayerPiece, 2, Winner),
    choose_move(GameState,LastMove, CurrentPlayerPiece, 2, Move),
    sleep(3),

    move(GameState, Move, CurrentPlayerPiece, NewGameState),
    change_player(CurrentPlayerPiece, NewCurrentPlayerPiece),
    game(NewGameState, Player2Type, 2, NewCurrentPlayerPiece, Move).

% exchange player turn
change_player(1,-1).
change_player(-1,1).