menu_header_format(Header):-
  format('~n~`*t ~p ~`*t~57|~n', [Header]).
menu_empty_format :-
  format('#~t#~57|~n', []).
clear :- write('\33\[2J').

menu_option_format(Option, Details):-
  format('#~t~d~t~15|~t~a~t~40+~t#~57|~n',
        [Option, Details]).
menu_sec_header_format(Label1, Label2):-
  format('#~t~a~t~15+~t~a~t~40+~t#~57|~n',
          [Label1, Label2]).
menu_bottom_format :-
  format('~`*t~57|~n', []).

menu_text_format(Text):-
  format('*~t~a~t*~57|~n', [Text]).

% banner(+String)
% Prints a banner with a String inside (UX)
banner(String):-
  format('~n~`*t~57|~n', []),
  format('*~t~a~t*~57|~n', [String]),
  format('~`*t~57|~n', []).
% banner(+String, +BoardSize)
% Prints a banner with info related to board size
% It is used to inform the user what's being selected
banner(String, BoardSize):-
  format('~n~`*t~57|~n', []),
  format('*~t~a - ~dx~d Board~t*~57|~n', [String, BoardSize, BoardSize]),
  format('~`*t~57|~n', []).
% banner(+String, +BoardSize, +Difficulty)
% Prints a banner with info related to board size and Difficulty
% It is used to inform the user what's being selected
banner(String, BoardSize, Difficulty):-
  format('~n~`*t~57|~n', []),
  format('*~t~a (~a) - ~dx~d Board~t*~57|~n', [String, Difficulty, BoardSize, BoardSize]),
  format('~`*t~57|~n', []).
% banner_bot(+BoardSize, +Difficulty)
% Prints a banner with info related to board size and Difficulty but only for PC vs PC
% It is used to inform the user what's being selected
banner_bot(BoardSize, Difficulty):-
  format('~n~`*t~57|~n', []),
  format('*~tComputer (~a) vs Computer - ~dx~d Board~t*~57|~n', [Difficulty, BoardSize, BoardSize]),
  format('~`*t~57|~n', []).

code_number(48, 0).
code_number(49, 1).
code_number(50, 2).
code_number(51, 3).
code_number(52, 4).
code_number(53, 5).
code_number(54, 6).
code_number(55, 7).
code_number(56, 8).
code_number(57, 9).


read_number(LowerBound, UpperBound, Number):-
  format('| Choose an Option (~d-~d) - ', [LowerBound, UpperBound]),
  get_code(NumberASCII),
  peek_char(Char),
  Char == '\n',
  code_number(NumberASCII, Number),
  Number =< UpperBound, Number >= LowerBound,skip_line.
read_number(LowerBound, UpperBound, Number):-
  write('Not a valid number, try again\n'), skip_line,
  read_number(LowerBound, UpperBound, Number).


menu_board_size(Size):-
  menu_header_format('Choose a Board Size'),
  menu_empty_format,
  menu_text_format('Insert the dimensions (max:24)'),nl,
  menu_empty_format,
  menu_bottom_format,
  read_number(2, 10, Size).


% Choose a difficulty for the bot
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

  read_number(0,2,Difficulty).

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
  menu_board_size(Size),
  difficulty_menu(Difficulty),
  play_menu_cp(Size,Difficulty).
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
  play_menu_cc(Size,Difficulty1, Difficulty2).
  %clear, menu.

%%%  PLAYER vs PLAYER
play_menu_pp(Size):-
  get_board(Size,GameState),
  start_game(GameState).

%%%  PLAYER vs COMPUTER
play_menu_cp(Size, 1):-
  get_board(Size,GameState),
  print_board(GameState).
  %start_game(GameState, 'Player', 'Easy').

play_menu_cp(Size, 2):-
  get_board(Size,GameState),
  print_board(GameState).
  %start_game(GameState, 'Player', 'Normal').

%%%  COMPUTER vs COMPUTER
play_menu_cc(Size, 1, 1):-
  get_board(Size,GameState),
  print_board(GameState).
  %start_game(GameState, 'Easy', 'Easy').

play_menu_cc(Size, 1, 2):-
  get_board(Size,GameState),
  print_board(GameState).
  %start_game(GameState, 'Easy', 'Normal').

  play_menu_cc(Size, 2, 1):-
  get_board(Size,GameState),
  print_board(GameState).
  %start_game(GameState, 'Normal', 'Easy').

play_menu_cc(Size, 2, 2):-
  get_board(Size,GameState),
  print_board(GameState).
  %start_game(GameState, 'Normal', 'Normal').
  
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
  read_number(0, 5, Number),
  menu_option(Number).


freedom :-
  write('         ____  ____  ____  ____  ____  _____  __  __'), nl,
  write('        ( ___)(  _ \\( ___)( ___)(  _ \\(  _  )(  \\/  )'), nl,
  write('         )__)  )   / )__)  )__)  )(_) ))(_)(  )    ( '),nl,
  write('        (__)  (_)\\_)(____)(____)(____/(_____)(_/\\/\\_)'),nl.