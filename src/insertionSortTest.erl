%%%-------------------------------------------------------------------
%%% @author louisa
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 18. Nov 2014 15:16
%%%-------------------------------------------------------------------
-module(insertionSortTest).
-author("louisa").

-include_lib("eunit/include/eunit.hrl").

insertionS_test() ->
  A1 = arrayS:initA(),
  A2 = arrayS:setA(A1,0,3),
  A3 = arrayS:setA(A2,1,98),
  A4 = arrayS:setA(A3,2,41),
  A5 = arrayS:setA(A4,3,4),
  A6 = arrayS:setA(A5,4,8),
  A7 = arrayS:setA(A6,5,5),
  ?assertEqual({3,{4,{5,{8,{41,{98,{}}}}}}}, insertionSort:insertionS(A7,0,5)),
  ?assertEqual({3,{4,{41,{98,{8,{5,{}}}}}}}, insertionSort:insertionS(A7,1,3)).
%%   ?assertError({}, insertionSort:insertionS(A7,0,6)).

unsortedFront_test() ->
  A1 = arrayS:initA(),
  A2 = arrayS:setA(A1,0,3),
  A3 = arrayS:setA(A2,1,98),
  A4 = arrayS:setA(A3,2,41),
  A5 = arrayS:setA(A4,3,4),
  A6 = arrayS:setA(A5,4,8),
  A7 = arrayS:setA(A6,5,5),
  ?assertEqual({3,{98,{41,{}}}}, insertionSort:unsortedFront(A7, 3)),
  ?assertEqual({}, insertionSort:unsortedFront(A7, 0)),
  ?assertEqual({3,{98,{41,{4,{8,{5,{}}}}}}}, insertionSort:unsortedFront(A7, 6)).

concatTwoArray_test() ->
  A1 = arrayS:initA(),
  A2 = arrayS:setA(A1,0,3),
  A3 = arrayS:setA(A2,1,98),
  A4 = arrayS:setA(A3,2,41),
  A5 = arrayS:setA(A4,3,4),
  A6 = arrayS:setA(A5,4,8),
  A7 = arrayS:setA(A6,5,5),
  ?assertEqual({3,{98,{41,{4,{8,{5,{11,{22,{33,{}}}}}}}}}}, insertionSort:concatTwoArray(A7, {11,{22,{33,{}}}})).

sortedPart_test() ->
  A1 = arrayS:initA(),
  A2 = arrayS:setA(A1,0,3),
  A3 = arrayS:setA(A2,1,98),
  A4 = arrayS:setA(A3,2,41),
  A5 = arrayS:setA(A4,3,4),
  A6 = arrayS:setA(A5,4,8),
  A7 = arrayS:setA(A6,5,5),
  ?assertEqual({41,{4,{8,{}}}}, insertionSort:sortedPart(A7, 2, 4)).

unsortedEnd_test() ->
  A1 = arrayS:initA(),
  A2 = arrayS:setA(A1,0,3),
  A3 = arrayS:setA(A2,1,98),
  A4 = arrayS:setA(A3,2,41),
  A5 = arrayS:setA(A4,3,4),
  A6 = arrayS:setA(A5,4,8),
  A7 = arrayS:setA(A6,5,5),
  ?assertEqual({8,{5,{}}}, insertionSort:unsortedEnd(A7, 4)).


