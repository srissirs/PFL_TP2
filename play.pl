% play/0
% first predicate, returns menu
play :-
  clear,
  menu.

% start_game(+GameState, +Player1Type, +Player2Type)
% starts a game with Player1 vs Player2
start_game(GameState, Player1Type, Player2Type):-
  clear, 
  display_game(GameState).
  