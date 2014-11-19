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
-export([insertionS/3, unsortedFront/3, sortedPart/5, unsortedEnd/3, concatTwoArray/2]).



%% Wahrheitstafel:
%% __A___B____A_v_B__
%% | 0   0 |    0   |
%% | 0   1 |    1   |
%% | 1   0 |    1   |
%% |_1___1_|____1___|
%%


insertionS(Array, Von, Bis) ->
      List = arrayS:initA(),
      ArrayNotToSort1 = unsortedFront(Array, List, Von), %% gibt den ersten Teil zurück, der nicht mit sortiert werden soll
      ArrayToSort = sortedPart(Array, List, 0, Von, Bis),    %% gibt den zu sortierenden Teil zurück.
      ArrayNotToSort2 = unsortedEnd(Array, List, Bis+1),

      %% Zeit vor dem Algorithmus
      {_, Seconds, MicroSecs} = now(),

      %% Algorithmus ausführen
      NewSortedArray = insertionS(ArrayToSort, List, 0, false),
      %% Zeit nach dem Algorithmus
      {_, Seconds1, MicroSecs1} = now(),
      erlang:display((Seconds1-Seconds)+(MicroSecs1-MicroSecs)/1000000),

      %% Konkatinieren zur Rückgabeliste
      ArrayConcat = concatTwoArray(ArrayNotToSort1, NewSortedArray),
      concatTwoArray(ArrayConcat, ArrayNotToSort2).





%% Algorithmus ist mit dem gesamten tauschen fertig,
%% im letzten Durchgang wurde nicht mehr getauscht.
insertionS({First,{}}, ReturnList, Swapcount, false) ->
  Pos = arrayS:lengthA(ReturnList),
  ReturnList2 = arrayS:setA(ReturnList, Pos, First),
  erlang:display(Swapcount), ReturnList2;


%% Algorithmus ist noch nicht fertig mit tauschen,
%% beim Durchgehen der Liste im letzten Durchgang wurde immernoch getauscht.
insertionS({First,{}}, ReturnList, _Swapcount, true) ->
  ReturnListNew = arrayS:initA(),
  Pos = arrayS:lengthA(ReturnList),
  ReturnList2 = arrayS:setA(ReturnList, Pos, First),
  insertionS(ReturnList2, ReturnListNew, _Swapcount, false);


%% Das sich erste anschauende Elemente ist kleiner als das Zweite.
%% Es muss nicht getauscht werden.
insertionS({First, {Second, Rest}}, ReturnList, _Swapcount, Switched) when First < Second ->
  PosForFirst = arrayS:lengthA(ReturnList),
  NewArray1 = arrayS:setA(ReturnList, PosForFirst, First),
  NewSwitched = (Switched or false),
  insertionS({Second, Rest}, NewArray1, _Swapcount, NewSwitched);


%% Das sich erste anschauende Elemente ist großer als das Zweite.
%% Es muss getauscht werden.
insertionS({First, {Second, Rest}}, ReturnList, Swapcount, Switched) when First > Second ->
  PosForSecond = arrayS:lengthA(ReturnList),
  NewArray1 = arrayS:setA(ReturnList, PosForSecond, Second),
  NewSwitched = (Switched or true),
  insertionS({First, Rest}, NewArray1, Swapcount+1, NewSwitched).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   HILFSFUNKTIONEN  %%
%%     - unsortedFront/3
%%     - sortedPart/5
%%     - unsortedEnd/3
%%     - concatTwoArray/2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Array x NewArray x PosAt x BisIndex -> NewArray
%% Gibt den nicht zu sortierenden Teil aus der vor dem zu sortierenden Teil steht
unsortedFront(Array, NewArray,  BisIndex) ->
  unsortedFront(Array, NewArray, 0,  BisIndex).

unsortedFront(_Array, NewArray, _PosAt,  BisIndex) when BisIndex == 0 ->
  NewArray;

unsortedFront(Array, NewArray, PosAt,  BisIndex) ->
  Elem = arrayS:getA(Array, PosAt),
  Pos = arrayS:lengthA(NewArray),
  NewArray1 = arrayS:setA(NewArray, Pos, Elem),
  NewPosAt = PosAt + 1,
  NewBisIndex = BisIndex - 1,
  unsortedFront(Array, NewArray1, NewPosAt, NewBisIndex).




%% Array x NewArray x PosAt x VonIndex x BisIndex -> NewArray
%% Gibt den zu sortierenden Teil aus
 sortedPart(_Array, NewArray, PosAt, _VonIndex, BisIndex) when PosAt > BisIndex ->
  NewArray;

%% Die Liste wird durchgegangen ohne etwas zu machen,
%% bis der Index gleich dem übergebenen Index VonIndex ist
 sortedPart(Array, NewArray, PosAt, VonIndex, BisIndex) when PosAt < VonIndex ->
   NewPosAt = PosAt + 1,
   sortedPart(Array, NewArray, NewPosAt, VonIndex, BisIndex);

 sortedPart(Array, NewArray, PosAt, VonIndex, BisIndex) when PosAt >= VonIndex ->
   Elem = arrayS:getA(Array, PosAt),
   Pos = arrayS:lengthA(NewArray),
   NewArray1 = arrayS:setA(NewArray, Pos, Elem),
   NewPosAt = PosAt + 1,
   sortedPart(Array, NewArray1, NewPosAt, VonIndex, BisIndex).



%% unsortedEnd: Array x Array x Startindex -> Array
%% Gibt den Endteil des Arrays aus was nicht sortiert werden soll
unsortedEnd(Array, NewArray, VonIndex) ->
   unsortedEnd(Array, NewArray, 0, VonIndex).

unsortedEnd(Array, NewArray, PosAt, VonIndex) when PosAt < VonIndex ->
    NewPosAt = PosAt + 1,
    unsortedEnd(Array, NewArray, NewPosAt, VonIndex);

unsortedEnd(Array, NewArray, PosAt, VonIndex)  ->
  Length = arrayS:lengthA(Array),
  if
    (PosAt < Length) ->
       Elem = arrayS:getA(Array, PosAt),
       Pos = arrayS:lengthA(NewArray),
       NewArray1 = arrayS:setA(NewArray, Pos, Elem),
       NewPosAt = PosAt + 1,
       unsortedEnd(Array, NewArray1, NewPosAt, VonIndex);
    true ->
       NewArray
  end.





%% concatTwoArray: Array x Array -> Array
%% Konkatiniert zwei Arrays
 concatTwoArray(Array1, Array2) ->
    concatTwoArray(Array1, Array2, 0).

 concatTwoArray(Array1, Array2, PosAccu) ->
    Pos1 = arrayS:lengthA(Array2),
    if
      (Pos1 > PosAccu) ->
          Pos2 = arrayS:lengthA(Array1),
          Elem = arrayS:getA(Array2, PosAccu),
          NewArray = arrayS:setA(Array1, Pos2, Elem ),
          concatTwoArray(NewArray, Array2, PosAccu+1);
      (Pos1 =< PosAccu) ->
          Array1
    end.



