% creates the list of valid moves for the current (human) player;
% reads the input for the next move;
% checks if it's valid
% move_input(+GameState, +PlayerTurn, +LastMove, -Move)
move_input(GameState, PlayerTurn, LastMove, Move) :-
    valid_moves(GameState, LastMove, ListOfMoves),
    read_move_input(PlayerTurn,ListOfMoves, Move).

% asks and validates the player's input for the new piece
% read_move_input(+PlayerTurn, +ListOfMoves, -Move)
read_move_input(PlayerTurn,ListOfMoves, Move) :-
    repeat,
    write_player_turn(PlayerTurn),
    write('where do you want do put your new piece?'), nl,
    read_move_input_aux(Move),
    validate_move(Move, ListOfMoves),
    !.

% to write on the screen who's the player the question's referring to (the current player)
% write_player_turn(+PlayerTurn)
write_player_turn(1) :- write('Player 1, ').
write_player_turn(-1) :- write('Player 2, ').

% reads and checks if the input is a number
% read_move_input_aux(-Move)
% Move -> [Col, Row]
read_move_input_aux([ColInput, RowInput]) :-
    write('Column: '),
    read(ColInput),
    number(ColInput),
    write('Row: '), nl,
    read(RowInput),
    number(RowInput).

% in case the input is not valid (neither a number nor a valid place for the new piece),
% prints an error message
read_move_input_aux(_) :-
    write('Not a valid move.'), nl, fail.

% checks if the move entered is a valid move (if it's part of the list of valid moves)
% validate_move(+Move,+ListOfMoves)
validate_move([Col,Row],ListOfMoves) :-
    memberchk([Col,Row],ListOfMoves).