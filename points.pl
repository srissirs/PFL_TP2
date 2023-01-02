:- use_module(library(lists)).

% verifica se a peça na célula [X,Y] é do Player
player_piece(GameState, [X, Y], Player):-
    nth0(Y, GameState, Row),
    nth0(X, Row, Value),
    Value == Player.

% função principar para calcular os pontos do Player
value(GameState, Player, Points) :-
    points_in_rows(GameState, Player, PiecesPointsRows),
    points_in_columns(GameState, Player, PiecesPointsCols),
    points_in_diagonals(GameState, Player, PiecesPointsDiags),
    append(PiecesPointsRows, PiecesPointsCols, PiecesPointsRowsCols),
    append(PiecesPointsRowsCols, PiecesPointsDiags, PiecesPoints),
    remove_duplicates(PiecesPoints, Result),
    length(Result, Points).

% remove valores duplicados numa lista
remove_duplicates(PiecesPoints, Result) :-
    remove_duplicates(PiecesPoints, [], Result).
remove_duplicates([], _, []).
remove_duplicates([Piece | Tail], Aux, Result) :-  % checks if the head element of the list is a member of the auxiliary list. If it is, it skips it and continues the recursion with the rest of the list. 
    member(Piece, Aux),
    !,
    remove_duplicates(Tail, Aux, Result).
remove_duplicates([Piece | Tail], Aux, [Piece|Result]) :-
    remove_duplicates(Tail, [Piece | Aux], Result).

% cria uma lista de peças que pertencem a um 4 em linha feito numa linha 
points_in_rows(GameState, Player, PiecesPoints) :-
    length(GameState, BoardSize),
    iterate_rows(GameState, 0, 0, BoardSize, Player, [], 0, PiecesPoints).

% itera por todas as linhas, à procura de um 4 em linha numa linha
iterate_rows(GameState,X,BoardSize,BoardSize,Player,PointsAux,NumPieces,PointsFinal) :- PointsFinal = PointsAux,!.
iterate_rows(GameState,X,Y,BoardSize,Player,PointsAux,NumPieces,PointsFinal) :-
    X >= BoardSize ->
    Y1 is Y+1, 
    iterate_rows(GameState,0,Y1,BoardSize,Player,PointsAux,0,PointsFinal)
    ; player_piece(GameState, [X, Y], Player) ->
        X1 is X+1,
        NumPieces1 is NumPieces+1,
        ( NumPieces1 = 4 ->
            append_rows(PointsAux, [X,Y], PointsAux1)
        ; NumPieces1 = 5 ->
            take_last_4(PointsAux, PointsAux1)
        ; PointsAux1 = PointsAux
        ),
        iterate_rows(GameState,X1,Y,BoardSize,Player,PointsAux1,NumPieces1,PointsFinal)
    ; X1 is X+1, iterate_rows(GameState,X1,Y,BoardSize,Player,PointsAux,0,PointsFinal)
    ;
    !.

% chamada quando NumPieces (número de peças seguidas do jogador) é igual a 4;
% adiciona à lista de peças com pontos a peça atual (a ser iterada) e as 3 anteriores na linha
append_rows(PointsAux, [X,Y], NewPointsAux) :-
    append(PointsAux, [[X,Y]], PointsAux1),
    X1 is X-1,
    append(PointsAux1, [[X1,Y]], PointsAux2),
    X2 is X1-1,
    append(PointsAux2, [[X2,Y]], PointsAux3),
    X3 is X2-1,
    append(PointsAux3, [[X3,Y]], NewPointsAux).

% cria uma lista de peças que pertencem a um 4 em linha feito numa coluna 
points_in_columns(GameState, Player, PiecesPoints) :-
    length(GameState, BoardSize),
    iterate_columns(GameState, 0, 0, BoardSize, Player, [], 0, PiecesPoints).

