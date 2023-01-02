% determines whether the game is finished (with no empty cells or with 
% an empty cell, but the player making the last move does not want to make it)
% and, if so, determines the winner
% game_over(+GameState, +CurrentPlayerPiece, +CurrentPlayerLevel, -Winner) :-
game_over(GameState, CurrentPlayerPiece, CurrentPlayerLevel, Winner) :-
    number_empty_cells(GameState, EmptyCells),
    EmptyCells < 2,
    last_move(EmptyCells, CurrentPlayerLevel, CurrentPlayerPiece,GameState, PlayerContinue),!,
    PlayerContinue == 0,
    value(GameState, 1, P1Points),
    value(GameState, -1, P2Points),
    ( P1Points > P2Points ->
    Winner = 'player 1'
    ; P1Points < P2Points ->
    Winner = 'player 2'
    ; Winner = 'tie' ),
    write('Winner: '), write(Winner), nl,
    write('Player 1 points: '), write(P1Points), nl,
    write('Player 2 points: '), write(P2Points), nl, sleep(5), menu.

% in case it is the last move of the game:
% -> human: asks if they want to play
% -> computer level 1: randomly chooses between playing or not
% -> computer level 2: considers if it improves the scores by playing or not
% last_move(+EmptyCells, +CurrentPlayerLevel, +CurrentPlayerPiece, -PlayerContinue)
last_move(0,_,_,_,0).
last_move(1,0,_,_,PlayerContinue) :- 
    ask_player_continue(PlayerContinue).
last_move(1,1,_,_,PlayerContinue) :- 
    random_member(PlayerContinue, [0,1]).
last_move(1,2,CurrentPlayerPiece,GameState,PlayerContinue) :- 
    value(GameState, CurrentPlayerPiece, CurrentPoints),
    valid_moves(GameState, [], ListOfMoves),
    nth0(0, ListOfMoves, Move),
    move(GameState, Move, CurrentPlayerPiece, NewGameState),
    value(NewGameState, CurrentPlayerPiece, NewPoints),!,
    CurrentPoints > NewPoints -> PlayerContinue = 1;
    PlayerContinue = 0.

% calculates the number of empty cells o(equal to 0) on the board
% number_empty_cells(+GameState, -EmptyCells)
number_empty_cells(GameState, EmptyCells) :-
    length(GameState, BoardSize),
    iterate_board(GameState,0,0,BoardSize,0,EmptyCells).

% iterates through the board, incrementing each time there's an empty cell
% iterate_board(+GameState, +X, +Y, +BoardSize, +EmptyCellsAux, -EmptyCellsFinal)
iterate_board(_,_,BoardSize,BoardSize,EmptyCellsAux,EmptyCellsFinal) :- EmptyCellsFinal = EmptyCellsAux, !.
iterate_board(GameState,X,Y,BoardSize,EmptyCellsAux,EmptyCellsFinal) :-
    X >= BoardSize
    -> Y1 is Y+1, iterate_board(GameState,0,Y1,BoardSize,EmptyCellsAux,EmptyCellsFinal)
    ; ( empty(GameState, [X,Y])
        -> NewEmptyCellsAux is EmptyCellsAux+1
        ; NewEmptyCellsAux is EmptyCellsAux ),
    X1 is X+1,
    iterate_board(GameState,X1,Y,BoardSize,NewEmptyCellsAux,EmptyCellsFinal).

% asks the human player if he wants to make the last move
% ask_player_continue(-PlayerContinue)
ask_player_continue(PlayerContinue) :-
    repeat,
    write('Do you want to play? (1 for yes 0 for no) '),
    read(PlayerContinue),
    validate_player_continue(PlayerContinue),
    !.

% checks if the answer to ask_player_continue is valid
%validate_player_continue(+PlayerContinue).
validate_player_continue(0).
validate_player_continue(1).