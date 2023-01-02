% PLAYER VS PLAYER
%% read_move_input(-Row,-Col)
read_move_input(PlayerTurn,ListOfMoves,Row,Col) :-
    repeat,
    write_player_turn(PlayerTurn),
    write('where do you want do put your new piece?'), nl,
    read_move_input_aux(Row,Col),
    validate_move(Row,Col,ListOfMoves),
    !.

write_player_turn(1) :- write('Player 1, ').
write_player_turn(-1) :- write('Player 2, ').

read_move_input_aux(RowInput,ColInput) :-
    write('Row: '), nl,
    read(RowInput),
    number(RowInput),
    write('Column: '),
    read(ColInput),
    number(ColInput).

%% validate_move(+Row,+Col,+ListOfMoves) --> checkar se está dentro do range e se está na ListOfMoves
%% to check if the move is valid:
%%  - has to be within the list of valid moves

validate_move(Row,Col,ListOfMoves) :-
    memberchk([Col,Row],ListOfMoves).

validate_move(_,_,_) :-
    write('Not a valid move.'), nl, fail.