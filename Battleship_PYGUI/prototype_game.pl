% ������������ ��������� ����,
:- dynamic game_won/1, current_move/2, turn/1, hit_attempt/1, turn_result/1, computer_mode/1, board/2, hit_ships/2, destroy_ship/1, message/1,ship/2.
% ���������� ������ ������ � ����
player_board(Board,Ship):-
    % ��������� ���� ������
    assert( board(player_primary, Board) ),% ���������� ���� ������ � ����
    assert(ship(player,Ship)). % ���������� �������� ������ � ����


% ������ ��������� ����
play_game :-
    assert(hit_ships(player,[])), % ��������� ������
    assert(hit_ships(computer,[])), % ��������� ����������
    board(empty_board, Empty),



    assert( board(player_tracking, Empty) ),  % ���������� ���������� ���� ������ � ����

    % ��������� ������������� ����
    generateComputerBoard(ComputerBoard), % �������� ���� ����������
    assert( board(computer_primary, ComputerBoard) ), % ���������� ���� ���������� � ����
    assert( board(computer_tracking, Empty) ), % ���������� ���������� ���� ���������� � ����
    assert( computer_mode(hunt) ), % ��������� ��������

    assert(message('')).



% ------------------------------------------------------------------------
% ��������� ��� ������
read_validate_move :-
    repeat,
    write('�������� ���! fire(Row, Col).'), nl,
    (   catch(read(fire(Row, Col)), error(_, _), false), % ����� ������ ��� �����
        validate(Row, Col), % ��������� ������������ ����������
        assert( current_move(Row, Col) ) % ��������� � ���� ���
       -> !,true;
       ( write('\n��� ��������� ��� ������������!\n������� close ��� ������ ��� ����� ������� ��� �����������:'), read(A), A== 'close',!, false;fail )).

% ���������, �������� �� �������� �������� ������ � ������� �������� ����� ��� ������
validate(Row, Col) :-
    number(Row), number(Col), % ���������, ��� ��� �����
    turn(player), % ��� ������ ����������
    board(computer_primary, ComputerBoard), % �������� ������ � ����
    canAttempt(coord(Row, Col), ComputerBoard).

% ���������, �������� �� �������� �������� ������ � ������� �������� ����� ��� ������
validate(Row, Col) :-
    number(Row), number(Col),% ���������, ��� ��� �����
    turn(computer), % ��� ���������� ����������
    board(player_primary, PlayerBoard), % ���������, ��� ����� ���� ����������
    canAttempt(coord(Row, Col), PlayerBoard).

/*
    ���� �����
    0 - ������, ��� ���������
    1 - �������, ��� ���������
    2 - ������, � ����������
    3 - �������, � ���������
    4 - ���� ������ �������, ��� ���������
*/

attempted(2).
attempted(3).

% ���������, ��� ������ ��������
% canAttempt(+Coord, +Board)
% Coord - ����������
% Board - ����
canAttempt(Coord, B) :-
    toIndex(Coord, Index), % ����������� ���������� � ������
    my_get(B, Index, Space), % �������� �������� ��������� ������
    \+ attempted(Space). % ���������, ����� ��� �� 1 ��� 0

% �������� ��� ������
% my_get(Board, Index, Space)
% Board - ����
% Index - ������
% Space -
my_get(Board, Index, Space) :-
    Index > -1, Index < 100,
    get4(Board, 0, Index, Space),!.

% �������� �������� ������ �� ������� Index
% get4(Board,Current,Index,Space)
% Board - ����
% Current - ������� ������
% Index - ������ ��������� ������
% Space - �������� ������
get4([H|_], I, I, H). % ��� ��������
get4([_|T], Curr, Index, Space) :-
    dif(Curr, Index), % ���� ������� ��������
    Next is Curr + 1, % ���� ������
    get4(T, Next, Index, Space),
    !.

% ���������� ����
coord(Row, Col) :-
    atomic(Row), atomic(Col), % ��������� ���� ��� �����
    Row > -1, Row < 10,
    Col > -1, Col < 10.


% ����������� ������ � ������� � ������
toIndex(coord(Row, Col), Index) :-
    Index is (Row * 10) + Col.

% ����������� ������ � ������ � �������
toCoord(Index, coord(Row, Col)) :-
    atomic(Index),
    Index > -1, Index < 100,
    Row is div(Index, 10),
    Col is mod(Index, 10).



current_move(Index) :- current_move(Row, Col), toIndex(coord(Row, Col), Index).

% ------------------------------------------------------------------------


% ��� ������; ���� ��������� ������ ������ (����� �������� 0 ��� 4),
% ��������� ����� computer_primary � ����� player_tracking �� �������
% (����������� �������� 2)
update_boards :-
    % ��� ������
    turn(player),

    % �������� ������ �������� ����
    current_move(Index),

    % �������� ������ � ���� computer_primary
    board(computer_primary,ComputerBoard),

    % ���������, ��� � ������ ���� ������� ����� �������� 0(0 - ������, ��� ���������)
    (nth0(Index,ComputerBoard,0);nth0(Index,ComputerBoard,4)),

    % �������� ������ � ���� player_tracking
    board(player_tracking,PlayerTrackingBoard),

    % ���������, ��� � ������ ���� ������� ����� �������� 0(0 - ������, ��� ���������)
    nth0(Index,PlayerTrackingBoard,0),

    % ������ �������� � ������ �������� �� 2(������)
    replaceNth(ComputerBoard,Index,2,NewComputerBoard),
    replaceNth(PlayerTrackingBoard,Index,2,NewPlayerTrackingBoard),

    % ��������� ��������� �������� ��� ������
    update_attempt_miss,

    % ������� ���������� ��������� �����
    retract(board(computer_primary,_)),
    retract(board(player_tracking,_)),

    % ��������� ����� ���� � ����
    assert(board(computer_primary,NewComputerBoard)),
    assert(board(player_tracking,NewPlayerTrackingBoard)).

% ��� ������; ���� ��������� ������ ������� (����� �������� 1),
% ��������� ����� computer_primary � ����� player_tracking �� ���������
% (����������� �������� 3)
update_boards :-
    % ��� ������
    turn(player),

    % �������� ������ �������� ����
    current_move(Index),

    % �������� ������ � ���� computer_primary
    board(computer_primary,ComputerBoard),

    % ���������, ��� � ������ ���� ������� ����� �������� 1(1 - �������, ��� ���������)
    nth0(Index,ComputerBoard,1),

    %  �������� ������ � ���� player_tracking
    board(player_tracking,PlayerTrackingBoard),

    % ���������, ��� � ������ ���� ������� ����� �������� 0(0 - ������, ��� ���������)
    nth0(Index,PlayerTrackingBoard,0),

    % ��������� ������ ���������
    hit_ships(player,HitShips),
    append(HitShips,[Index],NewHitShips),

    % ������ �������� � ������ �������� �� 3(���������)
    replaceNth(ComputerBoard,Index,3,NewComputerBoard),
    replaceNth(PlayerTrackingBoard,Index,3,NewPlayerTrackingBoard),

    % ��������� ��������� �������� ��� ���������
    update_attempt_hit,

    % ������� ���������� ��������� �����
    retract(board(computer_primary,_)),
    retract(board(player_tracking,_)),

    % ������� ���������� ������ ���������
    retract(hit_ships(player,_)),

    % ��������� ����� ���� � ����
    assert(board(computer_primary,NewComputerBoard)),
    assert(board(player_tracking,NewPlayerTrackingBoard)),

    % ��������� � ���� ����� ������ ���������
    assert(hit_ships(player,NewHitShips)).

