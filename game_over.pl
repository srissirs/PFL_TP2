% determina se o jogo está terminado (sem células vazias 
% ou com um célula vazia mas o jogador da última jogada não a quer realiazar)
% e, no caso afirmativo, determina o vencedor
game_over([Board,PlayerTurn], Winner, Level) :-
    number_empty_cells(GameState, EmptyCells),
    EmptyCells < 2,
    last_move(EmptyCells, Level, PlayerTurn, PlayerContinue),
    PlayerContinue = 0,
    value(GameState, 1, P1Points),
    value(GameState, -1, P2Points),
    ( P1Points > P2Points ->
    Winner = 'player 1'
    ; P1Points < P2Points ->
    Winner = 'player 2'
    ; Winner = 'tie' ),
    write('Winner: '), write(Winner), nl,
    write('Player 1 points: '), write(P1Points), nl,
    write('Player 2 points: '), write(P2Points), nl.

% no caso de ser a última jogada do jogo:
% -> humano: pergunta se quer jogar
% -> computador random: escolhe aleatoriamente entre a jogar ou não
% -> computador inteligente: pondera se melhora os pontuação jogar ou não
last_move(0,_,_,0).
last_move(1,0,_,PlayerContinue) :- 
    ask_player_continue(PlayerContinue).
last_move(1,1,_,PlayerContinue) :- 
    random_member(PlayerContinue, [0,1]).
last_move(1,Player,PlayerContinue,2) :- 
    value(GameState, Player, CurrentPoints),
    valid_moves(GameState, [], ListOfMoves),
    value(GameState, Player, NewPoints),!,
    CurrentPoints > NewPoints -> PlayerContinue = 1;
    PlayerContinue = 0.

% calcula o número de células vazias (iguais a 0) no tabuleiro
number_empty_cells(GameState, EmptyCells) :-
    length(GameState, BoardSize),
    iterate_board(GameState,0,0,BoardSize,0,EmptyCells).

% itera pelo tabuleiro, calculando o número de células vazias
iterate_board(GameState,X,BoardSize,BoardSize,EmptyCellsAux,EmptyCellsFinal) :- EmptyCellsFinal = EmptyCellsAux, !.
iterate_board(GameState,X,Y,BoardSize,EmptyCellsAux,EmptyCellsFinal) :-
    X >= BoardSize
    -> Y1 is Y+1, iterate_board(GameState,0,Y1,BoardSize,EmptyCellsAux,EmptyCellsFinal)
    ; ( empty(GameState, [X,Y])
        -> NewEmptyCellsAux is EmptyCellsAux+1
        ; NewEmptyCellsAux is EmptyCellsAux ),
    X1 is X+1,
    iterate_board(GameState,X1,Y,BoardSize,NewEmptyCellsAux,EmptyCellsFinal).

% pergunta ao humano se quer fazer a última jogada
ask_player_continue(PlayerContinue) :-
    repeat,
    write('Do you want to play? (1 for yes 0 for no) '),
    read(PlayerContinue),
    validate_player_continue(PlayerContinue),
    !.

% verifica se a resposta ask_player_continue foi a pretendida
validate_player_continue(0).
validate_player_continue(1).