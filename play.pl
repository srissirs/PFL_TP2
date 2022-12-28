:- consult('logic.pl').
:- consult('print_board.pl').
:- consult('menu.pl').
:- consult('points.pl').
:- consult('game_over.pl').
:- consult('main.pl').

% play/0
% first predicate, returns menu
play :-
  clear,
  menu.

% start_game(+GameState, +Player1Type, +Player2Type)
% starts a game with Player1 vs Player2
start_game(GameState):-
  clear, 
  player_vs_player(GameState,1,[]).
  