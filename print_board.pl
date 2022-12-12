print_n(S,0) :- !.
print_n(S,N) :-
        write(S),
        D is N-1,
        print_n(S, D).

print_header_legend(N, N):-
        write('\n').
print_header_legend(N, F):-
        write(' '), write(N), write(' |'), N1 is N + 1, print_header_legend(N1, F).

print_top_edge(C):- print_n(' - +',C), nl,!.

print_line(C,N):-
        write(' '),
        write(N),
        write(' |'),
        print_n('   |',C-1), nl,
        print_n(' - +',C), nl,!.

print_matrix(N,N) :- !.
print_matrix(I,N) :-
        print_line(N+1,I),
        D is I+1,
        print_matrix(D,N).

print_board(N) :-
        nl,
        write('   |'),
        print_header_legend(0, N),
        print_top_edge(N+1),
        print_matrix(0,N),!.
