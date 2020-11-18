-module(zadania).
-compile([export_all]).
-vsn(1.0).
 
len([]) -> 0;
len([_|T]) -> 1 + len(T). 


amin([H|T]) -> amin(T,H).
amin([H|T], M) when H<M -> amin(T, H);
amin([H|T], M) when H>=M -> amin(T, M);
amin([],M) -> M.

amax([H|T]) -> amax(T,H).
amax([H|T], M) when H>M -> amax(T, H);
amax([H|T], M) when H=<M -> amax(T, M);
amax([],M) -> M.

tmin_max(A) -> {amin(A),amax(A)}.
lmin_max(A) -> [amin(A),amax(A)].

pole({prostokat,X,Y})-> X*Y;
pole({kolo,R}) -> 3.14*R*R;
pole({trapez, A,B,H}) -> (A+B)*H/2;
pole({szescian, A}) -> A*A*6;
pole({kula, R}) -> 4*3.14*R*R.

lista_pol([]) -> [];
lista_pol([H|T]) -> [pole(H)] ++ pole(T).

my_list(1) -> [1];
my_list(N) -> [N|my_list(N-1)].

ones(0) -> [];
ones(N) -> [1] ++ ones(N-1).

dev(List) -> dev(List, List, []).
dev([], T, H) -> {lists:reverse(H), T};
dev([_], T, H) -> {lists:reverse(H), T};
dev([_,_ | D], [H | T], Result) -> dev(D, T, [H | Result]).

merge_sort([]) -> [];
merge_sort([H]) -> [H];
merge_sort(List) -> {H, T} = dev(List), merge(merge_sort(H), merge_sort(T)).
 
merge([], X) -> X;
merge(X, []) -> X;
merge([L | H], [R | T]) when L < R -> [L | merge(H, [R | T])];
merge([L | H], [R | T]) -> [R | merge([L | H], T)].

bubble_sort(L) -> bubble_sort(L, [], false).

bubble_sort([A, B | T], Acc, _) when A > B ->
  bubble_sort([A | T], [B | Acc], true);
bubble_sort([A, B | T], Acc, Tainted) ->
  bubble_sort([B | T], [A | Acc], Tainted);
bubble_sort([A | T], Acc, Tainted) ->
  bubble_sort(T, [A | Acc], Tainted);
bubble_sort([], Acc, true) ->
  bubble_sort(lists:reverse(Acc));
bubble_sort([], Acc, false) ->
  lists:reverse(Acc).