% ��� ����������; ���� ��������� ������ ������ (����� �������� 0),
% ��������� ����� computer_primary � ����� player_tracking �� �������
% (����������� �������� 2)
update_boards :-
    % ��� ����������
    turn(computer),

    % �������� ������ �������� ����
    current_move(Index),

    % �������� ������ � ���� player_primary
    board(player_primary,PlayerBoard),

    % ���������, ��� � ������ ���� ������� ����� �������� 0(0 - ������, ��� ���������)
    (nth0(Index,PlayerBoard,0);nth0(Index,PlayerBoard,4)),

    % �������� ������ � ���� computer_tracking
    board(computer_tracking,ComputerTrackingBoard),

    % ���������, ��� � ������ ���� ������� ����� �������� 0(0 - ������, ��� ���������)
    nth0(Index,ComputerTrackingBoard,0),

    % ������ �������� � ������ �������� �� 2(������)
    replaceNth(PlayerBoard,Index,2,NewPlayerBoard),
    replaceNth(ComputerTrackingBoard,Index,2,NewComputerTrackingBoard),

    % ��������� ��������� �������� ��� ������
    update_attempt_miss,

    % ������� ���������� ��������� �����
    retract( board(player_primary,_) ),
    retract( board(computer_tracking,_) ),

    % ��������� ����� ���� � ����
    assert( board(player_primary,NewPlayerBoard) ),
    assert( board(computer_tracking,NewComputerTrackingBoard) ).

% ��� ����������; ���� ��������� ������ ������� (����� �������� 1),
% ��������� ����� computer_primary � ����� player_tracking �� ���������
% (����������� �������� 3)
update_boards :-
    % ��� ����������
    turn(computer),

    % �������� ������ �������� ����
    current_move(Index),

    % �������� ������ � ���� player_primary
    board(player_primary,PlayerBoard),

    % ���������, ��� � ������ ���� ������� ����� �������� 1(1 - �������, ��� ���������)
    nth0(Index,PlayerBoard,1),

    % �������� ������ � ���� computer_tracking
    board(computer_tracking,ComputerTrackingBoard),

    % ���������, ��� � ������ ���� ������� ����� �������� 0(0 - ������, ��� ���������)
    nth0(Index,ComputerTrackingBoard,0),

    % ��������� ������ ���������
    hit_ships(computer,HitShips),
    append(HitShips,[Index],NewHitShips),

    % ������ �������� � ������ �������� �� 3(���������)
    replaceNth(PlayerBoard,Index,3,NewPlayerBoard),
    replaceNth(ComputerTrackingBoard,Index,3,NewComputerTrackingBoard),

    % ��������� ��������� �������� ��� ���������
    update_attempt_hit,

    % ������� ���������� ��������� �����
    retract( board(player_primary,_) ),
    retract( board(computer_tracking,_) ),

    % ������� ���������� ������ ���������
    retract(hit_ships(computer,_)),

    % ��������� ����� ���� � ����
    assert( board(player_primary,NewPlayerBoard) ),
    assert( board(computer_tracking,NewComputerTrackingBoard) ),

    % ��������� � ���� ����� ������ ���������
    assert(hit_ships(computer,NewHitShips)).



% ----------------------------------------------------------------------------

% ���������� ���������
update_attempt_hit :- retract( hit_attempt(_) ), update_attempt_hit.
update_attempt_hit :- \+ retract( hit_attempt(_) ), assert( hit_attempt(hit) ).

% ���������� ��������
update_attempt_miss :- retract( hit_attempt(_) ), update_attempt_miss.
update_attempt_miss :- \+ retract( hit_attempt(_) ), assert( hit_attempt(miss) ).



% ------------------------------------------------------------------------------------
% �������� ������� ��������
% �������� �������� ��� ���� ������
check_win :-
    % ��� ������
    turn(player),

    % �������� ������ � ���� computer_primary
    board(computer_primary,Board),

    % ��������, ��� ��� ������� ���� ��������
    spacesOccupied(Board, 20, 3),

    assert( game_won(player) ), % ��������� � ���� �������
    !.

check_win :-
    % ��� ������
    turn(player),

    % �������� ������ � ���� computer_primary
    board(computer_primary,Board),

    % ��������, ��� �� ��� ������� ���� ��������
    \+ spacesOccupied(Board, 20, 3),
    !.


% �������� �������� ��� ���� ����������
check_win :-
    % ��� ����������
    turn(computer),

    % �������� ������ � ���� player_primary
    board(player_primary,Board),

    % ��������, ��� ��� ������� ���� ��������
    spacesOccupied(Board, 20, 3),

    assert( game_won(computer) ), % ��������� � ���� �������
    !.

check_win :-
    % ��� ����������
    turn(computer),

    % �������� ������ � ���� player_primary
    board(player_primary,Board),

    % ��������, ��� �� ��� ������� ���� ��������
    \+ spacesOccupied(Board, 20, 3),
    !.


% -------------------------------------------------------------------


% �������� ��� ������ �� ���������
player_turn_1 :-

    retract(message(_)),
    assert(message('')),

    % ��������� � ����, ��� ��� ��� ������
    assert( turn(player) ),!.

    % �������� ��� ������

player_turn_2:-
    % ��������� ���� ��� ������ ����
    update_boards,


    % ��������� ����������� ����� ����
    turn_result,

    % �������� ���� �� �������
    check_win,

    % ����� ����
    retract( turn(player) ),

    % ������� ������� ���
    retract( current_move(_,_) ),!.

    % ��������� �������� ��� ������ ��������� ��� ����� ���������


% ----------------------------------------------------------------------------------

% �������� ��� ���������� �� ���������
computer_turn :-

    % ��������� � ����, ��� ��� ��� ����������
    assert( turn(computer) ),

    % ������� ������ ��������� ��� ����������
    computer_move,

    %  ��������� ���� ��� ������ ����
    update_boards,

    % ���������� ���������� ������� ����
    turn_result,

    % �������� ���� �� �������
    check_win,

    % ������������ ��������� ���������� ���������� �� ����
    react,

    % ����� ����
    retract( turn(computer) ),

    % ������� ������� ���
    retract( current_move(_,_) ),!.

 % ��������� �������� ��� ������ ��������� ��� ����� ���������






% --------------------------------------------------------------------------------------------
% ����� �����


show_player :-
    board(player_tracking, PlayerTracking), % ���������, ��� ����� ��������� ����������
    board(player_primary, PlayerBoard), % ���������, ��� ����� ��������� ����������
    write('+------ ��� ���� -----+'), nl,
    show_board(PlayerTracking), nl, % ������� ���� �����
    write('+---- ���� ������� ---+'), nl,
    show_board(PlayerBoard), % ������� ���� ������
    write('|  � - ���������� �������   |'), nl,
    write('|  � - ������               |'), nl,
    write('|  X - �������� �������     |'), nl,
    show_line, nl. % ����� �����


% �������� �����
% show_board(+Board)
% Board - ����
show_board(B) :- write('+-0--1---2--3---4--5---6--7---8--9-+'),nl, write('0'), show_board(B, 0).

