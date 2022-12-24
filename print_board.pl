:- use_module(library(lists)).
initial_state( [
  [ 0, 0, 0, 0, 0, 0],
  [ 0, 0, 0, 0, 0, 0],
  [ 0, 0, 0, 0, 0, 0],
  [ 0, 0, 0, 0, 0, 0],
  [ 0, 0, 0, 0, 0, 0],
  [ 0, 0, 0, 0, 0, 0]
]).

print_n(S,0) :- !.
print_n(S,N) :-
        write(S),
        D is N-1,
        print_n(S, D).

% check if board is not rectangular
check_size(Board, X):-
  nth0(0, Board, Line),
  length(Line, X),
  length(Board, Y),
  X == Y. 

code(0, 32).   % ascii code for space
code(-1, 216). % Ø - Player 2
code(1, 215).  % × - Player 1
% Pieces codes for each player
player_piece('Player 1', 1).
player_piece('Player 2', -1).

print_header_legend(N, N):-nl.
print_header_legend(N, F):-
        write(' '), write(N), write(' |'), N1 is N + 1, print_header_legend(N1, F).

print_line_separator(C):- print_n(' - +',C), nl,!.

print_line([]):-!.
print_line([C|L]) :-
write(' '),code(C, P),put_code(P), write(' |'),
print_line(L).

print_matrix(_,N,N) :- !.
print_matrix([L|T],I,N) :-
        write(' '),
        write(I),
        write(' |'),
        print_line(L),nl,
        print_line_separator(N+1),
        D is I+1,
        print_matrix(T,D,N).

print_board(Board) :-
        nl,
        check_size(Board, N),
        write('   |'),
        print_header_legend(0, N),
        print_line_separator(N+1),
        print_matrix(Board,0,N),!.


% append(P,[[I,Y]],ListOfMoves),


row_ListOfMoves(N,N,_,_,_,ListOfMoves) :- !.
row_ListOfMoves(I,N,Y,L,P,ListOfMoves) :-
I >= 0,
append(P,[[I,Y]],ListOfMoves),
write(ListOfMoves),nl,
D is I+1,
row_ListOfMoves(D,N,Y,L,ListOfMoves,NewListOfMoves).

