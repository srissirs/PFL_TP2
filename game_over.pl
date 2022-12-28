% game_over(+GameState, -Winner)
%% não há celas vazias (não há zeros)
game_over(GameState, Winner) :-
    number_empty_cells(GameState, EmptyCells),
    EmptyCells < 2,
    last_move(EmptyCells, PlayerContinue),
    PlayerContinue = 0,
    count_points(GameState, 1, P1Points),
    count_points(GameState, -1, P2Points),
    ( P1Points > P2Points ->
    Winner = 'player 1'
    ; P1Points < P2Points ->
    Winner = 'player 2'
    ; Winner = 'tie' ),
    write('Winner: ''), write(Winner), nl,
    write('Player 1 points: '), write(P1Points), nl,
    write('Player 2 points: '), write(P2Points), nl.

last_move(1,PlayerContinue) :- 
    ask_player_continue(PlayerContinue).

last_move(0,0).

number_empty_cells(GameState, EmptyCells) :-
    length(GameState, BoardSize),
    iterate_board(GameState,0,0,BoardSize,0,EmptyCells).

iterate_board(GameState,X,BoardSize,BoardSize,EmptyCellsAux,EmptyCellsFinal) :- EmptyCellsFinal = EmptyCellsAux, !.
iterate_board(GameState,X,Y,BoardSize,EmptyCellsAux,EmptyCellsFinal) :-
    X >= BoardSize
    -> Y1 is Y+1, iterate_board(GameState,0,Y1,BoardSize,EmptyCellsAux,EmptyCellsFinal)
    ; ( empty(GameState, [X,Y])
        -> NewEmptyCellsAux is EmptyCellsAux+1
        ; NewEmptyCellsAux is EmptyCellsAux ),
    X1 is X+1,
    iterate_board(GameState,X1,Y,BoardSize,NewEmptyCellsAux,EmptyCellsFinal).


ask_player_continue(PlayerContinue) :-
    repeat,
    write('Do you want to play? (1 for yes 0 for no) '),
    read(PlayerContinue),
    validate_player_continue(PlayerContinue),
    !.
validate_player_continue(0).
validate_player_continue(1).