% ����� �����
show_line :- write('+--------------------------------------+'), nl.


show_board([H|T], N) :-
    next_line(N), % ��������� ����� �� ��� ������
    toDisplay(H, Disp), % �������� �������� ������
    show_space(Disp), % ����� ������
    N1 = N + 1,
    show_board(T, N1). % ���� ������

% ���� ��������� ������
show_board([], _) :- write('|'), nl, show_line.

% ��������� ������
show_space(Space) :- write('| '), write(Space), write(' ').

% ��������� ����� ������
next_line(N) :- ((X is mod(N, 10), X > 0);N = 0),!.
next_line(N) :- \+ N = 0, 0 is mod(N, 10), write('|'), nl, show_line, X is div(N,10),write(X).

% ����������� ����� � �����
toDisplay(0, '~').
toDisplay(1, '�').
toDisplay(2, '�').
toDisplay(3, 'X').
toDisplay(4, '--').


% -------------------------------------------------------------


% ���������� ������ ��������� �������� ����
turn_result :-
    hit_attempt(hit), % ���� ���� ���������
    turn(player), % ��� ������

    % ���������� ��� �� ���� ������� � ������
    delete_ship_for_player,!;
    hit_attempt(hit), % ���� ���� ���������
    turn(player), % ��� ������

    current_move(Row, Col), % ������� ���

    message(Mes),

    string_concat('\n�� ������ � ������� � ������������ (',Row,R0),
    string_concat(Mes, R0, R1),
    string_concat(R1,', ',R2),
    string_concat(R2,Col,R3),
    string_concat(R3,')!\n',R4),
    retract(message(_)),
    assert(message(R4)),
    !.


turn_result :-
    hit_attempt(miss), % ���� ��� ������
    turn(player), % ��� ������

    message(Mes),

    string_concat(Mes,'�� ���������',R0),
    retract(message(_)),
    assert(message(R0)),
    !.



turn_result :-
    hit_attempt(hit), % ���� ���� ���������
    turn(computer), % ��� ����������

    % ���������� ��� �� ���� ������� � ����������
    delete_ship_for_computer,!;

    hit_attempt(hit), % ���� ���� ���������
    turn(computer), % ��� ����������

    % ������� �� ��� ���������
    (   retract(destroy_ship(_)),current_move(Row, Col), % ������� ���

    message(Mes),

    string_concat('\n ���� ����� � ��� ������� � ������������ (',Row,R0),
    string_concat(Mes, R0, R1),
    string_concat(R1,', ',R2),
    string_concat(R2,Col,R3),
    string_concat(R3,')!\n',R4),
    retract(message(_)),
    assert(message(R4)),

    !;

    current_move(Row, Col), % ������� ���

    message(Mes),

    string_concat('\n ���� ����� � ��� ������� � ������������ (',Row,R0),
    string_concat(Mes, R0, R1),
    string_concat(R1,', ',R2),
    string_concat(R2,Col,R3),
    string_concat(R3,')!\n',R4),
    retract(message(_)),
    assert(message(R4)),

    !).

turn_result :-
    hit_attempt(miss), % ���� ��� ������
    turn(computer), % ��� ����������
    current_move(Row, Col), % ������� ���

    message(Mes),

    string_concat('\n���� ��������, ����� �(',Row,R0),
    string_concat(Mes, R0, R1),
    string_concat(R1,', ',R2),
    string_concat(R2,Col,R3),
    string_concat(R3,')!\n',R4),
    retract(message(_)),
    assert(message(R4)),

    !.


delete_ship_for_player:-
     % �������� ��� �������� ������
    hit_ships(player,HitPlayer),

    % �������� ������ �������� �����
    ship(computer,ShipsComputer),

    % �������� ������ � ���� computer_primary
    board(computer_primary,ComputerBoard),

    % �������� ������ � ���� player_tracking
    board(player_tracking,PlayerTrackingBoard),

    % ������� ������ �������
    all_permutation(HitPlayer,ShipsComputer,1,Ship),

    % ���� ��������� �������
    nonvar(Ship),


    % ������� ������� �� ������
    delete(ShipsComputer,Ship,NewShipsComputer),

    % ������� ���������
    delete_list(HitPlayer, Ship, NewHitPlayer),

    % ������� ������ ������� ������
    findAdjacents_d_all_r(Ship,AdjacentsShip),


    % �������� ��
    replaceNth_list(ComputerBoard,2,AdjacentsShip,NewComputerBoard),
    replaceNth_list(PlayerTrackingBoard,2,AdjacentsShip,NewPlayerTrackingBoard),

    % ������� ���������� ��������� �����
    retract(board(computer_primary,_)),
    retract(board(player_tracking,_)),

    % ������� ���������� ������ ���������
    retract(hit_ships(player,_)),

    % ������� ���������� ������ ��������
    retract(ship(computer,_)),

    % ��������� ����� ���� � ����
    assert(board(computer_primary,NewComputerBoard)),
    assert(board(player_tracking,NewPlayerTrackingBoard)),

    % ��������� � ���� ����� ������ ���������
    assert(hit_ships(player,NewHitPlayer)),

    % ��������� � ���� ����� ������ ��������
    assert(ship(computer,NewShipsComputer)),

    message(Mes),

    string_concat(Mes,'\n�� �������� ������� ����� c ��������� : ',R0),
    p(Ship,ShipST), % ������ � ������
    string_concat(R0,ShipST,R1),
    retract(message(_)),
    assert(message(R1)),

    !.

delete_ship_for_computer:-
     % �������� ��� �������� ����������
    hit_ships(computer,HitComputer),

    % �������� ������ �������� �����
    ship(player,ShipsPlayer),

    % �������� ������ � ���� player_primary
    board(player_primary,PlayerBoard),

    % �������� ������ � ���� computer_tracking
    board(computer_tracking,ComputerTrackingBoard),

    % ������� ������ �������
    all_permutation(HitComputer,ShipsPlayer,1,Ship),

    % ���� ��������� �������
    nonvar(Ship),


    % ������� ������� �� ������
    delete(ShipsPlayer,Ship,NewShipsPlayer),

    % ������� ���������
    delete_list(HitComputer, Ship, NewHitComputer),

    % ������� ������ ������� ������
    findAdjacents_d_all_r(Ship,AdjacentsShip),


    % �������� ��
    replaceNth_list(PlayerBoard,2,AdjacentsShip,NewPlayerBoard),
    replaceNth_list(ComputerTrackingBoard,2,AdjacentsShip,NewComputerTrackingBoard),

    % ������� ���������� ��������� �����
    retract(board(player_primary,_)),
    retract(board(computer_tracking,_)),

    % ������� ���������� ������ ���������
    retract(hit_ships(computer,_)),

    % ������� ���������� ������ ��������
    retract(ship(player,_)),

    % ��������� ����� ���� � ����
    assert(board(player_primary,NewPlayerBoard)),
    assert(board(computer_tracking,NewComputerTrackingBoard)),

    % ��������� � ���� ����� ������ ���������
    assert(hit_ships(computer,NewHitComputer)),

    % ��������� � ���� ����� ������ ��������
    assert(ship(player,NewShipsPlayer)),

    % ���������, ��� ��� ��������� �������
    assert(destroy_ship(1)),


    message(Mes),

    string_concat(Mes,'\n���� ������� ��� ������� c ��������� : ',R0),
    p(Ship,ShipST), % ������ � ������
    string_concat(R0,ShipST,R1),
    retract(message(_)),
    assert(message(R1)),

    !.

