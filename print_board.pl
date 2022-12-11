print_n(S,0) :- !.
print_n(S,N) :-
        write(S),
        D is N-1,
        print_n(S, D).

print_header(C):-
        write('+'),
        print_n(' - +',C), nl,!.

print_line(C):-
        write('|'),
        print_n('   |',C), nl,
        write('+'),
        print_n(' - +',C), nl,!.

print_cols(0,C) :- !.
print_cols(L,C) :-
        print_line(C),
        D is L-1,
        print_cols(D,C).

print_board(L,C) :-
        nl,
        print_header(C),
        print_cols(L,C),!.