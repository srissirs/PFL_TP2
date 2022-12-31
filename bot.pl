:- use_module(library(lists)).
:- use_module(library(random)).
:- consult('points.pl').
:- consult('logic.pl').

% predicate that compares if the points are higher for the player if he/she makes a certain move
compare_move(Move, GameState, Player, BestPoints, BestMove, NewBestPoints, NewBestMove):- 
    move(GameState, Move, Player, NewGameState),
    value(NewGameState, Player, Points),!,
    Points >= BestPoints -> NewBestPoints = Points, NewBestMove = Move; 
    NewBestPoints = BestPoints, NewBestMove = BestMove.

% predicate that chooses the best move within an availabe ListOfMoves
move_level2([],_,_,BestPoints, BestMove, FinalPoints, FinalMove):- FinalPoints = BestPoints, FinalMove = BestMove.
move_level2([H|T],GameState,Player,BestPoints, BestMove, FinalPoints,FinalMove):- 
    compare_move(H, GameState, Player, BestPoints, BestMove, NewBestPoints, NewBestMove),
    move_level2(T,GameState,Player,NewBestPoints, NewBestMove, FinalPoints,FinalMove).

%%choose_move(+GameState,+LastMove, +Player,+Level, -Move).
% choose the next best move (random)
choose_move(GameState,LastMove, Player, 1, Move):-
    valid_moves(GameState,LastMove,ListOfMoves),
    random_member(Move, ListOfMoves).

% choose the next best move (greedy)
choose_move(GameState,LastMove, Player, 2 , Move):-
    valid_moves(GameState,LastMove,ListOfMoves),
    value(GameState, Player, CurrentPoints),
    move_level2(ListOfMoves,GameState,Player,CurrentPoints, [], FinalPoints, Move).



wi:-choose_move( [
  [ 1, 0, 0, 0, 0, 0],
  [ 0, 1, 0, 0, 0, 0],
  [ 0, 1, 0, 0, 0, 0],
  [ 0, 0, 0, 0, 0, 0],
  [ 0, 1, 0, 1, 1, 0],
  [ 0, 1, 0, 0, 1, 0]],[2,2],1,2,X),write(X).

y:- compare_move([1,3], [
  [ 1, 1, 0, 0, 0, 0],
  [ 0, 1, 0, 0, 0, 0],
  [ 0, 1, 0, 0, 0, 0],
  [ 0, 0, 0, 0, 0, 0],
  [ 0, 0, 0, 0, 0, 0],
  [ 0, 0, 0, 0, 0, 0]
], 1, 0, [], NewBestPoints, NewBestMove),write(NewBestPoints),write(NewBestMove).

la:- move_level2([[0,1],[2,1],[0,2],[2,3],[1,3],[0,3]],  [
  [ 1, 0, 0, 0, 0, 0],
  [ 0, 1, 0, 0, 0, 0],
  [ 0, 1, 0, 0, 0, 0],
  [ 0, 0, 0, 0, 0, 0],
  [ 0, 1, 0, 1, 1, 0],
  [ 0, 1, 0, 0, 1, 0]],1,0,[0,2],X,Y), write(X), write(Y).

yy:- count_columns(
    [
  [ 1, 1, 0, 0, 0, 0],
  [ 0, 1, 0, 0, 0, 0],
  [ 0, 1, 0, 0, 0, 0],
  [ 0, 1, 0, 0, 0, 0],
  [ 0, 0, 0, 0, 0, 0],
  [ 0, 0, 0, 0, 0, 0]],1,X), write(X).