p([],"").
p([H|T],S):-
    p(T,SS),
    concat(" ",SS,SSS),
    concat(H,SSS,S).

% �������� ���� ��������� �� ������

delete_list(R,[],R):-!.
delete_list(HitPlayer,[H|T],NewHitPlayer):-
    delete(HitPlayer,H,HitPlayer1),
    delete_list(HitPlayer1,T,NewHitPlayer).


% ������� �������
all_permutation(_,_,5,_):-!.
all_permutation(ListHit,ListShips,Num,Ship):-
    permition_ship(ListHit,ListShips,Num,Ship),!;
    !,Num1 is Num + 1,
    all_permutation(ListHit,ListShips,Num1,Ship).


permition_ship(ListHit,ListShips,Num,Ship):-permutation(ListHit,Num,Ship),member(Ship,ListShips),!.

% ����������
permutation(_List, 0, []).
permutation(List, PermutationLength, [Head|PermutationTail]):-
  member(Head, List),
  delete(List, Head, ListTail),
  PermutationTailLength is PermutationLength - 1,
  permutation(ListTail, PermutationTailLength, PermutationTail).

% ������� ��� ������ ������ �������
findAdjacents_d_all_r(Ship,Result):-findAdjacents_d_all0(Ship,[],R),set(R,R0),findAdjacents_d_all(Ship,R0,Result).

findAdjacents_d_all([],Result,Result):-!.
findAdjacents_d_all([H|T],Iter,Result):-
    del(H,Iter,Iter1),
    findAdjacents_d_all(T,Iter1,Result).


findAdjacents_d_all0([],Result,Result):-!.
findAdjacents_d_all0([H|T],Iter,Result):-
    findAdjacents_d(H,List),
    append(Iter,List,Iter1),
    findAdjacents_d_all0(T,Iter1,Result).




% ------------------------------------------------------------------------

% ���������� ��������� ���� ��� ������
% generateComputerBoard(B) -
% ���������� � B ��������������� ����

generatePlayerBoard(B,Ship) :-
    repeat, % ��������� �� ��� ��� ���� �� �������� fail
    createEmptyBoard(BA), % �������� ������ �����, ����������� 100

    placeShip_4(BA,B0,Ship_4), % �������� ������� 4 �� 1
    placeShips_3(2,B0,B1,Ship_4,Ship_3), % �������� 2 �������� 3 �� 1
    placeShips_2(3,B1,B2,Ship_3,Ship_2), %
    placeShips_1(4,B2,B,Ship_2,Ship),!.

% ���������� ��������� ���� ��� ����������
% generateComputerBoard(B) -
% ���������� � B ��������������� ����
generateComputerBoard(B) :-
    repeat, % ��������� �� ��� ��� ���� �� �������� fail
    createEmptyBoard(BA), % �������� ������ �����, ����������� 100

    placeShip_4(BA,B0,Ship_4), % �������� ������� 4 �� 1
    placeShips_3(2,B0,B1,Ship_4,Ship_3), % �������� 2 �������� 3 �� 1
    placeShips_2(3,B1,B2,Ship_3,Ship_2), %
    placeShips_1(4,B2,B,Ship_2,Ship),!,
    assert(ship(computer,Ship)).


% ��������� ������� 4 �� 1 �� �����
placeShip_4(B,BR,Ship):-
    repeat,
    randomPosition(P), % �������� ��������� ������� �� ����
    % ���������� �������� true, ���� ��������� ������� �� ������������
    positionAvailable(B,P),
    findAdjacents(P,L), % ������� ������� �������� ��������� P
    length(L,LL), LL1 is LL-1, % ���������� ������� ���������
    random_between(0,LL1,I1), % �������� ��������� ������� �� �������
    nth0(I1,L,P1), % nth0 ���� � L, ������� P1 � �������� I1(�������� ������� P1)
     positionAvailable(B,P1), % ���������� �������� true, ���� ��������� ������� �� ������������
    next_point_4(B,P,P1,P3),
    append([P,P1],[P3],Ship0),
    % ��������� �� ������ � �������� �� ������� ��������
    sort(Ship0, [P11,_,P33]),
    next_point_4(B,P11,P33,P4),
    append(Ship0,[P4],[P_1,P_2,P_3,P_4]),
    replaceNth(B,P_1,1,B0),  % �������� p-� ������� � ������ B ��������� 1, ���������� BT
    replaceNth(B0,P_2,1,B1), % �������� p2-� ������� � ������ BT ��������� 1, ���������� B1
    replaceNth(B1,P_3,1,B2),
    replaceNth(B2,P_4,1,B3),
    findAdjacents_d(P_1,List1),% ������� ������� ������ P
    findAdjacents_d(P_2,List2), % ������� ������� ������ P1
    findAdjacents_d(P_3,List3),
    findAdjacents_d(P_4,List4),
    append(List1,List2,List5), % ���������� ���������� �������
    append(List3,List4,List6),
    append(List5,List6,List7),
    set(List7,List77),
    % ������� ������� ��������
    del(P_1,List77,List8),
    del(P_2,List8,List9),
    del(P_3,List9,List10),
    del(P_4,List10,List11),
    replaceNth_list(B3,4,List11,BR), % ������ ������� ������ ���
    Ship = [[P_1,P_2,P_3,P_4]],!
    ;fail.


% ��������� ����� �����
% ������� ������������� �� �������
next_point_4(B,P1,P2,P3):-
    % ��������, ��� ��� �������
    (10 is abs(P1-P2);20 is abs(P1-P2)),
    (P1>P2 -> (A is P2-10, positionAvailable(B, A),  P3 is  A,!); A is P1-10, positionAvailable(B,A), P3 is A,!)
    .
next_point_4(B,P1,P2,P3):-
     (10 is abs(P1-P2);20 is abs(P1-P2)),
    (P1>P2 -> (A is P1+10, positionAvailable(B, A),  P3 is  A,!); A is P2+10, positionAvailable(B,A), P3 is A,!).

% ������� ������������� �� ������
next_point_4(B,P1,P2,P3):-
    (1 is abs(P1-P2);2 is abs(P1-P2)),
    (P1>P2 -> (A is P2-1, not(9 is mod(A,10)), positionAvailable(B, A),  P3 is  A,!); A is P1-1, not(9 is mod(A,10)), positionAvailable(B,A), P3 is A,!)
    .
next_point_4(B,P1,P2,P3):-
     (1 is abs(P1-P2);2 is abs(P1-P2)),
    (P1>P2 -> (A is P1+1, not(0 is mod(A,10)), positionAvailable(B, A),  P3 is  A,!); A is P2+1,not(0 is mod(A,10)), positionAvailable(B,A), P3 is A,!).



% ��������� ������� �� ����� 2 �� 1
% placeShips+(+NumberOfShips,+InitialBoard,-ResultingBoard,ShipList)
% NumberOfShips - ���������� �������� InitialBoard - ������ ������
% ResultingBoard - ���������
%
placeShips_3(0,B,B,Res,Res):-!.
placeShips_3(N,BA,B,ShipList,Res) :- placeShip_3(BA,BR,Ship), append(ShipList,[Ship],ShipListNew), N1 is N-1, placeShips_3(N1,BR,B,ShipListNew,Res).


