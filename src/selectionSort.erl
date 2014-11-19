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
-export([selectionS/0, selectionS/3]).
-import(arrayS, [initA/0, setA/3, getA/2, lengthA/1]).
-import(sortNum, [sortNum/0, sortNum/1]).


%% selectionS() ->
%%   FileName = "\zahlen.dat",
%%   file:write_file(FileName, io_lib:format("~p",[selectionS()])).

selectionS() ->
  StartTime = time(), %% save start time for comparison ACHTUNG: keine Millisek + kein Rechnen möglich
  FileName = "\zahlen.dat",
  {ok, Device} = file:open(FileName, [read]),
  selectionS(Device),
  EndTime = time(),
  EndTime - StartTime.  %% was nun?

selectionS(Device) ->
  case io:get_line(Device, ".\n") of
    eof  -> [];
    Line -> selectionS(Line), selectionS(Device)
  end.


%% Von = Index from which you want to start sorting
%% Bis = Index which shall be the last sorted
selectionS(Array, Von, Bis) ->
  %% TODO: es soll kompletter Array zurückgegeben werden -> destruktiv veränderter alter Array
  selectionS(getSectorArray(Array, Von, Bis), initA(), 0, 0).

selectionS(Array, SortedArray, CountSortedElem, _) ->
  Length = lengthA(Array),
  if
    Length =:= 0 -> SortedArray;
    Length > 0 ->
      Minimum = getMinimum(Array),
      selectionS(deleteA(Array, getIndex(Array, Minimum)),
        setA(SortedArray, CountSortedElem, Minimum),
        CountSortedElem+1, 0)
  end.


%% Hilfsfunktionen
%% Returns the sector of the array we shall actually sort
getSectorArray(Array, Von, Bis) ->
  LastIndex = lengthA(Array)-1,
  if
    (Von =:= 0) and (Bis =:= LastIndex) -> Array;
    (LastIndex < Bis) -> getSectorArray(Array, Von, LastIndex, initA(), 0);
    true -> getSectorArray(Array, Von, Bis, initA(), 0)
  end.

getSectorArray(Array, Von, Bis, Output, SetElem) ->
  LengthArray = lengthA(Array),
  ActualElem = getA(Array, Von),
  if
    LengthArray =:= 0 -> Output;
    (LengthArray > 0) and (Von =:= Bis) -> setA(Output, SetElem, ActualElem);
    (LengthArray > 0) and (Von < Bis) ->
      getSectorArray(deleteA(Array, Von), Von, Bis-1, setA(Output, SetElem, ActualElem), SetElem+1)
  end.


%% Return minimum in array
getMinimum({}) -> false;
getMinimum({Elem, {}}) -> Elem;
getMinimum(Array) ->
  getMinimum(Array, 0, getA(Array, 0)).

getMinimum(Array, ActualIndex, Minimum) ->
  Length = lengthA(Array),
  ActualElem = getA(Array, ActualIndex),
  if
    (ActualElem < Minimum) and (ActualIndex =:= Length-1) -> ActualElem;
    (ActualElem < Minimum) and (ActualIndex < Length-1) -> getMinimum(Array, ActualIndex+1, ActualElem);
    (ActualElem >= Minimum) and (ActualIndex =:= Length-1) -> Minimum;
    (ActualElem >= Minimum) and (ActualIndex < Length-1) -> getMinimum(Array, ActualIndex+1, Minimum)
  end.


%% Deletes Element at index of array and returns array
deleteA(Array, Index) ->
  liste:delete(Array, Index+1).


%% Returns index of elem in array,
%% returns false if elem is not in array
getIndex(Array, Elem) ->
  getIndex(Array, Elem, 0).

getIndex(Array, Elem, AccuIndex) ->
  ElemAccuIndex = getA(Array, AccuIndex),
  Length = lengthA(Array),
  if
    (AccuIndex < Length) andalso (ElemAccuIndex =:= Elem) -> AccuIndex;
    (AccuIndex < Length) andalso (ElemAccuIndex =/= Elem) -> getIndex(Array, Elem, AccuIndex+1);
    true -> false
  end.