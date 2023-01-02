:- use_module(library(lists)).

% substitui o valor na célula do Move ([X,Y]) pelo valor da pela do Player, criando um novo GameSate
move(GameState, [X,Y], Player, NewGameState) :-
    nth0(Y, GameState, Row),
    nth0(X, Row, Value),
    Value1 is Player,
    add_piece(Row, X, Value1, NewRow),
    add_piece(GameState, Y, NewRow, NewGameState).

% add_piece(+Lista, +Posição, +Valor, -NovaLista)
% cria uma nova lista a partir de Lista com o Valor na posição indicada
add_piece([_|T], 0, Value, [Value|T]).
add_piece([H|T], Pos, Value, [H|R]) :-
    Pos > 0,
    Pos1 is Pos-1,
    add_piece(T, Pos1, Value, R).