% ��������� ���� ������� �� ����� 2 �� 1
% placeShip(+InitialBoard,-ResultingBoard,)
% InitialBoard - ������
% ResultingBoard - ���������

placeShip_3(B,BR,Ship) :-
    repeat,
    randomPosition(P), % �������� ��������� ������� �� ����
    % ���������� �������� true, ���� ��������� ������� �� ������������
    positionAvailable(B,P),
    findAdjacents(P,L), % ������� ������� �������� ��������� P
    length(L,LL), LL1 is LL-1, % ���������� ������� ���������
    random_between(0,LL1,I1), % �������� ��������� ������� �� �������
    nth0(I1,L,P1), % nth0 ���� � L, ������� P1 � �������� I1(�������� ������� P1)
     positionAvailable(B,P1), % ���������� �������� true, ���� ��������� ������� �� ������������
    next_point_4(B,P,P1,P3),
    append([P,P1],[P3],Ship0),
    % ��������� �� ������ � �������� �� ������� ��������
    sort(Ship0, [P11,P22,P33]),
    replaceNth(B,P11,1,B0),  % �������� p-� ������� � ������ B ��������� 1, ���������� BT
    replaceNth(B0,P22,1,B1), % �������� p2-� ������� � ������ BT ��������� 1, ���������� B1
    replaceNth(B1,P33,1,B2),
    findAdjacents_d(P11,List1),% ������� ������� ������ P
    findAdjacents_d(P22,List2), % ������� ������� ������ P1
    findAdjacents_d(P33,List3),
    append(List1,List2,List4), % ���������� ���������� �������
    append(List4,List3,List5),
    set(List5,List55),
    % ������� ������� ��������
    del(P11,List55,List6),
    del(P22,List6,List7),
    del(P33,List7,List8),
    replaceNth_list(B2,4,List8,BR), % ������ ������� ������ ���
    Ship = [P11,P22,P33],!
    ;fail.




% ��������� ������� �� ����� 2 �� 1
% placeShips+(+NumberOfShips,+InitialBoard,-ResultingBoard,ShipList)
% NumberOfShips - ���������� �������� InitialBoard - ������ ������
% ResultingBoard - ���������
%
placeShips_2(0,B,B,Res,Res):-!.
placeShips_2(N,BA,B,ShipList,Res) :- placeShip_2(BA,BR,Ship), append(ShipList,[Ship],ShipListNew), N1 is N-1, placeShips_2(N1,BR,B,ShipListNew,Res).


% ��������� ���� ������� �� ����� 2 �� 1
% placeShip(+InitialBoard,-ResultingBoard,)
% InitialBoard - ������
% ResultingBoard - ���������

placeShip_2(B,BR,Ship) :-
    repeat,
    randomPosition(P), % �������� ��������� ������� �� ����
    positionAvailable(B,P), % ���������� �������� true, ���� ��������� ������� �� ������������
    findAdjacents(P,L), % ������� ������� �������� ��������� P
    length(L,LL), LL1 is LL-1, % ���������� ������� ���������
    random_between(0,LL1,I1), % �������� ��������� ������� �� �������
    nth0(I1,L,P1), % nth0 ���� � L, ������� P1 � �������� I1(�������� ������� P1)
    positionAvailable(B,P1), % ���������� �������� true, ���� ��������� ������� �� ������������
    append([P],[P1],Ship),
    replaceNth(B,P,1,BT),  % �������� p-� ������� � ������ B ��������� 1, ���������� BT
    replaceNth(BT,P1,1,BR0), % �������� p1-� ������� � ������ BT ��������� 1, ���������� BR
    findAdjacents_d(P,List1),% ������� ������� ������ P
    findAdjacents_d(P1,List2), % ������� ������� ������ P1
    append(List1,List2,ListShip), % ���������� ���������� �������
    % ������� ������� ��������
    del(P,ListShip,ListShip1),
    del(P1,ListShip1,ListShip2),
    set(ListShip2,ListShip3),
    replaceNth_list(BR0,4,ListShip3,BR), % ������ ������� ������ ���
    !;fail.


% ��������� ������� �� ����� 1 �� 1
% placeShips+(+NumberOfShips,+InitialBoard,-ResultingBoard,ShipList)
% NumberOfShips - ���������� �������� InitialBoard - ������ ������
% ResultingBoard - ���������
%
placeShips_1(0,B,B,Res,Res):-!.
placeShips_1(N,BA,B,ShipList,Res) :- placeShip_1(BA,BR,Ship), append(ShipList,[Ship],ShipListNew), N1 is N-1, placeShips_1(N1,BR,B,ShipListNew,Res).


% ��������� ���� ������� �� ����� 2 �� 1
% placeShip(+InitialBoard,-ResultingBoard,)
% InitialBoard - ������
% ResultingBoard - ���������

placeShip_1(B,BR,Ship) :-
    repeat,
    randomPosition(P1), % �������� ��������� ������� �� ����
    positionAvailable(B,P1), % ���������� �������� true, ���� ��������� ������� �� ������������
    replaceNth(B,P1,1,B0),  % �������� p-� ������� � ������ B ��������� 1, ���������� B0
    findAdjacents_d(P1,List1), % ������� ������� ������ P1
    replaceNth_list(B0,4,List1,BR), % ������ ������� ������ ��x
    Ship = [P1],!;fail.



% ���� �� ������ � �������� ��� ��������
replaceNth_list(ResultingList,_,[],ResultingList):-!.
replaceNth_list(InitialList,ReplacementValue,[H|T],ResultingList):-
    replaceNth(InitialList,H,ReplacementValue,Result),
    replaceNth_list(Result,ReplacementValue,T,ResultingList),!.


% �������� ��������� ������� �� ����
% randomPosition(-resultingPosition)
randomPosition(P) :- random_between(0,99,P).


% ���������� �������� true, ���� ��������� ������� �� ������������
% positionAvailable(+Board,+Position)
positionAvailable(B,P) :- nth0(P,B,0). % nth0 ���� � B, ������� 0 � �������� P

% �������� ������ �� X �� N
list_num(X, [X|T], N):- X =< N, X1 is X + 1,!,list_num(X1, T, N).
list_num(_,[],_).


% ������� ������� ��������(�� ������� ������������) ��������� P
% findAdjacents(+IndexOfBoard,-ListOfAdjacentSquares)
% IndexOfBoard - �������� ������
% ListOfAdjacentSquares - ���������� ������� ������ � ��������

% ���� ������� ��������� ������ �������
findAdjacents(P,L) :-
    board(list_11_89,R0123456789),
    member(P,R0123456789), P1 is P-10, P2 is P-1, P3 is P+1, P4 is P+10, L = [P1,P2,P3,P4],!.

% ���� ������� ��������� ������ ������� ��� �����
findAdjacents(P,L) :- member(P,[1,2,3,4,5,6,7,8]), P1 is P-1, P2 is P+1, P3 is P+10, L = [P1,P2,P3],!.

% ���� ������� ��������� ����� ������� ��� �����
findAdjacents(P,L) :- member(P,[10,20,30,40,50,60,70,80]), P1 is P-10, P2 is P+1, P3 is P+10, L = [P1,P2,P3],!.

