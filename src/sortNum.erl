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

%% API
-export([sortNum/1]).


sortNum(Quantity) -> %%TODO: Print Output all functions into zahlen.dat
  generateRandom(Quantity),
  generateWorst(Quantity),
  generateBest(Quantity).
%%  file:write_file("\zahlen.dat", io_lib:fwrite("~p.\n", [generateBest(Quantity)])).


generateRandom(Quantity) ->
  Output = initA(),
  Length = lengthA(Output),
  if
    %%  random:uniform(N) -> generates random int between 1 and N
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

%% generateBest(Quantity, 10).
%%
%% generateBest(Quantity, Loop) ->
%%   if
%%     (Loop == 0) -> reverse(generateWorst(Quantity));
%%     (Loop > 0) -> reverse(generateWorst(Quantity, Loop-1))
%%   end.


%% Hilfsfunktion
reverse(List) -> reverse(List, {}).

reverse({}, NewList) -> NewList;
reverse({First, Rest}, NewList) -> reverse(Rest, {First,NewList}).