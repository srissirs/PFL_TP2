% pergunta e valida o input do jogador para a nova peça
read_move_input(PlayerTurn,ListOfMoves,Row,Col) :-
    repeat,
    write_player_turn(PlayerTurn),
    write('where do you want do put your new piece?'), nl,
    read_move_input_aux(Row,Col),
    validate_move(Row,Col,ListOfMoves),
    !.

% para escrever qual o jogador atual
write_player_turn(1) :- write('Player 1, ').
write_player_turn(-1) :- write('Player 2, ').

% lê e valida se o input introduzido é um número
read_move_input_aux(RowInput,ColInput) :-
    write('Row: '), nl,
    read(RowInput),
    number(RowInput),
    write('Column: '),
    read(ColInput),
    number(ColInput).

% valida o movimento introduzindo verificando se faz parte da lista de movimentos válidos
validate_move(Row,Col,ListOfMoves) :-
    memberchk([Col,Row],ListOfMoves).

% caso o movimento introduzido não seja válido, imprime uma mensagem de erro
validate_move(_,_,_) :-
    write('Not a valid move.'), nl, fail.