% ���� ������� ��������� ������ ������� ��� �����
findAdjacents(P,L) :- member(P,[19,29,39,49,59,69,79,89]), P1 is P-10, P2 is P-1, P3 is P+10, L = [P1,P2,P3],!.

% ���� ������� ��������� ����� ������� ��� �����
findAdjacents(P,L) :- member(P,[91,92,93,94,95,96,97,98]), P1 is P-10, P2 is P-1,P3 is P+1, L = [P1,P2,P3],!.

% ���� ������� ��������� � ����� �������
findAdjacents(P,L) :- P = 0, L = [1,10],!.
findAdjacents(P,L) :- P = 9, L = [8,19],!.
findAdjacents(P,L) :- P = 90, L = [80,91],!.
findAdjacents(P,L) :- P = 99, L = [89,98],!.


% ������� ������� ��������(������� ������������) ��������� P
% findAdjacents(+IndexOfBoard,-ListOfAdjacentSquares)
% IndexOfBoard - �������� ������
% ListOfAdjacentSquares - ���������� ������� ������ � ��������

% ���� ������� ��������� ������ �������
findAdjacents_d(P,L) :-
    board(list_11_89,R0123456789),
    member(P,R0123456789), P1 is P-11,P2 is P-10, P3 is P-9, P4 is P+1, P5 is P+11, P6 is P+10, P7 is P+9, P8 is P-1 , L = [P1,P2,P3,P4,P5,P6,P7,P8],!.

% ���� ������� ��������� ������ ������� ��� �����
findAdjacents_d(P,L) :- member(P,[1,2,3,4,5,6,7,8]), P1 is P-1, P2 is P+1, P3 is P+10, P4 is P+9, P5 is P+11, L = [P1,P2,P3,P4,P5],!.

% ���� ������� ��������� ����� ������� ��� �����
findAdjacents_d(P,L) :- member(P,[10,20,30,40,50,60,70,80]), P1 is P-10, P2 is P+1, P3 is P+10, P4 is P-9, P5 is P+11, L = [P1,P2,P3,P4,P5],!.

% ���� ������� ��������� ������ ������� ��� �����
findAdjacents_d(P,L) :- member(P,[19,29,39,49,59,69,79,89]), P1 is P-10, P2 is P-1, P3 is P+10, P4 is P-11, P5 is P+9, L = [P1,P2,P3,P4,P5],!.

% ���� ������� ��������� ����� ������� ��� �����
findAdjacents_d(P,L) :- member(P,[91,92,93,94,95,96,97,98]), P1 is P-10, P2 is P-1,P3 is P+1,P4 is P-11, P5 is P-9, L = [P1,P2,P3,P4,P5],!.

% ���� ������� ��������� � ����� �������
findAdjacents_d(P,L) :- P = 0, L = [1,10,11],!.
findAdjacents_d(P,L) :- P = 9, L = [8,18,19],!.
findAdjacents_d(P,L) :- P = 90, L = [80,81,91],!.
findAdjacents_d(P,L) :- P = 99, L = [88,89,98],!.

% �������� n-� ������� � ������ �������� ���������
% replaceNth(InitialList,IndexToReplace,ReplacementValue,ResultingList).
% InitialList - ����������� ������
% IndexToReplace - ������, ������� �������� ��������
% ReplacementValue - ��������, ������� ������
% ResultingList - ���������� ������
replaceNth([_|T],0,V,[V|T]):-!.
replaceNth([H|T],P,V,[H|R]) :- P > 0, P < 100, P1 is P - 1, replaceNth(T,P1,V,R).






% -------------------------------------------------------------------------------------------
% ����������, ��������� �� ����� ��� ���� ����
validateBoard(B) :-
    length(B,100), % ��������� �����
    spacesOccupied(B,20,1). %��������� ���������� ������
    %occupiedValid(B,3). % ���������, ��� ����� �������� 3


% ���������� ������� ���� ������ ��������� V
% spacesOccupied(+Board,?NumberOfOccurrences,-ValueToMatch)
% Board - ����(������)
% NumberOfOccurrences - ���������� ���������� � V
% ValueToMatch - �������� � ������� ����������
spacesOccupied([],0,_):-!.
spacesOccupied([S|B],N,V) :- number(V), S = V, spacesOccupied(B,N1,V), N is N1+1,!.
spacesOccupied([S|B],N,V) :- number(V), S \= V, spacesOccupied(B,N,V),!.


% ����������,������� �������� �� ������ �����.
% ������� �������, ��������� �� ��������� ������������ �������
% occupedValid(Board,NumberOfShipsTotal)
% Board - ����
% NumberOfShipsTotal - ������ ���������� ��������
occupiedValid(B,NST) :-
    getRow(0,B,R0), % �������� ������ ������
    countShips(R0,CR0,0,NS1), % ���������� �������� � ������ ������
    getRow(1,B,R1), % �������� ������ ������
    countShips(R1,CR1,NS1,NS2),
    getRow(2,B,R2), % �������� ������ ������
    countShips(R2,CR2,NS2,NS3),
    getRow(3,B,R3), % �������� ��������� ������
    countShips(R3,CR3,NS3,NS4),
    getRow(4,B,R4), % �������� ����� ������
    countShips(R4,CR4,NS4,NS5),
    getRow(5,B,R5), % �������� 6 ������
    countShips(R5,CR5,NS5,NS6),
    getRow(6,B,R6), % �������� 7 ������
    countShips(R6,CR6,NS6,NS7),
    getRow(7,B,R7), % �������� 8 ������
    countShips(R7,CR7,NS7,NS8),
    getRow(8,B,R8), % �������� 9 ������
    countShips(R8,CR8,NS8,NS9),
    getRow(9,B,R9), % �������� 10 ������
    countShips(R9,CR9,NS9,NS10),

    append(CR0,CR1,CRN1), % ���������� ���������� ������
    append(CRN1,CR2,CRN2),
    append(CRN2,CR3,CRN3),
    append(CRN3,CR4,CRN4),
    append(CRN4,CR5,CRN5),
    append(CRN5,CR6,CRN6),
    append(CRN6,CR7,CRN7),
    append(CRN7,CR8,CRN8),
    append(CRN8,CR9,CRN9),

    getColumn(0,CRN9,C0), % �������� ������ �������
    countShips(C0,_,NS10,NS11),
    getColumn(1,CRN9,C1), % �������� ������ �������
    countShips(C1,_,NS11,NS12),
    getColumn(2,CRN9,C2), % �������� ������ �������
    countShips(C2,_,NS12,NS13),
    getColumn(3,CRN9,C3), % �������� ��������� �������
    countShips(C3,_,NS13,NS14),
    getColumn(4,CRN9,C4), % �������� ����� �������
    countShips(C4,_,NS14,NS15),
    getColumn(5,CRN9,C5), % �������� 6 �������
    countShips(C5,_,NS15,NS16),
    getColumn(6,CRN9,C6), % �������� 7 �������
    countShips(C6,_,NS16,NS17),
    getColumn(7,CRN9,C7), % �������� 8 �������
    countShips(C7,_,NS17,NS18),
    getColumn(8,CRN9,C8), % �������� 9 �������
    countShips(C8,_,NS18,NS19),
    getColumn(9,CRN9,C9), % �������� 10 �������
    countShips(C9,_,NS19,NS20),
    NS20 = NST. % ����� ����� ��������

