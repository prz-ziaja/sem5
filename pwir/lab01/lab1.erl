%% -*- coding: utf-8 -*-
-module(lab1).
% nazwa moduĹu

-compile([export_all]).
% opcje kompilatora, w tym wypadku eksport wszystkich funkcji
% przydatne przy testowaniu
%
%-export([add/2, head/1, sum/1] ).
% lista funkcji jakie bÄdÄ widoczne dla innych moduĹĂłw

-vsn(1.0).
% wersja

-kto_jest_najlepszy(ja).
%dowolny atom moĹźÄ byÄ wykorzystany jako 'atrybut' moduĹu
%po kompilacji uruchom lab1:module_info().
%inne narzÄdzia mogÄ korzystaÄ z tych informacji


-import(math,[pi/0]).
% lista moduĹĂłw ,ktĂłre sÄ potrzebne.
% nie jest to konieczne


%funkcje

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%add(a1,a2) -> a1+a2.
add(A1,A2) -> A1+A2.
%################################

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
head([H|_]) -> {glowa,H}.
%################################

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sum([]) -> 0;
sum([H|T]) -> H + sum(T).
%################################

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tsum(L) -> tsum(L, 0). %tsum/1

tsum([H|T], S) -> tsum(T, S+H); %tsum/2 
tsum([],S) -> S.
% klauzule funkcji rozdzielana sÄ Ĺrednikiem
% po ostatniej jst kropka
%################################


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
obwod_kola(Promien) -> 
        Dwa_pi = 2 * pi(),  % wyraĹźenie pomocnicze
        Dwa_pi * Promien.   % ostatni element przed '.' lib ';' 
                            % to wynik funkcji
%################################
avg(A,B) -> A + B /2.0.

factorial (0) -> 1;
factorial (N) -> N * factorial(N-1).
