% loop do modo de humano contra humano
player_vs_player(GameState, PlayerTurn, LastMove) :-
    print_board(GameState),
    \+ game_over(GameState,Winner),
    valid_moves(GameState, LastMove, ListOfMoves),
    read_move_input(PlayerTurn,ListOfMoves,NewRow,NewCol),
    move(GameState, [NewCol,NewRow], PlayerTurn, NewGameState),
    change_player(PlayerTurn, NewPlayerTurn),
    player_vs_player(NewGameState, NewPlayerTurn, [NewCol, NewRow]).

% loop do modo de computador contra computador
computer_vs_computer(GameState, PlayerTurn, LastMove) :-
    print_board(GameState),
    \+ game_over(GameState,Winner),
    choose_move(GameState,LastMove, Player, 1, Move),
    move(GameState, Move, PlayerTurn, NewGameState),
    change_player(PlayerTurn, NewPlayerTurn),
    computer_vs_computer(NewGameState, NewPlayerTurn, Move).

% trocar a vez do player
change_player(1,-1).
change_player(-1,1).