% ���������� �������� �� ����
% countShips(Board,ResultingBoard,InitialValue,ShipsCounted)
% Board - ����
% ResultingBoard - �������������� ����
% InitialValue - ��������� �������� ��������
% ShipsCounted - ����� ����� ��������
% dif - ���������, ������ �� ��������
countShips([],[],A,A):-!. % ���� ������ ������
countShips([H|T],[H|CR],A,N) :- dif(H,1),countShips(T,CR,A,N). % ���� ��������� 1
countShips([1],[1],A,A):-!. % ���� ������� ���� �������
countShips([1,0|T],[1,0|CR],A,N) :- countShips(T,CR,A,N),!. % ���� �� 1 ���� 0, �� ���� ������
countShips([1,1,1|T],[1,0,0|CR],A,N) :- A1 is A+1, countShips(T,CR,A1,N). % ���� 3 ������� � ���
countShips([1,1,1|T],[0,0,1|CR],A,N) :- A1 is A+1, countShips(T,CR,A1,N).
countShips([1,1,1|T],[1,1,1|CR],A,N) :- countShips(T,CR,A,N).
countShips([1,1|T],[0,0|CR],A,N) :- A1 is A+1, countShips(T,CR,A1,N). % ���� 2 ������� ��������

% �������� ������� ��������� ������
% getColumn(ColumnNumber,Board,Column)
% ColumnNumber - ����� �������
% Board - ����
% Column - ���������� �������
getColumn(N,_,[]) :- N>99,!.
getColumn(N,B,C) :-
    nth0(N,B,A), N1 is N+10, getColumn(N1,B,C1), C = [A|C1].

% �������� ������ ��������� ������
% getColumn(RowNumber,Board,Row)
% RowNumber - ����� ������
% Board - ����
% Row - ���������� ������
getRow(N,B,R) :-
    N1 is N*10, N2 is N1+10, sliceList(B,N1,N2,R),!.

% ��������� ������ �� �����, ����� ������� ������ �������� ������� �
% ������ ��������� � �������� �������.
% sliceList(List,NumberFirst,NumberSecond,ResultList)
% List - ��������� ������
% NumberFirst - ��������� �������
% NumberSecond - �������� �������
% ResultList - ���������� ������
sliceList([_|T],S,E,L):-
    S>0, S<E, sliceList(T,S-1,E-1,L).
sliceList([H|T],S,E,L):-
    0 is S, S<E, E2 is E-1, L=[H|T1], sliceList(T,0,E2,T1).
sliceList(_,0,0,[]):-!.




%--------------------------------------------------------------
% �������� ������ �����
createEmptyBoard(R) :- listOfZeros(100,R).

% �������� ������ �����
% listOfZeros(+N,-R) � R �������� ���� ����� � ������������ N.
listOfZeros(0,[]):-!.
listOfZeros(N,[0|R]) :- N1 is N-1, N1 >= 0, listOfZeros(N1,R).

%--------------------------------------------------------------


% ��������� ���� ����������
% ���, ���� ������� ����� �����������
computer_move :-
    % ��� ����������
    turn(computer),

    % �������� ������� ������������� �������
    computer_mode(destroy(List_Index)),


    length(List_Index,Length),

    % ���� ��� ��������� ���������
    Length == 1,

    % ������� �� ������ �������
    member(Index, List_Index),

    % �������� ��� ������� ������
    findAdjacents(Index, Neighbours),

    % �������� ���� ������������ � ����������
    board(computer_tracking, TrackingBoard),


    canAttemptAdjacents(Neighbours, TrackingBoard, ValidNeighbours), % ������� ���������� ������� �������
    length(ValidNeighbours,L), % ����� ����������� ������

    % ��������� ���������� � 0
    L1 is L-1,

    random_number(0,L1,Num), % �������� ��������� �� ���������� ������

    nth0(Num, ValidNeighbours, Value), % �������� ������ ����� ������
    toCoord(Value, coord(Row, Col)), % ��������� � ����������
    assert( current_move(Row, Col) ); % ��������� � ����


    % ��� ����������
    turn(computer),

    % �������� ������� ������������� �������
    computer_mode(destroy(List_Index)),

    % ��������� ������ ���������
    sort(List_Index, Sort_List_Index),

    length(Sort_List_Index,Length),

    % ���� ��� ������� ���������
    Length == 2,

    % �������� ��� �������� �� ������
    [P1,P2] = Sort_List_Index,

    % �������� ���� ������������ � ����������
    board(computer_tracking, TrackingBoard),

    % ���������� ����� �����
    next_point_4(TrackingBoard,P1,P2,P3),

    toCoord(P3, coord(Row, Col)), % ��������� � ����������
    assert( current_move(Row, Col) ); % ��������� � ����

    % ��� ����������
    turn(computer),

    % �������� ������� ������������� �������
    computer_mode(destroy(List_Index)),

    % ��������� ������ ���������
    sort(List_Index, Sort_List_Index),

    length(Sort_List_Index,Length),

    % ���� ��� ������� ���������
    Length == 3,

    % �������� ��� �������� �� ������
    [P1,_,P3] = Sort_List_Index,

    % �������� ���� ������������ � ����������
    board(computer_tracking, TrackingBoard),

    % ���������� ����� �����
    next_point_4(TrackingBoard,P1,P3,P4),

    toCoord(P4, coord(Row, Col)), % ��������� � ����������
    assert( current_move(Row, Col) ). % ��������� � ����


% ��� ���� ����� �����
computer_move :-
    % ��� ����������
    turn(computer),

    % ���������, ������ �� ����� hunt
    computer_mode(hunt),

    % �������� ���� ������������ � ����������
    board(computer_tracking, TrackingBoard),

    % �������� ������ � �������� � ���������� ������ ����� � �������� ���
% ���������
    calculate(TrackingBoard, L),

    length(L,Len),

    F is div(Len,2),

    % ��������� �� ������ � �������� �� ������� ��������
    sort(2, @>=, L, SortedList),

    % Index - ������, ��������� �� ���������� ������ ����� � �������� ��� ���������
    % Taken - ����������
    take(SortedList, F, Index, Taken),

    IndexTaken is Taken - 1,

    random_between(0, IndexTaken, MoveIndex), % ����� ��������� ����� ���

    my_get(Index, MoveIndex, Value), % ��������  ��� ������
    toCoord(Value, coord(Row, Col)), % ��������� � ����������
    assert( current_move(Row, Col) ). % ��������� � ����


% ������� ���������� ������� ������
% canAttemptAdjacents(+List, +Board, -L)
% List - ������� ������
% Board - ����
% L - �������������� ������
canAttemptAdjacents(List, Board, L) :- checkNeighbours(List, Board, [], L).

checkNeighbours([H|T], Board, L1, L2) :-
    my_get(Board, H, Value), % �������� �������� � ������� H
    attempted(Value), % ���������, ��� ��� ���� ���������
    checkNeighbours(T, Board, L1, L2). % ���� ������

checkNeighbours([H|T], Board, L1, [H|L2]) :-
    my_get(Board, H, Value), % �������� �������� � ������� H
    \+ attempted(Value), % ���������, ��� ��� ��� ���������
    checkNeighbours(T, Board, L1, L2). % ���� ������

checkNeighbours([], _, L, L). % ���� ������ ������





