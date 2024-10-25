% dynamic for add

:- dynamic(student/3).
:- dynamic(course/7).
:- dynamic(room/3).


%room
%room(id,capacity,equipments)

room(a1,10,[smartboard,projector]).
room(a2,10,[handi,projector]).
room(a3,10,[smartboard,projector,handi]).
room(a4,10,[handi,smartboard]).
room(a5,2,[smartboard]).

%course
%course(id,instr,capacity,starttime,finaltime,room)

course(cse341,genc,10,8,9,a1,smartboard).
course(cse400,hasaricelebi,10,8,9,a2,smartboard).
course(cse331,bayrakci,10,11,13,a3,handi).
course(cse470,ibrahims,10,9,10,a4,projector).

%instructor
%instructor(id,[course1,course2],preferences)
instructor(yakupgenc,[cse341],smartboard).
instructor(hasaricelebi,[cse400],projector).
instructor(bayrakci,[cse331],handi).
instructor(ibrahims,[cse470],smartboard).

%student
%student(id,[course1,course2],special)

student(1,[cse341,cse470],yes).
student(2,[cse341,cse331],no).
student(3,[cse400,cse470],no).
student(4,[cse341,cse331],no).
student(5,[cse400,cse470],no).
student(6,[cse331,cse341,cse470],no).
student(7,[cse331,cse400],no).
student(8,[cse341,cse470],no).
student(9,[cse341,cse331],no).


% Add  new student.
addStudent(SID,Courses,Z):-
	\+ student(SID,_,_),
	assertz(student(SID,Courses,Z)).
% add new room.
addRoom(RoomID,Capacity,Equipments) :-
	\+ room(RoomID,_,_),
	assertz(room(RoomID,Capacity,Equipments)).

%add new course.
addCourse(CourseID,Instructor,Capacity,T1,T2,Room1,Ekipman) :-
	\+ course(CourseID,_,_,_,_,_,_),
	instructor(Instructor,_,_),
	assertz(course(CourseID,Instructor,Capacity,T1,T2,Room1,Ekipman)).

printstudent(X):-
	student(X,_,_).
printRoom(X):-
	room(X,_,_).

printcourse(X):-
	course(X,_,_,_,_,_,_).


% Check whether there is any scheduling conflict.
calculateconflicts(C1,C2,T11,T12,T21,T22):-
        course(C1,_,_,T11,T12,_,_),
        course(C2,_,_,T21,T22,_,_).

conflicts(C1,C2) :-
    calculateconflicts(C1,C2,T1,T12,T21,T22),
	(\+(T12  =<  T21 ; T22 =< T1)), !.



%Check whether a student can be enrolled to a given class.
enroll(Studentid,C) :-
         student(Studentid,_,Engel),
	 course(C,_,_,_,_,R,D),
	 room(R,_,Ekipman),
	 (Engel == no ; (Engel == yes ,member(handi,Ekipman),handi ==D)).


%•Check which room can be assigned to a given class.
assignroom(Course1,Room1):-
         course(Course1,_,_,_,_,_,D),
          room(Room1,_,Ekipman),
          member(D,Ekipman).

%Check which room can be assigned to which classes
roomAssignClass(Room1,C) :-
        room(Room1,_,D),
        course(C,_,_,_,_,_,Ekipman),
        member(Ekipman,D).

%•Check which classes a student can be assigned
assignStudent(Student1,C):-
        student(Student1,_,Engel),
        course(C,_,_,_,_,_,Ekipman),
       ( Engel == no ; ( Engel== yes, Ekipman == handi)).
