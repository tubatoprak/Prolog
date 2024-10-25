% knowledge base
% part2
flight(ankara,istanbul,1).  % fact: ankara and istanbul has a flight with cost 1.
flight(ankara,rize,5).
flight(ankara,izmir,6).
flight(ankara,diyarbakýr,8).
flight(ankara,van,4).

flight(antalya,izmir,2).
flight(antalya,diyarbakýr,4).
flight(antalya,erzincan,3).

flight(diyarbakýr,ankara,8).
flight(diyarbakýr,antalya,4).

flight(canakkale,erzincan,6).

flight(erzincan,canakkale,6).
flight(erzincan,antalya,3).

flight(rize,istanbul,4).
flight(rize,ankara,5).

flight(gaziantep,van,3).

flight(istanbul,izmir,2).
flight(istanbul,ankara,1).
flight(istanbul,rize,4).

flight(izmir,ankara,6).
flight(izmir,istanbul,2).
flight(izmir,antalya,2).

flight(van,gaziantep,3).
flight(van,ankara,4).


route(X,Y,C) :-	travel(X,Y,C,[]).    %There is a path if we can travel from one to other

travel(X,Y,C,_) :-	flight(X,Y,C).
travel(X,Y,C,A)	:-	flight(X,Z,C1),
					\+ member(Z,A),
					not(Z == Y),
					travel(Z,Y,C2, [X|A]),
                                        X\= Y ,C is C1 + C2.
