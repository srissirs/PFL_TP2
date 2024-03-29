% predicate that compares if the points are higher for the player if he/she makes a certain move
% compare_move(+Move, +GameState, +Player, +BestPoints, +BestMove, -NewBestPoints, -NewBestMove)
compare_move(Move, GameState, Player, BestPoints, BestMove, NewBestPoints, NewBestMove):- 
    move(GameState, Move, Player, NewGameState),
    value(NewGameState, Player, Points),!,
    Points >= BestPoints -> NewBestPoints = Points, NewBestMove = Move; 
    NewBestPoints = BestPoints, NewBestMove = BestMove.

% predicate that chooses the best move within an availabe ListOfMoves
% move_level2(ListOfMoves,+GameState,+Player,+BestPoints, +BestMove, -FinalMove)
move_level2([],_,_,BestPoints, BestMove, FinalMove, FinalPoints):- FinalMove = BestMove, FinalPoints = BestPoints.
move_level2([H|T],GameState,Player,BestPoints, BestMove,FinalMove, FinalPoints):- 
    compare_move(H, GameState, Player, BestPoints, BestMove, NewBestPoints, NewBestMove),
    move_level2(T,GameState,Player,NewBestPoints, NewBestMove,FinalMove,FinalPoints).

% predicate that determines the next move for level 2 player; if there isn't any Move that increases the points chooses randomly one from List of Moves; if there is one thats improves the score that Move is chosen
% choose_best_move(+FinalMove, +FinalPoints, +CurrentPoints, +ListOfMoves, -Move )
choose_best_move(FinalMove, FinalPoints, CurrentPoints, ListOfMoves, Move ):-
    FinalPoints =< CurrentPoints ->  random_member(Move, ListOfMoves); Move = FinalMove.

% choose_move(+GameState,+LastMove, +Level, -Move).
% choose the next best move (random)
choose_move(GameState,LastMove, _, 1, Move):-
    valid_moves(GameState,LastMove,ListOfMoves),
    random_member(Move, ListOfMoves),
    sleep(3).

% choose the next best move (greedy)
choose_move(GameState,LastMove, Player, 2 , Move):-
    valid_moves(GameState,LastMove,ListOfMoves),
    value(GameState, Player, CurrentPoints),
    move_level2(ListOfMoves,GameState,Player,CurrentPoints, [], FinalMove, FinalPoints),
    choose_best_move(FinalMove, FinalPoints, CurrentPoints, ListOfMoves, Move ).

