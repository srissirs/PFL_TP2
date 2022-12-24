
% MOVES EXECUTION
% move(+GameState, +Move, -NewGameState)
%% Move composed by [Row,Col]
move(GameState, [Row,Col],NewGameState) :-
    add_piece(GameState,[NewRow,NewCol]),
    change_player(OldPlayerTurn,NewPlayerTurn).

%% empty(+GameState,[+X, +Y]) --> check if that cell is empty to play
empty(GameState, [X, Y]):-
    nth0(Y, GameState, Row),
    nth0(X, Row, Value),
    Value == 0.

%% findall(Move,valid_move(GameState,LastMove,Move),Result). --> not working yet :/
%% valid_move(+GameState, +Player, [+LastX, +LastY], [+NewX, +NewY] )
valid_move(GameState, Player, [LastX, LastY], [NewX, NewY]) :-
length(GameState, L+1),
NewX >=0, NewX =< L, NewY >=0, NewY =< L, 
abs(NewX - LastX) =< 1, abs(NewY - LastY) =< 1,
empty(GameState, [NewX, NewY]).


% LIST OF VALID MOVES
% valid_moves(+GameState, +Player, +LastX, +LastY, -ListOfMoves)


% END OF GAME
% game_over(+GameState, -Winner)

% BOARD EVALUATION
% value(+GameState, +Player, -Value)

% COMPUTER MOVE
% choose_move(+GameState, +Player, +Level, -Move)
%% user random on ListOfMoves

%% player_vs_player(+GameState)
%% player_vs_computer(+GameState)
%% computer_vs_computer(+GameState)

player_vs_player(GameState) :-
    display_game(GameState),
    game_over(GameState,Winner),
    !,
    valid_moves(GameState, ListOfMoves),
    read_move_input(ListOfMoves,Row,Col),
    validate_move(ListOfMoves,Row,Col),
    move(GameState, [Row,Col], NewGameState),   
    player_vs_player(NewGameState).


%% read_move_input(+ListOfMoves,-Row,-Col)
read_move_input(ListOfMoves,Row,Col) :-
    write('Where do you want do put your new piece? '), % '4d' '4D'
    read(MoveInput),
    parse_move_input(ListOfMoves,MoveInput,Row,Col).

%% parse_move_input(+ListOfMoves,+MoveInput,-Row,-Col)
parse_move_input(ListOfMoves,[RowString|ColString],Row,Col) :-
    number_string(Row,RowString),
    letter_to_num(Col,ColString).

%% EXISTENTE number_string(?Number,?String).

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
    validate_move_board_range(Row,Col),
    !,
    memberchk([Row,Col],ListOfMoves).

%% validate_move_board_range(+Row,+Col)
validate_move_board_range(Row,Col) :-
    board_size(BoardSize),
    Row <= BoardSize,
    !,
    Col <= BoardSize.



%% change_player(+OldPlayerTurn,-NewPlayerTurn)
change_player(white,black).
change_player(black,white).