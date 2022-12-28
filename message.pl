:- consult('print_board.pl').
:- consult('logic.pl').
:- consult('points.pl').

% MOVES EXECUTION
% move(+GameState, +Move, -NewGameState)
%% Move composed by [Row,Col]
move(GameState, [X,Y], Player, NewGameState) :-
    nth0(Y, GameState, Row),
    nth0(X, Row, Value),
    Value1 is Player,
    add_piece(Row, X, Value1, NewRow),
    add_piece(GameState, Y, NewRow, NewGameState).

add_piece([_|T], 0, Value, [Value|T]).
add_piece([H|T], Pos, Value, [H|R]) :-
    Pos > 0,
    Pos1 is Pos-1,
    add_piece(T, Pos1, Value, R).
    
%% findall(Move,valid_move(GameState,LastMove,Move),Result). --> not working yet :/
%% valid_move(+GameState, +Player, [+LastX, +LastY], [+NewX, +NewY] )
valid_move(GameState, Player, [LastX, LastY], [NewX, NewY]) :-
    length(GameState, L+1),
    NewX >=0, NewX =< L, NewY >=0, NewY =< L, 
    abs(NewX - LastX) =< 1, abs(NewY - LastY) =< 1,
    empty(GameState, [NewX, NewY]).


% LIST OF VALID MOVES
% find_valid_moves(+GameState, +Player, +LastX, +LastY, -ListOfMoves) -> valid_moves

% BOARD EVALUATION
% value(+GameState, +Player, -Value) -> count_points

% COMPUTER MOVE
% choose_move(+GameState, +Player, +Level, -Move)
%% user random on ListOfMoves

% GAME MODOS
%% player_vs_player(+GameState)
%% player_vs_computer(+GameState)
%% computer_vs_computer(+GameState)

player_vs_player(GameState, PlayerTurn, LastMove) :-
    print_board(GameState),
    \+ game_over(GameState,Winner),
    valid_moves(GameState, LastMove, ListOfMoves),
    read_move_input(NewRow, NewCol),
    validate_move(ListOfMoves,NewRow,NewCol),
    move(GameState, [NewRow,NewCol], NewGameState),
    change_player(PlayerTurn, NewPlayerTurn),
    player_vs_player(NewGameState, NewPlayerTurn, [NewRow, NewCol]).

% PLAYER VS PLAYER
%% read_move_input(-Row,-Col)
read_move_input(Row,Col) :-
    write('Where do you want do put your new piece? '), % '4d' '4D'
    read(MoveInput),
    parse_move_input(MoveInput,Row,Col).

%% parse_move_input(+ListOfMoves,+MoveInput,-Row,-Col)
parse_move_input([RowString|ColString],Row,Col) :-
    number_string(Row,RowString),
    letter_to_num(Col,ColString).

%% !existente! number_string(?Number,?String).

%% letter_to_num(-ColNum,+ColLetter).
letter_to_num(1,'a').
letter_to_num(1,'A').
letter_to_num(2,'b').
letter_to_num(2,'B').
letter_to_num(3,'c').
letter_to_num(3,'C').
letter_to_num(4,'d').
letter_to_num(4,'D').
letter_to_num(5,'e').
letter_to_num(5,'E').
letter_to_num(6,'f').
letter_to_num(6,'F').
letter_to_num(7,'g').
letter_to_num(7,'G').
letter_to_num(8,'h').
letter_to_num(8,'H').
letter_to_num(9,'i').
letter_to_num(9,'I').
letter_to_num(10,'j').
letter_to_num(10,'J').
letter_to_num(11,'k').
letter_to_num(11,'K').
letter_to_num(12,'l').
letter_to_num(12,'L').
letter_to_num(13,'m').
letter_to_num(13,'M').
letter_to_num(14,'n').
letter_to_num(14,'N').
letter_to_num(15,'o').
letter_to_num(15,'O').
letter_to_num(16,'p').
letter_to_num(16,'P').
letter_to_num(17,'q').
letter_to_num(17,'Q').
letter_to_num(18,'r').
letter_to_num(18,'R').
letter_to_num(19,'s').
letter_to_num(19,'S').
letter_to_num(20,'t').
letter_to_num(20,'T').
letter_to_num(21,'u').
letter_to_num(21,'U').
letter_to_num(22,'v').
letter_to_num(22,'V').
letter_to_num(23,'w').
letter_to_num(23,'W').
letter_to_num(24,'x').
letter_to_num(24,'X').
letter_to_num(25,'y').
letter_to_num(25,'Y').
letter_to_num(26,'z').
letter_to_num(26,'Z').

%% validate_move(+Row,+Col,+ListOfMoves) --> checkar se está dentro do range e se está na ListOfMoves
%% to check if the move is valid:
%%  - has to be within the list of valid moves
%%  - cell has to be empty

validate_move(Row,Col,ListOfMoves) :-
    memberchk([Row,Col],ListOfMoves).

%% change_player(+OldPlayerTurn,-NewPlayerTurn)
change_player(player1,player2).
change_player(player1,player2).