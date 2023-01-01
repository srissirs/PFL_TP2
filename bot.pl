:- use_module(library(lists)).
:- use_module(library(random)).
:- consult('points.pl').
:- consult('logic.pl').

% predicate that compares if the points are higher for the player if he/she makes a certain move
% compare_move(+Move, +GameState, +Player, +BestPoints, +BestMove, -NewBestPoints, -NewBestMove)
compare_move(Move, GameState, Player, BestPoints, BestMove, NewBestPoints, NewBestMove):- 
    move(GameState, Move, Player, NewGameState),
    value(NewGameState, Player, Points),!,
    Points >= BestPoints -> NewBestPoints = Points, NewBestMove = Move; 
    NewBestPoints = BestPoints, NewBestMove = BestMove.

% predicate that chooses the best move within an availabe ListOfMoves
% move_level2(ListOfMoves,+GameState,+Player,+BestPoints, +BestMove, -FinalMove)
move_level2([],_,_,BestPoints, BestMove, FinalMove):- FinalMove = BestMove.
move_level2([H|T],GameState,Player,BestPoints, BestMove,FinalMove):- 
    compare_move(H, GameState, Player, BestPoints, BestMove, NewBestPoints, NewBestMove),
    move_level2(T,GameState,Player,NewBestPoints, NewBestMove,FinalMove).

% choose_move(+GameState,+LastMove, +Player, +Level, -Move).
% choose the next best move (random)
choose_move(GameState,LastMove, Player, 1, Move):-
    valid_moves(GameState,LastMove,ListOfMoves),
    random_member(Move, ListOfMoves).

% choose the next best move (greedy)
choose_move(GameState,LastMove, Player, 2 , Move):-
    valid_moves(GameState,LastMove,ListOfMoves),
    value(GameState, Player, CurrentPoints),
    move_level2(ListOfMoves,GameState,Player,CurrentPoints, [], Move).

