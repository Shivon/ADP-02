%%%-------------------------------------------------------------------
%%% @author KamikazeOnRoad
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 16. Nov 2014 18:49
%%%-------------------------------------------------------------------
-module(selectionSort).
-author("KamikazeOnRoad").

%% API

-export([]).

-export([selectionS/3]).
-import(arrayS, [initA/0, setA/3, getA/2]).

%% Von = Index from which you want to start sorting
%% Bis = Index which shall be the last sorted
selectionS(Array, Von, Bis) ->
  selectionS(Array, Von, Bis, initA()).
  %%TODO: falls nicht ganzer Array sortiert werden soll, muss Rest drumherum gepackt werden

selectionS(Array, Von, Bis, SortedArray) ->
  SortLength = Bis - Von + 1,
  Beginning = Von,
  Minimum = Beginning,
  if

  end

%% prozedur SelectionSort( A : Liste sortierbarer Elemente )
%% n = Länge( A )
%% links = 0
%% wiederhole
%% min = links
%% für jedes i von links + 1 bis n wiederhole
%% falls A[ i ] < A[ min ] dann
%% min = i
%% ende falls
%% ende für
%% Vertausche A[ min ] und A[ links ]
%% links = links + 1
%% solange links < n
%% prozedur ende
