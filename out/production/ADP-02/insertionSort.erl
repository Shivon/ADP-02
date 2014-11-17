%%%-------------------------------------------------------------------
%%% @author Marjan und Louisa
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 16. Nov 2014 18:48
%%%-------------------------------------------------------------------
-module(insertionSort).

%% API
-export([insertionS/3]).



%% Wahrheitstafel:
%% __A___B____A_v_B__
%% | 0   0 |    0   |
%% | 0   1 |    1   |
%% | 1   0 |    1   |
%% |_1___1_|____1___|
%%




insertionS(Array, Von, Bis) ->
  ReturnList = arrayS:initA(),
  insertionS(Array, ReturnList, Von, Bis, false ).

%insertionS({First,Second, Rest}, ReturnList, Von, Bis, 1) when First < Second and Rest == {} ->

%    insertionS(ReturnList, {}, Von, Bis, 1);




%% Algorithmus ist mit dem gesamten tauschen fertig,
%% im letzten Durchgang wurde nicht mehr getauscht.
insertionS({}, ReturnList, _Von, _Bis, false) ->
  ReturnList;



%% Algorithmus ist noch nicht fertig mit tauschen,
%% beim Durchgehen der Liste im letzten Durchgang wurde immernoch getauscht.
insertionS({}, ReturnList, _Von, _Bis, true) ->
  ReturnListNew = arrayS:initA(),
  insertionS(ReturnList, ReturnListNew, _Von, _Bis, false);



%% Das sich erste anschauende Elemente ist kleiner als das Zweite.
%% Es muss nicht getauscht werden.
insertionS({First, Second, Rest}, ReturnList, _Von, _Bis, Switched) when First < Second ->
  PosForFirst = arrayS:lengthA(ReturnList),
  NewArray1 = arrayS:setA(ReturnList, PosForFirst, First),
  NewSwitched = (Switched and false),
  insertionS({Second, Rest}, NewArray1, _Von, _Bis, NewSwitched);



%% Das sich erste anschauende Elemente ist großer als das Zweite.
%% Es muss getauscht werden.
insertionS({First, Second, Rest}, ReturnList, _Von, _Bis, Switched) when First > Second ->
  PosForSecond = arrayS:lengthA(ReturnList),
  NewArray1 = arrayS:setA(ReturnList, PosForSecond, Second),
  NewSwitched = (Switched and true),
  insertionS({First, Rest}, NewArray1, _Von, _Bis, NewSwitched).






