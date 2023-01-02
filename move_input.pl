move_input(GameState, PlayerTurn, LastMove, Move) :-
    valid_moves(GameState, LastMove, ListOfMoves),
    read_move_input(PlayerTurn,ListOfMoves, Move).

% pergunta e valida o input do jogador para a nova peça
read_move_input(PlayerTurn,ListOfMoves, Move) :-
    repeat,
    write_player_turn(PlayerTurn),
    write('where do you want do put your new piece?'), nl,
    read_move_input_aux(Move),
    validate_move(Move, ListOfMoves),
    !.

% para escrever qual o jogador atual
write_player_turn(1) :- write('Player 1, ').
write_player_turn(-1) :- write('Player 2, ').

% lê e valida se o input introduzido é um número
read_move_input_aux([ColInput, RowInput]) :-
    write('Column: '),
    read(ColInput),
    number(ColInput),
    write('Row: '), nl,
    read(RowInput),
    number(RowInput).

% caso o movimento introduzido ou o input não seja válido, imprime uma mensagem de erro
read_move_input_aux(_) :-
    write('Not a valid move.'), nl, fail.

% valida o movimento introduzindo verificando se faz parte da lista de movimentos válidos
validate_move([Col,Row],ListOfMoves) :-
    memberchk([Col,Row],ListOfMoves).