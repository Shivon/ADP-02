%%%-------------------------------------------------------------------
%%% @author KamikazeOnRoad
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 16. Nov 2014 18:48
%%%-------------------------------------------------------------------
-module(sortNum).
-author("KamikazeOnRoad").
-import(arrayS, [initA/0, setA/3, lengthA/1]).
-import(liste, [reverse/1]).

%% API
-export([sortNum/1]).
%%  random:uniform(N). generiert random int zwischen 1 und N

sortNum(Quantity) ->
  generateRandom(Quantity),
  generateWorst(Quantity),
  generateBest(Quantity).


generateRandom(Quantity) ->
  Output = initA(),
  Length = lengthA(Output),
  if
    (Length == Quantity-1) -> setA(Output, Quantity-1, random:uniform(1000));
    (Length < Quantity) -> setA(generateRandom(Quantity-1), Quantity-1, random:uniform(1000))
  end.

generateWorst(Quantity) ->
  generateWorst(Quantity, random:uniform(1000)).

generateWorst(Quantity, Previous) ->
  Output = initA(),
  Length = lengthA(Output),
  Random = Previous + random:uniform(1000),
  if
    (Length == Quantity-1) -> setA(Output, Quantity-1, Random);
    (Length < Quantity) -> setA(generateWorst(Quantity-1, Random), Quantity-1, Random)
  end.

generateBest(Quantity) ->
  reverse(generateWorst(Quantity)).

