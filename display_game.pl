build_row_board(Size,Size,List, Row):- Row = List,!.
build_row_board(I,Size,List, Row):-
    append(List,[0],NewList),
    I1 is I+1,
    build_row_board(I1,Size,NewList, Row).

build_board(Size,Size,List, Board):- Board = List,!.
build_board(I,Size,List, Board):-
    build_row_board(0,Size,[],Row),
    append(List,[Row],NewList),
    I1 is I+1,
    build_board(I1,Size,NewList, Board).

% initial_state(+Size, -GameState) 
initial_state(Size, GameState):-
    build_board(0,Size,[], GameState).


print_n(S,0) :- !.
print_n(S,N) :-
        write(S),
        D is N-1,
        print_n(S, D).

% check if board is not rectangular
% check_size(+Board, -Rows)
check_size(Board, Rows):-
  nth0(0, Board, Line),
  length(Line, Columns),
  length(Board, Rows),
  Columns == Rows. 

code(0, 32).   % ascii code for space
code(-1, 216). % Ø - Player 2
code(1, 215).  % × - Player 1
% Pieces codes for each player
player_piece(1, 1).
player_piece(-1, -1).

print_header_legend(N, N):-nl.
print_header_legend(N, F):-
        write(' '), write(N), write(' |'), N1 is N + 1, print_header_legend(N1, F).

print_line_separator(C):- print_n(' - +',C), nl,!.

print_line([]):-!.
print_line([C|L]) :-
write(' '),code(C, P),put_code(P), write(' |'),
print_line(L).

% print_matrix(+GameState,+Iterator,+Lines)
print_matrix(_,N,N) :- !.
print_matrix([L|T],I,N) :-
        write(' '),
        write(I),
        write(' |'),
        print_line(L),nl,
        print_line_separator(N+1),
        D is I+1,
        print_matrix(T,D,N).

% predicate that displays current game state 
% display_game(+GameState)
display_game(GameState) :-
        nl,
        check_size(GameState, N),
        write('   |'),
        print_header_legend(0, N),
        print_line_separator(N+1),
        print_matrix(GameState,0,N),!.


