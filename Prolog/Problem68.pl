use_module(library(clpfd)).

puzzle(Board) :-
    [B1,B2,B3,B4,B5,B6,B7,B8,B9,B10] = Board,
    Board ins 1..10,
    all_different(Board),
    B1 = 10,
    Sum #= B1 + B2 + B3,
    Sum #= B4 + B3 + B5,
    Sum #= B6 + B5 + B7,
    Sum #= B8 + B7 + B9,
    Sum #= B10 + B9 + B2.