% itera por todas as linhas, à procura de um 4 em linha numa coluna
iterate_columns(GameState,BoardSize,Y,BoardSize,Player,PointsAux,NumPieces,PointsFinal) :- PointsFinal = PointsAux,!.
iterate_columns(GameState,X,Y,BoardSize,Player,PointsAux,NumPieces, PointsFinal) :-
    Y >= BoardSize ->
    X1 is X+1, 
    iterate_columns(GameState,X1,0,BoardSize,Player,PointsAux,0,PointsFinal)
    ; player_piece(GameState, [X, Y], Player) ->
        Y1 is Y+1,
        NumPieces1 is NumPieces+1,
        ( NumPieces1 = 4 ->
            append_cols(PointsAux, [X,Y], PointsAux1)
        ; NumPieces1 = 5 ->
            take_last_4(PointsAux, PointsAux1)
        ; PointsAux1 = PointsAux),
        iterate_columns(GameState,X,Y1,BoardSize,Player,PointsAux1,NumPieces1,PointsFinal)
    ; Y1 is Y+1,iterate_columns(GameState,X,Y1,BoardSize,Player,PointsAux,0,PointsFinal)
    ;
    !.

% chamada quando NumPieces (número de peças seguidas do jogador) é igual a 4;
% adiciona à lista de peças com pontos a peça atual (a ser iterada) e as 3 anteriores na coluna
append_cols(PointsAux, [X,Y], NewPointsAux) :-
    append(PointsAux, [[X,Y]], PointsAux1),
    Y1 is Y-1,
    append(PointsAux1, [[X,Y1]], PointsAux2),
    Y2 is Y1-1,
    append(PointsAux2, [[X,Y2]], PointsAux3),
    Y3 is Y2-1,
    append(PointsAux3, [[X,Y3]], NewPointsAux).


% cria uma lista de peças que pertencem a um 4 em linha feito numa diagonal 
points_in_diagonals(GameState, Player, PiecesPoints) :-
    length(GameState, BoardSize),
    iterate_right_diagonals(GameState, 0, 0, 0, 0, BoardSize, Player, [], 0, PointsRight),
    iterate_left_diagonals(GameState, 0, 0, 0, 0, BoardSize, Player, [], 0, PointsLeft),
    append(PointsRight, PointsLeft, PiecesPoints).

% itera pelas todas as diagonais (da esquerda para a direita) à procura de um 4 em linha numa diagonal neste sentido
iterate_right_diagonals(GameState,X,BoardSize,XMov,YMov,BoardSize,Player,PointsAux,NumPieces,PointsFinal) :- PointsFinal = PointsAux,!.
iterate_right_diagonals(GameState,X,Y,XMov,YMov,BoardSize,Player,PointsAux,NumPieces,PointsFinal) :-
    X >= BoardSize ->
    Y1 is Y+1,
    iterate_right_diagonals(GameState,0,Y1,0,Y1,BoardSize,Player,PointsAux,0,PointsFinal)
    ; XMov >= BoardSize ->
    X1 is X+1,
    iterate_right_diagonals(GameState,X1,Y,X1,Y,BoardSize,Player,PointsAux,0,PointsFinal)
    ; YMov >= BoardSize ->
    X1 is X+1,
    iterate_right_diagonals(GameState,X1,Y,X1,Y,BoardSize,Player,PointsAux,0,PointsFinal)
    ; player_piece(GameState, [XMov, YMov], Player) ->
        XMov1 is XMov+1,
        YMov1 is YMov+1,
        NumPieces1 is NumPieces+1,
        ( NumPieces1 = 4, \+ test_5_right(GameState, [X,Y], Player) ->
            append_right_diagonals(GameState, Player, PointsAux, [X,Y], PointsAux1)
        ; NumPieces1 = 5 ->
            take_last_4(PointsAux, PointsAux1)
        ; PointsAux1 = PointsAux),
        iterate_right_diagonals(GameState,X,Y,XMov1,YMov1,BoardSize,Player,PointsAux1,NumPieces1,PointsFinal)
    ; X1 is X+1, 
    iterate_right_diagonals(GameState,X1,Y,X1,Y,BoardSize,Player,PointsAux,0,PointsFinal)
    ;
    !.

% chamada quando NumPieces (número de peças seguidas do jogador) é igual a 4;
% testa se a peça a ser iterada tem uma peça do jogador na continuação para cima da diagonal
test_5_right(GameState, [X,Y], Player) :-
    X1 is X-1,
    Y1 is Y-1,
    player_piece(GameState, [X1, Y1], Player).