% �������� ������ � �������� � ���������� ������ ����� � �������� ���
% ���������
% calculate(+Board,-L)
% Board - ����
% L - ���������
calculate(Board, L) :- calculate(0, Board, [], L).

% calculate(Index, Board, L, ResultList)
% Index - ������
% Board - ����
% L - ��������
% ResultList - ���������
calculate(Index, Board, L1, [(Index, Num)|L2]) :-
    Index > -1, Index < 100, % ���� ������ � ����
    my_get(Board, Index, Value), % �������� �������� �������
    \+ attempted(Value), % ���� � ��� ������ ��� �� ��������
    findAdjacents(Index, Neighbours), % ������� �������
    calculateAdjacents(Neighbours, Board, Num), %  ���������� ���� ����� ����������
    NextIndex is Index + 1, % ���������� ������
    calculate(NextIndex, Board, L1, L2). % ���� ������

calculate(Index, Board, L1, L2) :-
    Index > -1, Index < 100, % ���� ������ � ����
    my_get(Board, Index, Value), % �������� �������� �������
    attempted(Value), % ���� � ��� ������ ��� ��������
    NextIndex is Index + 1, % ���������� ������
    calculate(NextIndex, Board, L1, L2). % ���� ������
calculate(Index, _, L, L) :- (Index < 0, !; Index > 99,!). % ��� ��������


% �������� ���������� ���� ����� ����������
% calculateAdjacents(Neighbours, Board, Num)
% Neighbours - ������
% Board - ����
% Num -
calculateAdjacents([H|T], Board, Num) :-
    my_get(Board, H, Value), % �������� �������� � �������
    \+ attempted(Value), % ���� � ��� ���� ���������
    calculateAdjacents(T, Board, X), % ���� ������
    Num is X + 1,!. % ���������� ������

calculateAdjacents([H|T], Board, Num) :-
    my_get(Board, H, Value), % �������� �������� � �������
    attempted(Value), % ���� ���� ��� ��������
    calculateAdjacents(T, Board, Num). % ���� ������
calculateAdjacents([], _, 0):-!. % ���� ������ ������



% take(+Spaces, +Num, -Index, -Taken)
% Spaces - ����
% Num - ����������
% Index -
% X
take(Spaces, Num, L, X) :- take(Spaces, Num, [], L, X),!.

take(_, Num, L, L, 0) :- Num < 1,!. % ���� ���������� ������ 1
take([(Index, _)|T], Num, L1, [Index|L2], X1) :-
    Num1 is Num - 1, % ���������
    take(T, Num1, L1, L2, X),
    X1 is X + 1,!.


%-------------------------------------------------------------------

% ���� ��������� ��������� � ������ ����������� � �������������,
% ����������
react :-
    % ��� ����������
    turn(computer),

    % ��������� ��� ���� ����� �����
    computer_mode(destroy(_)),

    % ��������� ������� ��� ������
    hit_attempt(miss),
    !
    .

react :-
    % ��� ����������
    turn(computer),

    % ��������� ��� ���� ����� �����
    computer_mode(destroy(_)),

    % ���������, ��� �� ������
    hit_attempt(hit),

    % �� ���������� �������
    destroy_ship(1),

    % ������� ����������, ��� ���������� �������
    retract( destroy_ship(1)),

    % ������� ��� ������
    clean_computer_mode,


    % ��������� ����� ������
    assert( computer_mode(hunt) ),
    !
    .

react :-
    % ��� ����������
    turn(computer),

    % ��������� ��� ���� ����� �����
    computer_mode(destroy(List)),

    % ���������, ��� �� ������
    hit_attempt(hit),

    % �������� ������� ���
    current_move(Index),

    % ��������� �������
    append(List,[Index], New_List),

    % ������� ��� ������
    clean_computer_mode,

    % ��������� ����� ������
    assert( computer_mode(destroy(New_List)) ),
    !
    .


react :-
    % ��� ����������
    turn(computer),

    % ���������, ��� ����� ������
    computer_mode(hunt),

    % ��������� ������� ��� ������
    hit_attempt(miss),
    !
    .

react :-
    % ��� ����������
    turn(computer),

    % ���������, ��� ����� ������
    computer_mode(hunt),

    % ��������� ������� ��� ���������
    hit_attempt(hit),

    % �� ���������� �������
    destroy_ship(1),

    % ������� ����������, ��� ���������� �������
    retract( destroy_ship(1)),

    % ������� ��� ������
    clean_computer_mode,

    % ��������� � ���� ����� �����������
    assert( computer_mode(hunt)),
    !
    .

react :-
    % ��� ����������
    turn(computer),

    % ���������, ��� ����� ������
    computer_mode(hunt),

    % ��������� ������� ��� ���������
    hit_attempt(hit),

    % ������� ��� ������
    clean_computer_mode,

    % �������� ������� ������ ��������
    current_move(Index),

    % ��������� � ���� ����� �����������
    assert( computer_mode(destroy([Index])) ),
    !
    .



% ---------------------------------------------------------------------------------------
% ������� ���� ����������� ����������
clean :-
    clean_player_tracking,
    clean_computer_primary,
    clean_computer_tracking,
    clean_turn,
    clean_attempt,
    clean_current_move,
    clean_computer_mode,
    clean_hit_ships,
    clean_destroy_ship,
    clean_message,
    !.

clean_player_primary :- repeat, (retract( board(player_primary,_) ) -> false; true,!).
clean_player_tracking :- repeat, (retract( board(player_tracking,_) ) -> false; true).
clean_computer_primary :- repeat, (retract( board(computer_primary,_) ) -> false; true).
clean_computer_tracking :- repeat, (retract( board(computer_tracking,_) ) -> false; true).
clean_turn :- repeat, (retract( turn(_) ) -> false; true).
clean_attempt :- repeat, (retract( hit_attempt(_) ) -> false; true).
clean_current_move :- repeat, (retract( current_move(_, _) ) -> false; true).
clean_computer_mode :- repeat, (retract( computer_mode(_) ) -> false; true).
clean_ships:- repeat, (retract( ship(_,_) ) -> false; true,!).
clean_hit_ships:- repeat, (retract( hit_ships(_,_) ) -> false; true).
clean_destroy_ship:- repeat, (retract( destroy_ship(_) ) -> false; true).
clean_message:- repeat, (retract( message(_) ) -> false; true).

% ---------------------------------------------------------------------------
% ��������������� �������


random_number(N1,N2,Value):-random_between(N1,N2,Value).

% ������ ������� 10 �� 10
board(empty_board,
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).
board(list_11_89,[11,12,13,14,15,16,17,18,21,22,23,24,25,26,27,28,31,32,33,34,35,36,37,38,41,42,43,44,45,46,47,48,51,52,53,54,55,56,57,58,61,62,63,64,65,66,67,68,71,72,73,74,75,76,77,78,81,82,83,84,85,86,87,88]).


% �������� �� ������
del(_,[],[]).
del(H,[H|Tail],Tail):-!.
del(X,[H|Tail],[H|NewTail]):-del(X,Tail,NewTail).


% �������� ���������� �� ������
mymember(X,[X|_]):-!.
mymember(X,[_|T]) :- mymember(X,T).

set([],[]):-!.
set([H|T],[H|Out]) :-
    not(mymember(H,T)),
    set(T,Out),!.
set([H|T],Out) :-
    mymember(H,T),
    set(T,Out),!.
