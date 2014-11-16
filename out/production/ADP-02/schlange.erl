%%%-------------------------------------------------------------------
%%% @author Louisa & Marjan
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 31. Okt 2014 08:53
%%%-------------------------------------------------------------------
-module(schlange).
-author("Louisa").

%% API
-export([createQ/0, front/1, enqueue/2, dequeue/1, isEmptyQ/1]).


%% createQ: leere Menge -> queue
%% Initialisiert & erzeugt eine Queue und liefert diese zurück
createQ() ->
  {stack:createS(), stack:createS()}.


%% front: queue -> elem(Selektor)
%% Gibt das vorderste Element der übergebenen Queue zurück (falls vorhanden)
front({In,Out}) ->
  X = stack:isEmptyS(Out),
  if
    %% wenn Outstack leer, stapel um
    X -> restackTop({In, Out});
    %% wenn Outstack nicht leer, gib oberstes Element zurück
    true -> stack:top(Out)
  end.

%% Hilfsfunktion
restackTop({In, Out}) ->
  X = stack:isEmptyS(In),
  if
    %% wenn Instack leer, gib oberstes Element vom Outstack
    X -> stack:top(Out);
    %% wenn Instack nicht leer, nimm oberstes Element Instack und tue auf Outstack
    %% lösche oberstes Element Instack, gib modifizierte Stacks weiter
    true ->
      Top = stack:top(In),
      Out1 = stack:push(Out, Top),
      In1 = stack:pop(In),
      restackTop({In1, Out1})
  end.


%% enqueue: queue × elem → queue
%% Fügt der übergebenen Queue das übergebene Element ganz hinten
%% hinzu und gibt die modifizierte Queue zurück
enqueue({StackIn, StackOut}, Elem) ->
  X = stack:isEmptyS(StackOut),
  if
    X -> StackInNew = stack:push(StackIn, Elem), {StackInNew, StackOut};
    true -> restackEnqueue({StackOut, StackIn}, Elem)
  end.

%% Hilfsfunktion
restackEnqueue({StackOut, StackIn}, Elem) ->
  X = stack:isEmptyS(StackIn),
if
    X ->
      Top = stack:top(StackOut),                    %% dann nehme das oberste Element
      StackIn1 = stack:push(StackIn, Top),          %% und tu es in den Instack
      StackOut1 = stack:pop(StackOut),              %% lösche das oberste Element aus dem Outstack
      restackEnqueue({StackOut1, StackIn1}, Elem);  %% gebe den modifizierten in- und outstack weiter
    true -> StackInNew = stack:push(StackIn, Elem), {StackInNew, StackOut}
  end.


%% dequeue: queue → queue (Mutator)
%% Entfernt das vorderste Element der übergebenen Queue (falls
%% vorhanden) und gibt die modifizierte Queue zurück
dequeue({StackIn, StackOut}) ->
  X = stack:isEmptyS(StackOut),
  if
    %% wenn Outstack leer ist, dann stapel um
    X -> QueueNew = restackPop({StackIn, StackOut}), QueueNew;
    %% ist Outstack nicht leer, wird oberstes Element gelöscht
    true -> StackOutNew2 = stack:pop(StackOut), {StackIn, StackOutNew2}
  end.

%% Hilfsfunktion
restackPop({StackIn, StackOut}) ->
  X = stack:isEmptyS(StackIn),
  if
    %% wenn Instack leer ist, dann lösche oberstes Element vom Outstack
    X -> StackOutNew = stack:pop(StackOut), {StackIn, StackOutNew};
    true ->                                  %% wenn Instack Elemente hat
      Top = stack:top(StackIn),              %% dann nehme das oberste Element
      StackOut1 = stack:push(StackOut, Top), %% und tu es in den Outstack
      StackIn1 = stack:pop(StackIn),         %% lösche das oberste Element aus dem Instack
      restackPop({StackIn1, StackOut1})      %% gebe den modifizierten In- und Outstack weiter
  end.


%% isEmptyQ: queue → bool
%% Gibt true zurück, wenn die übergebene Queue leer ist, sonst false
isEmptyQ({StackIn, StackOut}) -> stack:isEmptyS(StackIn), stack:isEmptyS(StackOut).