% chamada quando NumPieces (número de peças seguidas do jogador) é igual a 4;
% adiciona à lista de peças com pontos a peça atual (a ser iterada) e as 3 seguintes na diagonal da esquerda para a direita
append_right_diagonals(GameState, Player, PointsAux, [X,Y], NewPointsAux) :-
    append(PointsAux, [[X,Y]], PointsAux1),
    X1 is X+1, Y1 is Y+1,
    append(PointsAux1, [[X1,Y1]], PointsAux2),
    X2 is X1+1, Y2 is Y1+1,
    append(PointsAux2, [[X2,Y2]], PointsAux3),
    X3 is X2+1, Y3 is Y2+1,
    append(PointsAux3, [[X3,Y3]], NewPointsAux).

% itera pelas todas as diagonais (da direita para a esquerda) à procura de um 4 em linha numa diagonal neste sentido
iterate_left_diagonals(GameState,X,BoardSize,XMov,YMov,BoardSize,Player,PointsAux,NumPieces,PointsFinal) :- PointsFinal = PointsAux,!.
iterate_left_diagonals(GameState,X,Y,XMov,YMov,BoardSize,Player,PointsAux,NumPieces,PointsFinal) :-
    X >= BoardSize ->
    Y1 is Y+1,
    iterate_left_diagonals(GameState,0,Y1,0,Y1,BoardSize,Player,PointsAux,0,PointsFinal)
    ; 0 > XMov ->
    X1 is X+1,
    iterate_left_diagonals(GameState,X1,Y,X1,Y,BoardSize,Player,PointsAux,0,PointsFinal)
    ; YMov >= BoardSize ->
    X1 is X+1,
    iterate_left_diagonals(GameState,X1,Y,X1,Y,BoardSize,Player,PointsAux,0,PointsFinal)
    ; player_piece(GameState, [XMov, YMov], Player) ->
        XMov1 is XMov-1,
        YMov1 is YMov+1,
        NumPieces1 is NumPieces+1,
        ( NumPieces1 = 4, \+ test_5_left(GameState, [X,Y], Player) ->
            append_left_diagonals(PointsAux, [X,Y], PointsAux1)
        ; NumPieces1 = 5 ->
            take_last_4(PointsAux,PointsAux1)
        ; PointsAux1 = PointsAux),
        iterate_left_diagonals(GameState,X,Y,XMov1,YMov1,BoardSize,Player,PointsAux1,NumPieces1,PointsFinal)
    ; X1 is X+1, 
    iterate_left_diagonals(GameState,X1,Y,X1,Y,BoardSize,Player,PointsAux,0,PointsFinal)
    ;
    !.

% chamada quando NumPieces (número de peças seguidas do jogador) é igual a 4;
% testa se a peça a ser iterada tem uma peça do jogador na continuação para cima da diagonal
test_5_left(GameState, [X,Y], Player) :-
    X1 is X+1,
    Y1 is Y-1,
    player_piece(GameState, [X1, Y1], Player).

% chamada quando NumPieces (número de peças seguidas do jogador) é igual a 4;
% adiciona à lista de peças com pontos a peça atual (a ser iterada) e as 3 seguintes na diagonal da esquerda para a direita
append_left_diagonals(PointsAux, [X,Y], NewPointsAux) :-
    append(PointsAux, [[X,Y]], PointsAux1),
    X1 is X-1, Y1 is Y+1,
    append(PointsAux1, [[X1,Y1]], PointsAux2),
    X2 is X1-1, Y2 is Y1+1,
    append(PointsAux2, [[X2,Y2]], PointsAux3),
    X3 is X2-1, Y3 is Y2+1,
    append(PointsAux3, [[X3,Y3]], NewPointsAux).

% chamada quando NumPieces (número de peças seguidas do jogador) é igual a 5;
% retira lista de peças com pontos as últimas 4 peças, pois pertencem a um 4+ em linha
take_last_4(PointsAux, NewPointsAux) :- 
    append(NewPointsAux, Rest, PointsAux),
    length(Rest, 4).