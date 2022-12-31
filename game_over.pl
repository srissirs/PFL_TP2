% game_over(+GameState, -Winner)
%% não há celas vazias (não há zeros)
game_over([Board,PlayerTurn], Winner,Level) :-
    number_empty_cells(GameState, EmptyCells),
    EmptyCells < 2,
    last_move(EmptyCells, Level, PlayerTurn, PlayerContinue),
    PlayerContinue = 0,
    value(GameState, 1, P1Points),
    value(GameState, -1, P2Points),
    ( P1Points > P2Points ->
    Winner = 'player 1'
    ; P1Points < P2Points ->
    Winner = 'player 2'
    ; Winner = 'tie' ),
    write('Winner: '), write(Winner), nl,
    write('Player 1 points: '), write(P1Points), nl,
    write('Player 2 points: '), write(P2Points), nl.

last_move(0,_,_,0).
last_move(1,0,_,PlayerContinue) :- 
    ask_player_continue(PlayerContinue).
last_move(1,1,_,PlayerContinue) :- 
    random_member(PlayerContinue, [0,1]).
last_move(1,Player,PlayerContinue,2) :- 
    value(GameState, Player, CurrentPoints),
    valid_moves(GameState, [], ListOfMoves),
    value(GameState, Player, NewPoints),!,
    CurrentPoints > NewPoints -> PlayerContinue = 1;
    PlayerContinue = 0.


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