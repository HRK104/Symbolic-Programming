%Q1
numeral(0).
numeral(succ(X)) :- numeral(X).

pterm(null).
pterm(f0(X)) :- pterm(X).
pterm(f1(X)) :- pterm(X).



incr(f0(X),f1(X)):-pterm(f0(X)).
incr(f1(null), f0(f1(null))).
incr(f1(X),f0(A)):- incr(X,A).




%Q2
legal(f0(null)).
legal(Z) :- legal(X), incr(X, Z).


incrR(X, Y) :- legal(X), incr(X, Y).

%Q3
add(f0(null), Y, Y).
add(X, Y, Z) :- incr(A, X), add(A, Y, B), incr(B, Z).

%Q4
mult(f0(null), _, f0(null)).
mult(_, f0(null), f0(null)).
mult(Y, f1(null), Y).
mult(f1(null), X, X).
mult(X, Y, Z) :- incr(A, X), mult(A, Y, B), add(Y, B, Z).

%Q5
revers2(null, A, A).
revers2(f0(A), X, B) :- revers2(A, f0(X), B).
revers2(f1(A), X, B) :- revers2(A, f1(X), B).
revers(A, B) :- revers2(A, null, B).

%Q6
part(f1(X), f1(X)).
part(f0(X), A) :- part(X, A).

normalize(null, f0(null)).
normalize(f0(null), f0(null)).
normalize(X, Y) :- revers(X, Z), part(Z, A), revers(A, Y).

% test add inputting numbers N1 and N2
testAdd(N1,N2,T1,T2,Sum,SumT) :- numb2pterm(N1,T1), numb2pterm(N2,T2),
add(T1,T2,SumT), pterm2numb(SumT,Sum).
% test mult inputting numbers N1 and N2
testMult(N1,N2,T1,T2,N1N2,T1T2) :- numb2pterm(N1,T1), numb2pterm(N2,T2),
mult(T1,T2,T1T2), pterm2numb(T1T2,N1N2).
% test revers inputting list L
testRev(L,Lr,T,Tr) :- ptermlist(T,L), revers(T,Tr), ptermlist(Tr,Lr).
% test normalize inputting list L
testNorm(L,T,Tn,Ln) :- ptermlist(T,L), normalize(T,Tn), ptermlist(Tn,Ln).
% make a pterm T from a number N numb2term(+N,?T)
numb2pterm(0,f0(null)).
numb2pterm(N,T) :- N>0, M is N-1, numb2pterm(M,Temp), incr(Temp,T).
% make a number N from a pterm T pterm2numb(+T,?N)
pterm2numb(null,0).
pterm2numb(f0(X),N) :- pterm2numb(X,M), N is 2*M.
pterm2numb(f1(X),N) :- pterm2numb(X,M), N is 2*M +1.
% reversible ptermlist(T,L)
ptermlist(null,[]).
ptermlist(f0(X),[0|L]) :- ptermlist(X,L).
ptermlist(f1(X),[1|L]) :- ptermlist(X,L).