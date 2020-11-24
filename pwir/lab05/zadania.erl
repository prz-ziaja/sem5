-module(zadania).
-compile([export_all]).


insertTree(Value, null) -> {Value, null, null};
insertTree(Value, {Data, Left, Right}) when Value < Data -> {Data, insertTree(Value, Left), Right};
insertTree(Value, {Data, Left, Right}) when Value > Data -> {Data, Left, insertTree(Value, Right)};
insertTree(_, {Data, Left, Right}) -> {Data, Left, Right}.


insertRandom(Tree) -> insertTree(rand:uniform(99),Tree).

insertXRandom(Tree, 0) -> Tree;
insertXRandom(Tree, N) -> insertXRandom(insertRandom(Tree), N-1).


listToTree([],Tree) -> Tree;
listToTree([H|T], Tree) -> listToTree(T, insertTree(H,Tree)).


preOrder(null) -> [];
preOrder({Data,Left,Right}) -> [Data] ++ preOrder(Left) ++ preOrder(Right).

inOrder(null) -> [];
inOrder({Data,Left,Right}) ->  inOrder(Left) ++ [Data] ++ inOrder(Right).

postOrder(null) -> [];
postOrder({Data,Left,Right}) -> postOrder(Left) ++ postOrder(Right) ++ [Data].


searchX(_, null) -> false;
searchX(X, {X, _, _}) -> true;
searchX(X, {OtherX, Left, _}) when X < OtherX -> searchX(X, Left);
searchX(X, {OtherX, _, Right}) when X > OtherX -> searchX(X, Right).

ifTreeContains(_, null) -> throw(false);
ifTreeContains(X, {X, _, _}) -> throw(true);
ifTreeContains(X, {OtherX, Left, _}) when X < OtherX -> ifTreeContains(X, Left);
ifTreeContains(X, {OtherX, _, Right}) when X > OtherX -> ifTreeContains(X, Right).

searchXTry(X, Tree) ->
	try 
		ifTreeContains(X, Tree)
	catch
		throw:true -> 'true';
		throw:false -> 'false'
	end.

removeX(X, null, _) -> throw(false);
removeX(X, {X,Left,Right}, Others) -> listToTree((preOrder({null,Left,Right}) ++ Others), null);
removeX(X, {OtherX,Left,Right}, Others) when X < OtherX -> removeX(X, Left, Others ++ preOrder(Right));
removeX(X, {OtherX,Left,Right}, Others) when X > OtherX -> removeX(X, Right, Others ++ preOrder(Left)).

treeSize(null) -> 0;
treeSize({_, null, null}) -> 1;
treeSize({Data, Left, Right}) -> 1 + treeSize(Left) + treeSize(Right).
			     
