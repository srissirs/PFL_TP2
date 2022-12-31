
% predicate for displaying titles
% menu_header_format(+Header)
menu_header_format(Header):-
  format('~n~`*t ~p ~`*t~57|~n', [Header]).

% predicate for displaying empty lines
menu_empty_format :-
  format('#~t#~57|~n', []).

% predicate for clearing screen
clear :- 
  write('\33\[2J').

% predicate for displaying option in table
% menu_option_format(+Option, +Details)
menu_option_format(Option, Details):-
  format('#~t~d~t~15|~t~a~t~40+~t#~57|~n', [Option, Details]).
        
% predicate for displaying headers in table
% menu_sec_header_format(+Title1, +Title2)
menu_sec_header_format(Title1, Title2):-
  format('#~t~a~t~15+~t~a~t~40+~t#~57|~n', [Title1, Title2]).

% predicate for displaying bottom of menu
menu_bottom_format :-
  format('~`*t~57|~n', []).

% predicate for displaying a line of text
menu_text_format(Text):-
  format('#~t~a~t#~57|~n', [Text]).

% predicate for displaying a banner
% banner(+Text)
banner(Text):-
  format('~n~`*t~57|~n', []),
  format('*~t~a~t*~57|~n', [Text]),
  format('~`*t~57|~n', []).

% read input from user
% read_number(+LowerBound, +UpperBound, -Number) 
read_number(LowerBound, UpperBound, Number) :-
  repeat,
  write('Enter a number: '),
  read(Number),
  (   integer(Number),
      Number >= LowerBound,
      Number =< UpperBound
  ->  true
  ;   write('Invalid input, please try again.'),
      fail
  ).

% Choose a size for the board (until 24x24)
% menu_board_size(Size).
menu_board_size(Size):-
  menu_header_format('Choose a Board Size'),
  menu_empty_format,
  menu_text_format('Insert the dimensions (max:24)'),
  menu_empty_format,
  menu_bottom_format,
  read_number(4, 24, Size).


% Choose a difficulty for the bot
% difficulty_menu(-Difficulty).
difficulty_menu(Difficulty):-

  menu_header_format('Choose a Difficulty'),
  menu_empty_format,
  menu_sec_header_format('Option', 'Details'),
  menu_empty_format,
  menu_option_format(1, 'Easy (Random)'),
  menu_option_format(2, 'Normal (Greedy)'),
  menu_empty_format,
  menu_option_format(0, 'EXIT'),
  menu_empty_format,
  menu_bottom_format,

  read_number(0,2,Difficulty),!,
  (   Difficulty =:= 0
    ->  banner('Thank You For Playing'),fail
    ;   true
    ).


% Choose who plays first in Player vs Computer
% first_to_play_menu(-First).
first_to_play_menu(First):-
  menu_header_format('Choose who plays first'),
  menu_empty_format,
  menu_sec_header_format('Option', 'Details'),
  menu_empty_format,
  menu_option_format(1, 'You'),
  menu_option_format(2, 'Computer'),
  menu_empty_format,
  menu_option_format(0, 'EXIT'),
  menu_empty_format,
  menu_bottom_format,

  read_number(0,2,First),!,
  (   First =:= 0
    ->  banner('Thank You For Playing'),fail
    ;   true
    ).

% predicate for each menu option
% menu_option(+Option)
menu_option(0):-
  banner('Thank You For Playing').

% Player vs PLayer
menu_option(1):-
  clear,
  banner('Player vs PLayer'),
  menu_board_size(Size),
  clear, play_menu_pp(Size), !.

% Player vs Computer
menu_option(2):-
  clear,
  banner('Player vs Computer'),
  menu_board_size(Size),!,
  difficulty_menu(Difficulty),!,
  first_to_play_menu(First),!,
  play_menu_cp(Size,Difficulty,First).
  %clear, menu.

% Computer vs Computer
menu_option(3):-
  clear,
  banner('Computer vs Computer'),
  menu_board_size(Size),
  clear,
  banner('Difficulty for Player 1'),
  difficulty_menu( Difficulty1),
  clear,
  banner('Difficulty for Player 2'),
  difficulty_menu(Difficulty2),
  play_menu_cc(Size, Difficulty1, Difficulty2).
  %clear, menu.

%%%  PLAYER vs PLAYER
play_menu_pp(Size):-
  initial_state(Size,GameState),
  start_game(GameState).

%%%  PLAYER vs COMPUTER
% Human plays first with level 1 computer
play_menu_cp(Size, 1,1):-
  initial_state(Size,GameState),
  print_board(GameState).
  %start_game(GameState, 'Player', 'Easy').

% Human plays first with level 2 computer
play_menu_cp(Size, 2, 1):-
  initial_state(Size,GameState),
  print_board(GameState).
  %start_game(GameState, 'Player', 'Normal').

% Human plays second with level 1 computer
play_menu_cp(Size, 1,2):-
  initial_state(Size,GameState),
  print_board(GameState).
  %start_game(GameState, 'Player', 'Easy').

% Human plays second with level 2 computer
play_menu_cp(Size, 2, 2):-
  initial_state(Size,GameState),
  print_board(GameState).
  %start_game(GameState, 'Player', 'Normal').

%%%  COMPUTER vs COMPUTER
play_menu_cc(Size, 1, 1):-
  initial_state(Size,GameState),
  print_board(GameState).
  %start_game(GameState, 'Easy', 'Easy').

play_menu_cc(Size, 1, 2):-
  initial_state(Size,GameState),
  print_board(GameState).
  %start_game(GameState, 'Easy', 'Normal').

  play_menu_cc(Size, 2, 1):-
  initial_state(Size,GameState),
  print_board(GameState).
  %start_game(GameState, 'Normal', 'Easy').

play_menu_cc(Size, 2, 2):-
  initial_state(Size,GameState),
  print_board(GameState).
  %start_game(GameState, 'Normal', 'Normal').

% main menu
menu :-
  clear,
  freedom,
  menu_header_format('MAIN MENU'),
  menu_empty_format,
  menu_sec_header_format('Option', 'Details'),
  menu_empty_format,
  menu_option_format(1, 'Player vs Player'),
  menu_option_format(2, 'Player vs Computer'),
  menu_option_format(3, 'Computer vs Computer'),
  menu_option_format(4, 'Game Intructions'),
  menu_option_format(5, 'Information about project'),
  menu_empty_format,
  menu_option_format(0, 'EXIT'),
  menu_empty_format,
  menu_bottom_format,

  read_number(0, 5, Number),!,
  menu_option(Number).


freedom :-
  write('       ____  ____  ____  ____  ____  _____  __  __'), nl,
  write('      ( ___)(  _ \\( ___)( ___)(  _ \\(  _  )(  \\/  )'), nl,
  write('       )__)  )   / )__)  )__)  )(_) ))(_)(  )    ( '),nl,
  write('      (__)  (_)\\_)(____)(____)(____/(_____)(_/\\/\\_)'),nl.

