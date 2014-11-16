%%%-------------------------------------------------------------------
%%% @author Louisa
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. Okt 2014 09:31
%%%-------------------------------------------------------------------
-module(stack).
-author("Louisa").

%% API
-export([createS/0, push/2, pop/1, top/1, isEmptyS/1]).
-import(liste, [create/0, insert/3, delete/2, retrieve/2, isEmpty/1]).


%% createS: leere Menge -> stack
%% Initialiesiert einen Stack (Erzeugung) und liefert diesen zurück
createS() ->
  create().


%% push: stack x elem -> stack
%% Fügt dem übergebenen Stack das übergebene Element hinzu und gibt den modifizierten Stack zurück
push(Stack, Elem) ->
  %% Position 1 Liste entspricht oben beim Stack
  insert(Stack, 1, Elem).


%% pop: stack -> stack
%% Enfernt vom übergebenen Stack das oberste Element (falls vorhanden)und gibt den modifizierten Stack zurück
pop(Stack) ->
  delete(Stack, 1).


%% top: stack -> elem
%% Gibt das oberste Element (falls vorhanden) des übergebenen Stacks zurück
top(Stack) ->
  retrieve(Stack, 1).


%% isEmptyS: stack -> bool
%% Prüft, ob der übergebene Stack leer ist, ja -> true/ nein -> false
isEmptyS(Stack) ->
  isEmpty(Stack).