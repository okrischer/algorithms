% solve the 4-queens problem.
solution(C1,C2,C3,C4) :-
  uniq(C1,C2,C3,C4),
  \+ cap(2,C2,1,C1),
  \+ cap(3,C3,1,C1), \+ cap(3,C3,2,C2),
  \+ cap(4,C4,1,C1), \+ cap(4,C4,2,C2), \+ cap(4,C4,3,C3).

% columns
col(1). col(2). col(3). col(4).

% unique constraint
uniq(C1,C2,C3,C4) :- col(C1), col(C2), col(C3), col(C4),
    C1 \= C2, C1 \= C3, C1 \= C4, C2 \= C3, C2 \= C4, C3 \= C4.

% safety constraints
cap(R1,C1,R2,C2) :- R1-C1 =:= R2-C2.    % capture on left diagonal    
cap(R1,C1,R2,C2) :- R1+C1 =:= R2+C2.    % capture on right diagonal
