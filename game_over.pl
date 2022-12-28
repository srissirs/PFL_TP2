% game_over(+GameState, -Winner)
%% não há celas vazias (não há zeros)
game_over(GameState, Winner) :-
    number_empty_cells(GameState, EmptyCells),
    EmptyCells < 2,
    ( EmptyCells = 1 ->
        ask_player_continue(PlayerContinue),
        PlayerContinue = 0,
        PlayerContinue = 0
    ; true ),
    count_points(GameState, 1, P1Points),
    count_points(GameState, -1, P2Points),
    ( P1Points > P2Points ->
    Winner = 'player 1: ',
    write(P1Points)
    ; P1Points < P2Points ->
    Winner = 'player 2'
    ; Winner = 'tie' ).

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
    write('Do you want to continue? (1 for yes 0 for no) '),
    read(PlayerContinue),
    ( PlayerContinue =:= 0; PlayerContinue =:= 1 ),
    !.
