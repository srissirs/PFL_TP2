:- use_module(library(lists)).
:- use_module(library(random)).
:- use_module(library(system)).

:- consult('logic.pl').
:- consult('display_game.pl').
:- consult('menu.pl').
:- consult('points.pl').
:- consult('game_over.pl').
:- consult('move_input.pl').
:- consult('move.pl').
:- consult('bot.pl').
:- consult('modes.pl').

% start_game(+GameState, +Player1Type, +Player2Type)
% starts a game with Player1 vs Player2
start_game(GameState, Player1Type, Player2Type):-
  clear, 
  game(GameState, Player1Type, Player2Type, 1, []).

% play/0
% first predicate, returns menu
play :-
  clear,
  menu.