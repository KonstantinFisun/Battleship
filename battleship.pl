% Динамические предикаты поля,
:- dynamic game_won/0, current_move/2, turn/1, hit_attempt/1, turn_result/1, computer_mode/1, board/2.


%% Запуск игры
run :-
    clean, % Очистка кэша
    start_game, % Приветствие
    play_game, %Запуск алгоритма игры
    end_game, % Конец игры
    !.

% Приветствие
start_game :-
    write('Добро пожаловать в морской бой'),
    nl,
    !.

% Запуск алгоритма игры
play_game :-
    catch(readFile(Board),error(_,_),fail), % Поймать ошибку при открытие файла при этом считываем поле игрока
    validateBoard(Board), % Определяем, допустима ли доска для этой игры
    write('Начнем играть!'), nl, % Вывод текста

    board(empty_board, Empty),

    % Генерация поля игрока
    assert( board(player_primary, Board) ), % Добавление поля игрока в базу
    assert( board(player_tracking, Empty) ),  % Добавление помеченное поле игрока в базу

    % Генерация компьютерного поля
    generateComputerBoard(ComputerBoard), % Получаем поле компьютера
    assert( board(computer_primary, ComputerBoard) ), % Добавление поля компьютера в базу
    assert( board(computer_tracking, Empty) ), % Добавление помеченное поле компьютера в базу
    assert( computer_mode(hunt) ), % Добавляем предикат

    % Игрок начинает первым
    show_player, % Вывод полей
    player_turn; % Ход игрока
    write('Неверный ввод поля.'), nl,
    write('Пожалуйста введите корректное поле и введите \'run.\' снова.'),
    fail.

% Конец игры
end_game :-
    write('Спасибо за игру!'), nl,
    write('Чтобы играть введите: \'run.\' !'),
    retract( game_won ).




% Чтение файла с расстановкой кораблей для игрока
readFile(Board) :-
    open('C:/board.txt', read, Stream),
    readStream(Stream, Board).

% Открываем поток для чтения файла
readStream(Stream, Result) :-
    \+ at_end_of_stream(Stream),
    read(Stream, Result),
    at_end_of_stream(Stream).



% ------------------------------------------------------------------------
% Считываем ход игрока
read_validate_move :-
    repeat,
    write('Сделайте ваш ход! fire(Row, Col).'), nl,
    ((catch(read(fire(Row, Col)), error(_, _), false), % ловим ошибки при вводе
        validate(Row, Col), % Проверяем правильность аргументов
        assert( current_move(Row, Col) ) % Добавляем в базу ход
      ) -> true;
    (write('Некорректный ввод хода. \nВведите любую клавишу, чтобы продолжить либо \'close\' для выхода'), nl,
     (read(A), A == 'close' ->break; fail)
    )).

% Проверяет, являются ли заданные значения строки и столбца законным ходом для игрока
validate(Row, Col) :-
    number(Row), number(Col), % Проверяем, что это цифры
    turn(player), % Ход игрока существует
    board(computer_primary, ComputerBoard), % Проверяем, что такое поле существует
    canAttempt(coord(Row, Col), ComputerBoard).

% Проверяет, являются ли заданные значения строки и столбца законным ходом для игрока
validate(Row, Col) :-
    number(Row), number(Col),% Проверяем, что это цифры
    turn(computer), % Ход компьютера существует
    board(player_primary, PlayerBoard), % Проверяем, что такое поле существует
    canAttempt(coord(Row, Col), PlayerBoard).

/*
    Коды ячеек
    0 - Пустая, без попадания
    1 - Занятая, без попадания
    2 - Пустая, с попаданием
    3 - Занятая, с попадание
*/

attempted(2).
attempted(3).

% Проверяем, что ячейка свободна
% canAttempt(+Coord, +Board)
% Coord - координаты
% Board - поле
canAttempt(Coord, B) :-
    toIndex(Coord, Index), % Преобразуем координаты в индекс
    my_get(B, Index, Space), % Получаем значение требуемой ячейки
    \+ attempted(Space). % Проверяем, чтобы это не 1 или 0

% Получаем код ячейки
% my_get(Board, Index, Space)
% Board - поле
% Index - индекс
% Space -
my_get(Board, Index, Space) :-
    Index > -1, Index < 100,
    get4(Board, 0, Index, Space),!.

% Получаем значение ячейки на позиции Index
% get4(Board,Current,Index,Space)
% Board - поле
% Current - текущий индекс
% Index - индекс требуемой ячейки
% Space - значение ячейки
get4([H|_], I, I, H). % Дно рекурсии
get4([_|T], Curr, Index, Space) :-
    dif(Curr, Index), % Если индексы различны
    Next is Curr + 1, % Идем дальше
    get4(T, Next, Index, Space),
    !.

% Координаты поля
coord(Row, Col) :-
    atomic(Row), atomic(Col), % Проверяем атом или целое
    Row > -1, Row < 10,
    Col > -1, Col < 10.


% Преобразует строку и столбец в индекс
toIndex(coord(Row, Col), Index) :-
    Index is (Row * 10) + Col.

% Преобразует индекс в строку и столбец
toCoord(Index, coord(Row, Col)) :-
    atomic(Index),
    Index > -1, Index < 100,
    Row is div(Index, 10),
    Col is mod(Index, 10).



current_move(Index) :- current_move(Row, Col), toIndex(coord(Row, Col), Index).

% ------------------------------------------------------------------------


% Ход игрока; Если выбранная клетка пустая (имеет значение 0),
% обновляет доску computer_primary и доску player_tracking до промаха
% (присваиваем значение 2)
update_boards :-
    % Ход игрока
    turn(player),

    % Получаем индекс текущего хода
    current_move(Index),

    % Получаем доступ к полю computer_primary
    board(computer_primary,ComputerBoard),

    % Проверяем, что в данном поле индексе имеет значение 0(0 - Пустая, без попадания)
    nth0(Index,ComputerBoard,0),

    % Получаем доступ к полю player_tracking
    board(player_tracking,PlayerTrackingBoard),

    % Проверяем, что в данном поле индексе имеет значение 0(0 - Пустая, без попадания)
    nth0(Index,PlayerTrackingBoard,0),

    % Меняем значение в данных индексах на 2(промах)
    replaceNth(ComputerBoard,Index,2,NewComputerBoard),
    replaceNth(PlayerTrackingBoard,Index,2,NewPlayerTrackingBoard),

    % обновляем результат выстрела как промах
    update_attempt_miss,

    % удаляем предыдущие состояние полей
    retract(board(computer_primary,_)),
    retract(board(player_tracking,_)),

    % добавляем новые поля в базу
    assert(board(computer_primary,NewComputerBoard)),
    assert(board(player_tracking,NewPlayerTrackingBoard)).

% Ход игрока; Если выбранная клетка корабль (имеет значение 1),
% обновляет доску computer_primary и доску player_tracking до попадания
% (присваиваем значение 3)
update_boards :-
    % Ход игрока
    turn(player),

    % Получаем индекс текущего хода
    current_move(Index),

    % Получаем доступ к полю computer_primary
    board(computer_primary,ComputerBoard),

    % Проверяем, что в данном поле индексе имеет значение 1(1 - Занятая, без попадания)
    nth0(Index,ComputerBoard,1),

    %  Получаем доступ к полю player_trackin
    board(player_tracking,PlayerTrackingBoard),

    % Проверяем, что в данном поле индексе имеет значение 0(0 - Пустая, без попадания)
    nth0(Index,PlayerTrackingBoard,0),

    % Меняем значение в данных индексах на 3(попадание)
    replaceNth(ComputerBoard,Index,3,NewComputerBoard),
    replaceNth(PlayerTrackingBoard,Index,3,NewPlayerTrackingBoard),

    % обновляем результат выстрела как попадание
    update_attempt_hit,

    % Удаляем предыдущие состояние полей
    retract(board(computer_primary,_)),
    retract(board(player_tracking,_)),

    % Добавляем новые поля в базу
    assert(board(computer_primary,NewComputerBoard)),
    assert(board(player_tracking,NewPlayerTrackingBoard)).

% Ход компьютера; Если выбранная клетка пустая (имеет значение 0),
% обновляет доску computer_primary и доску player_tracking до промаха
% (присваиваем значение 2)
update_boards :-
    % ход компьютера
    turn(computer),

    % Получаем индекс текущего хода
    current_move(Index),

    % Получаем доступ к полю player_primary
    board(player_primary,PlayerBoard),

    % Проверяем, что в данном поле индексе имеет значение 0(0 - Пустая, без попадания)
    nth0(Index,PlayerBoard,0),

    % Получаем доступ к полю computer_tracking
    board(computer_tracking,ComputerTrackingBoard),

    % Проверяем, что в данном поле индексе имеет значение 0(0 - Пустая, без попадания)
    nth0(Index,ComputerTrackingBoard,0),

    % Меняем значение в данных индексах на 2(промах)
    replaceNth(PlayerBoard,Index,2,NewPlayerBoard),
    replaceNth(ComputerTrackingBoard,Index,2,NewComputerTrackingBoard),

    % Обновляем результат выстрела как промах
    update_attempt_miss,

    % Удаляем предыдущие состояние полей
    retract( board(player_primary,_) ),
    retract( board(computer_tracking,_) ),

    % Добавляем новые поля в базу
    assert( board(player_primary,NewPlayerBoard) ),
    assert( board(computer_tracking,NewComputerTrackingBoard) ).

% Ход компьютера; Если выбранная клетка корабль (имеет значение 1),
% обновляет доску computer_primary и доску player_tracking до попадания
% (присваиваем значение 3)
update_boards :-
    % Ход компьютера
    turn(computer),

    % Получаем индекс текущего хода
    current_move(Index),

    % Получаем доступ к полю player_primary
    board(player_primary,PlayerBoard),

    % Проверяем, что в данном поле индексе имеет значение 1(1 - Занятая, без попадания)
    nth0(Index,PlayerBoard,1),

    % Получаем доступ к полю computer_tracking
    board(computer_tracking,ComputerTrackingBoard),

    % Проверяем, что в данном поле индексе имеет значение 0(0 - Пустая, без попадания)
    nth0(Index,ComputerTrackingBoard,0),

    % Меняем значение в данных индексах на 3(попадание)
    replaceNth(PlayerBoard,Index,3,NewPlayerBoard),
    replaceNth(ComputerTrackingBoard,Index,3,NewComputerTrackingBoard),

    % обновляем результат выстрела как попадание
    update_attempt_hit,

    % Удаляем предыдущие состояние полей
    retract( board(player_primary,_) ),
    retract( board(computer_tracking,_) ),

    % Добавляем новые поля в базу
    assert( board(player_primary,NewPlayerBoard) ),
    assert( board(computer_tracking,NewComputerTrackingBoard) ).

% Если мы попытаемся обновить доски, но у нас нет текущего хода, подтвердите ход еще раз
update_boards :- turn(player), \+ current_move(_), read_validate_move.


% ----------------------------------------------------------------------------

% Обновление попаданий
update_attempt_hit :- retract( hit_attempt(_) ), update_attempt_hit.
update_attempt_hit :- \+ retract( hit_attempt(_) ), assert( hit_attempt(hit) ).

% Обновление промахов
update_attempt_miss :- retract( hit_attempt(_) ), update_attempt_miss.
update_attempt_miss :- \+ retract( hit_attempt(_) ), assert( hit_attempt(miss) ).



% ------------------------------------------------------------------------------------
% Проверка условий выиграша
% Проверка выиграша при ходе игрока
check_win :-
    % Ход игрока
    turn(player),

    % Получаем доступ к полю computer_primary
    board(computer_primary,Board),

    % Проверка, что все корабли были поражены
    spacesOccupied(Board, 6, 3),

    assert( game_won ), % Добавляем в базу выигрыш
    !.

check_win :-
    % Ход игрока
    turn(player),

    % Получаем доступ к полю computer_primary
    board(computer_primary,Board),

    % Проверка, что не все корабли были поражены
    \+ spacesOccupied(Board, 6, 3),
    !.


% Проверка выиграша при ходе компьютера
check_win :-
    % Ход компьютера
    turn(computer),

    % Получаем доступ к полю player_primary
    board(player_primary,Board),

    % Проверка, что все корабли были поражены
    spacesOccupied(Board, 6, 3),

    assert( game_won ), % Добавляем в базу выигрыш
    !.

check_win :-
    % Ход компьютера
    turn(computer),

    % Получаем доступ к полю player_primary
    board(player_primary,Board),

    % Проверка, что не все корабли были поражены
    \+ spacesOccupied(Board, 6, 3),
    !.


% -------------------------------------------------------------------
% Действие, если игрок проиграл
player_turn :-
    game_won,
    nl,
    write('Поздравляем, вы выиграли!'),
    nl.

% Действие для игрока по умолчанию
player_turn :-
    \+ game_won,
    write('Ваш ход!'), nl,

    % Добавляем в базу, что это ход игрока
    assert( turn(player) ),

    % Извлекаем данные которые вводит пользователь
    read_validate_move,

    % Обновляем поля при данном ходе
    update_boards,

    % Отображение результатов этого хода
    turn_result,


    % Проверка есть ли выигрыш
    check_win,

    % Конец хода
    retract( turn(player) ),

    % Удаляем текущий ход
    retract( current_move(_,_) ),

    % Если попали то выполняется ход у игрока, иначе ход переходит компьютеру
    ( hit_attempt(hit)->player_turn,!;computer_turn,!),!.

% ----------------------------------------------------------------------------------
% Действие, если компьютер проиграл
computer_turn :-
    game_won,
    nl,
    write('Я сожалею, но вы проиграли('),
    nl.

% Действие для компьютера по умолчанию
computer_turn :-
    \+ game_won,
    write('\nХод врага.'), nl,

    % Добавляем в базу, что это ход компьютера
    assert( turn(computer) ),

    % Считаем лучший следующий ход компьютера
    computer_move,

    %  Обновляем поля при данном ходе
    update_boards,

    % Отображаем результаты данного хода
    show_player,
    turn_result,

    % Проверка есть ли выигрыш
    check_win,

    % Модифицируем стратегию компьютера основанная на ходе
    react,

    % Конец хода
    retract( turn(computer) ),

    % Удаляем текущий ход
    retract( current_move(_,_) ),

    % Если попали то выполняется ход у игрока, иначе ход переходит компьютеру
    ( hit_attempt(hit)->computer_turn,!;player_turn,!),!.



% --------------------------------------------------------------------------------------------
% Вывод полей


show_player :-
    board(player_tracking, PlayerTracking), % Проверяем, что такой предикаты существуют
    board(player_primary, PlayerBoard), % Проверяем, что такой предикаты существуют
    write('+------ Ваш враг -----+'), nl,
    show_board(PlayerTracking), nl, % Выводим поле врага
    write('+---- Ваши корабли ---+'), nl,
    show_board(PlayerBoard), % Выводим поле игрока
    write('|  К - Неподбитые корабли   |'), nl,
    write('|  П - Промах               |'), nl,
    write('|  X - Подбитые корабли     |'), nl,
    show_line, nl. % Вывод линии


% Показать доску
% show_board(+Board)
% Board - поле
show_board(B) :- write('+-0--1---2--3---4--5---6--7---8--9-+'),nl, write('0'), show_board(B, 0).

% Вывод линии
show_line :- write('+--------------------------------------+'), nl.


show_board([H|T], N) :-
    next_line(N), % Проверяем конец ли это строки
    toDisplay(H, Disp), % Получаем значение ячейки
    show_space(Disp), % Вывод ячейки
    N1 = N + 1,
    show_board(T, N1). % Идем дальше

% Если последняя строка
show_board([], _) :- write('|'), nl, show_line.

% Заполняем ячейки
show_space(Space) :- write('| '), write(Space), write(' ').

% Проверяем конец строки
next_line(N) :- ((X is mod(N, 10), X > 0);N = 0),!.
next_line(N) :- \+ N = 0, 0 is mod(N, 10), write('|'), nl, show_line, X is div(N,10),write(X).

% Отображение ячеек у доски
toDisplay(0, '~').
toDisplay(1, 'К').
toDisplay(2, 'П').
toDisplay(3, 'X').


% -------------------------------------------------------------



% Показывает игроку результат текущего хода
turn_result :-
    hit_attempt(hit), % Если было попадание
    turn(player), % Ход игрока
    current_move(Row, Col), % Текущий ход
    write('\n Вы попали в корабль с координатами ('),
    write(Row), write(', '), write(Col),
    write(')!\n'),
    sleep(2). % Задержка хода

turn_result :-
    hit_attempt(miss), % Если был промах
    turn(player), % Ход игрока
    write('Вы промазали'),
    sleep(2).

turn_result :-
    hit_attempt(hit), % Если было попадание
    turn(computer), % Ход компьютера
    current_move(Row, Col), % Текущий ход
    write('\n Враг попал в ваш корабль с координатами ('),
    write(Row), write(', '), write(Col),
    write(')!\n'),
    sleep(1).

turn_result :-
    hit_attempt(miss), % Если был промах
    turn(computer), % Ход компьютера
    current_move(Row, Col), % Текущий ход
    write('\nВраг промазал, попав в('),
    write(Row), write(', '), write(Col),
    write(')!\n'),
    sleep(1).



% ------------------------------------------------------------------------

% Генерируем случайное поле для компьютера
% generateComputerBoard(-B) - возвращает в B сгенерированное поле
generateComputerBoard(B) :-
    repeat, % Повторяем до тех пор пока не встретим fail
    N = 3, % !!!!!!!!!!!!!!!!!!!!!!
    createEmptyBoard(BA), % Создание списка нулей, размерности 100
    placeShips(N,BA,B), % Передаем 3, 100
    (validateBoard(B) -> true, ! ; fail). % Проверяем правильна ли составлена доска


% Размещаем корабли на доске
% placeShips+(NumberOfShips,+InitialBoard,ResultingBoard)
% NumberOfShips - количество кораблей
% InitialBoard - пустой список
% ResultingBoard - результат
placeShips(0,B,B).
placeShips(N,BA,B) :- placeShip(BA,BR), N1 is N-1, placeShips(N1,BR,B).


% Размещаем один корабль на доске
% placeShip(+InitialBoard,-ResultingBoard)
% InitialBoard - список
% ResultingBoard - результат
placeShip(B,BR) :-
    randomPosition(P), % Выбираем случайную позицию на поле
    positionAvailable(B,P), % Возвращает значение true, если выбранная позиция не используется
    findAdjacents(P,L), % Находит смежные квадраты заданного P
    length(L,LL), LL1 is LL-1, % Количество смежных квадратов
    random_between(0,LL1,I1), % Выбираем случайный квадрат из смежный
    nth0(I1,L,P1), % nth0 ищет в L, элемент P1 с индексом I1(получаем элемент P1)
    positionAvailable(B,P1), % Возвращает значение true, если выбранная позиция не используется
    replaceNth(B,P,1,BT),  % Заменяет p-й элемент в списке B значением 1, возвращает BT
    replaceNth(BT,P1,1,BR). % Заменяет p1-й элемент в списке BT значением 1, возвращает BR


% Выбираем случайную позицию на поле
% randomPosition(-resultingPosition)
randomPosition(P) :- random_between(0,99,P).


% Возвращает значение true, если выбранная позиция не используется
% positionAvailable(+Board,+Position)
positionAvailable(B,P) :- nth0(P,B,0). % nth0 ищет в B, элемент 0 с индексом P

% Создание списка от X до N
list_num(X, [X|T], N):- X =< N, X1 is X + 1,!,list_num(X1, T, N).
list_num(_,[],_).


% Находит смежные квадраты заданного P
% findAdjacents(+IndexOfBoard,-ListOfAdjacentSquares)
% IndexOfBoard - заданная клетка
% ListOfAdjacentSquares - получаемые смежные клетки с заданной

% Если корабль находится внутри матрицы
findAdjacents(P,L) :-
    board(list_11_89,R0123456789),
    member(P,R0123456789), P1 is P-10, P2 is P-1, P3 is P+1, P4 is P+10, L = [P1,P2,P3,P4],!.

% Если корабль находится вверху матрицы без углов
findAdjacents(P,L) :- member(P,[1,2,3,4,5,6,7,8]), P1 is P-1, P2 is P+1, P3 is P+10, L = [P1,P2,P3],!.

% Если корабль находится слева матрицы без углов
findAdjacents(P,L) :- member(P,[10,20,30,40,50,60,70,80]), P1 is P-10, P2 is P+1, P3 is P+10, L = [P1,P2,P3],!.

% Если корабль находится справа матрицы без углов
findAdjacents(P,L) :- member(P,[19,29,39,49,59,69,79,89]), P1 is P-10, P2 is P-1, P3 is P+10, L = [P1,P2,P3],!.

% Если корабль находится снизу матрицы без углов
findAdjacents(P,L) :- member(P,[91,92,93,94,95,96,97,98]), P1 is P-10, P2 is P-1,P3 is P+1, L = [P1,P2,P3],!.

% Если корабль находится в углах матрицы
findAdjacents(P,L) :- P = 0, L = [1,10],!.
findAdjacents(P,L) :- P = 9, L = [8,19],!.
findAdjacents(P,L) :- P = 90, L = [80,91],!.
findAdjacents(P,L) :- P = 99, L = [89,98],!.


% Заменяет n-й элемент в списке заданным значением
% replaceNth(InitialList,IndexToReplace,ReplacementValue,ResultingList).
% InitialList - изначальный список
% IndexToReplace - индекс, элемент которого заменяем
% ReplacementValue - значение, которое ставим
% ResultingList - полученный список
replaceNth([_|T],0,V,[V|T]).
replaceNth([H|T],P,V,[H|R]) :- P > 0, P < 100, P1 is P - 1, replaceNth(T,P1,V,R).






% -------------------------------------------------------------------------------------------
% Определяем, допустима ли доска для этой игры
validateBoard(B) :-
    length(B,100), % Проверяем длину
    spacesOccupied(B,6,1), %Проверяем количество единиц
    spacesOccupied(B,94,0), % Проверяем количество нулей
    occupiedValid(B,3). % Проверяем, что число кораблей 3


% Определяем сколько мест занято значением V
% spacesOccupied(+Board,?NumberOfOccurrences,-ValueToMatch)
% Board - поле(список)
% NumberOfOccurrences - количество совпадений с V
% ValueToMatch - значение с которым сравниваем
spacesOccupied([],0,_):-!.
spacesOccupied([S|B],N,V) :- number(V), S = V, spacesOccupied(B,N1,V), N is N1+1,!.
spacesOccupied([S|B],N,V) :- number(V), S \= V, spacesOccupied(B,N,V),!.


% Определяет,сколько кораблей на данной доске.
% Другими словами, правильно ли размещены двухпалобные корабли
% occupedValid(Board,NumberOfShipsTotal)
% Board - поле
% NumberOfShipsTotal - нужное количество кораблей
occupiedValid(B,NST) :-
    getRow(0,B,R0), % Получаем первую строку
    countShips(R0,CR0,0,NS1), % Количество кораблей в первой строке
    getRow(1,B,R1), % Получаем вторую строку
    countShips(R1,CR1,NS1,NS2),
    getRow(2,B,R2), % Получаем третью строку
    countShips(R2,CR2,NS2,NS3),
    getRow(3,B,R3), % Получаем четвертую строку
    countShips(R3,CR3,NS3,NS4),
    getRow(4,B,R4), % Получаем пятую строку
    countShips(R4,CR4,NS4,NS5),
    getRow(5,B,R5), % Получаем 6 строку
    countShips(R5,CR5,NS5,NS6),
    getRow(6,B,R6), % Получаем 7 строку
    countShips(R6,CR6,NS6,NS7),
    getRow(7,B,R7), % Получаем 8 строку
    countShips(R7,CR7,NS7,NS8),
    getRow(8,B,R8), % Получаем 9 строку
    countShips(R8,CR8,NS8,NS9),
    getRow(9,B,R9), % Получаем 10 строку
    countShips(R9,CR9,NS9,NS10),

    append(CR0,CR1,CRN1), % Объединяем полученные списки
    append(CRN1,CR2,CRN2),
    append(CRN2,CR3,CRN3),
    append(CRN3,CR4,CRN4),
    append(CRN4,CR5,CRN5),
    append(CRN5,CR6,CRN6),
    append(CRN6,CR7,CRN7),
    append(CRN7,CR8,CRN8),
    append(CRN8,CR9,CRN9),

    getColumn(0,CRN9,C0), % Получаем первый столбец
    countShips(C0,_,NS10,NS11),
    getColumn(1,CRN9,C1), % Получаем второй столбец
    countShips(C1,_,NS11,NS12),
    getColumn(2,CRN9,C2), % Получаем третий столбец
    countShips(C2,_,NS12,NS13),
    getColumn(3,CRN9,C3), % Получаем четвертый столбец
    countShips(C3,_,NS13,NS14),
    getColumn(4,CRN9,C4), % Получаем пятый столбец
    countShips(C4,_,NS14,NS15),
    getColumn(5,CRN9,C5), % Получаем 6 столбец
    countShips(C5,_,NS15,NS16),
    getColumn(6,CRN9,C6), % Получаем 7 столбец
    countShips(C6,_,NS16,NS17),
    getColumn(7,CRN9,C7), % Получаем 8 столбец
    countShips(C7,_,NS17,NS18),
    getColumn(8,CRN9,C8), % Получаем 9 столбец
    countShips(C8,_,NS18,NS19),
    getColumn(9,CRN9,C9), % Получаем 10 столбец
    countShips(C9,_,NS19,NS20),
    NS20 = NST. % Общее число кораблей

% Количество кораблей на поле
% countShips(Board,ResultingBoard,InitialValue,ShipsCounted)
% Board - поле
% ResultingBoard - результирующие поле
% InitialValue - начальное значение кораблей
% ShipsCounted - общее число кораблей
% dif - проверяет, разные ли значения
countShips([],[],A,A):-!. % Если списки пустые
countShips([H|T],[H|CR],A,N) :- dif(H,1),countShips(T,CR,A,N). % Если встретили 1
countShips([1],[1],A,A):-!. % Если остался один элемент
countShips([1,0|T],[1,0|CR],A,N) :- countShips(T,CR,A,N),!. % Если за 1 идет 0, то идем дальше
countShips([1,1,1|T],[1,0,0|CR],A,N) :- A1 is A+1, countShips(T,CR,A1,N). % Если 3 единицы в ряд
countShips([1,1,1|T],[0,0,1|CR],A,N) :- A1 is A+1, countShips(T,CR,A1,N).
countShips([1,1,1|T],[1,1,1|CR],A,N) :- countShips(T,CR,A,N).
countShips([1,1|T],[0,0|CR],A,N) :- A1 is A+1, countShips(T,CR,A1,N). % Если 2 единицы осталось

% Получаем столбец заданного номера
% getColumn(ColumnNumber,Board,Column)
% ColumnNumber - номер столбца
% Board - поле
% Column - Полученный столбец
getColumn(N,_,[]) :- N>99,!.
getColumn(N,B,C) :-
    nth0(N,B,A), N1 is N+10, getColumn(N1,B,C1), C = [A|C1].

% Получаем строку заданного номера
% getColumn(RowNumber,Board,Row)
% RowNumber - номер строки
% Board - поле
% Row - Полученная строка
getRow(N,B,R) :-
    N1 is N*10, N2 is N1+10, sliceList(B,N1,N2,R),!.

% Разрезает список на части, чтобы создать список меньшего размера с
% учетом начальной и конечной позиций.
% sliceList(List,NumberFirst,NumberSecond,ResultList)
% List - Начальный список
% NumberFirst - начальная позиция
% NumberSecond - конечная позиция
% ResultList - Полученный список
sliceList([_|T],S,E,L):-
    S>0, S<E, sliceList(T,S-1,E-1,L).
sliceList([H|T],S,E,L):-
    0 is S, S<E, E2 is E-1, L=[H|T1], sliceList(T,0,E2,T1).
sliceList(_,0,0,[]):-!.




%--------------------------------------------------------------
% Создание пустой доски
createEmptyBoard(R) :- listOfZeros(100,R).

% Создание списка нулей
% listOfZeros(+N,-R) в R получаем лист нулей с размерностью N.
listOfZeros(0,[]):-!.
listOfZeros(N,[0|R]) :- N1 is N-1, N1 >= 0, listOfZeros(N1,R).

%--------------------------------------------------------------


% Генерация хода компьютера
computer_move :-
    % Ход компьютера
    turn(computer),

    % Проверяем, если включен destroy режим
    computer_mode(destroy(Index)),

    % Получаем все смежные клетки
    findAdjacents(Index, Neighbours),

    % Получаем поле отслеживания у компьютера
    board(computer_tracking, TrackingBoard),


    canAttemptAdjacents(Neighbours, TrackingBoard, ValidNeighbours), % Находим подходящие смежные вершины
    length(ValidNeighbours,L), % Длина полученного списка
    random_number(0,L,Num), % Выбираем случайную из полученных клеток

    nth0(Num, ValidNeighbours, Value), % Получаем индекс нашей клетки
    toCoord(Value, coord(Row, Col)), % Переводим в координаты
    assert( current_move(Row, Col) ). % Добавляем в базу


computer_move :-
    % Ход компьютера
    turn(computer),

    % Проверяем, влючен ли режим hunt
    computer_mode(hunt),

    % Получаем поле отслеживания у компьютера
    board(computer_tracking, TrackingBoard),

    % Получаем список с индексом и количество клеток рядом с которыми нет
% выстрелов
    calculate(TrackingBoard, L),

    % Сортируем от больше к меньшему по второму элементу
    sort(2, @>=, L, SortedList),

    % Index - список, состоящий из количества клеток рядом с которыми нет выстрелов
    % Taken - количество
    take(SortedList, 10, Index, Taken),

    IndexTaken is Taken - 1,

    random_between(0, IndexTaken, MoveIndex), % берем рандомный среди них

    my_get(Index, MoveIndex, Value), % получаем  его индекс
    toCoord(Value, coord(Row, Col)), % Переводим в координаты
    assert( current_move(Row, Col) ). % Добавляем в базу


% Находим подходящие смежные клетки
% canAttemptAdjacents(+List, +Board, -L)
% List - смежные клетки
% Board - поля
% L - Результирующий список
canAttemptAdjacents(List, Board, L) :- checkNeighbours(List, Board, [], L).

checkNeighbours([H|T], Board, L1, L2) :-
    my_get(Board, H, Value), % Получаем значение в индексе H
    attempted(Value), % Проверяем, что там есть попадания
    checkNeighbours(T, Board, L1, L2). % Ищем дальше

checkNeighbours([H|T], Board, L1, [H|L2]) :-
    my_get(Board, H, Value), % Получаем значение в индексе H
    \+ attempted(Value), % Проверяем, что там нет попадания
    checkNeighbours(T, Board, L1, L2). % Ищем дальше

checkNeighbours([], _, L, L). % Если список пустой





% Получаем список с индексом и количество клеток рядом с которыми нет
% выстрелов
% calculate(+Board,-L)
% Board - поле
% L - результат
calculate(Board, L) :- calculate(0, Board, [], L).

% calculate(Index, Board, L, ResultList)
% Index - Индекс
% Board - поле
% L - итерация
% ResultList - результат
calculate(Index, Board, L1, [(Index, Num)|L2]) :-
    Index > -1, Index < 100, % Если индекс в поле
    my_get(Board, Index, Value), % Получаем значение индекса
    \+ attempted(Value), % Если в эту клетку ещё не стреляли
    findAdjacents(Index, Neighbours), % Находим соседей
    calculateAdjacents(Neighbours, Board, Num), %  количество куда можно стрельнуть
    NextIndex is Index + 1, % Прибавляем индекс
    calculate(NextIndex, Board, L1, L2). % Идем дальше

calculate(Index, Board, L1, L2) :-
    Index > -1, Index < 100, % Если индекс в поле
    my_get(Board, Index, Value), % Получаем значение индекса
    attempted(Value), % Если в эту клетку уже стреляли
    NextIndex is Index + 1, % Прибавляем индекс
    calculate(NextIndex, Board, L1, L2). % Идем дальше
calculate(Index, _, L, L) :- (Index < 0, !; Index > 99,!). % дно рекурсии


% Получаем количество куда можно стрельнуть
% calculateAdjacents(Neighbours, Board, Num)
% Neighbours - соседи
% Board - поле
% Num -
calculateAdjacents([H|T], Board, Num) :-
    my_get(Board, H, Value), % Получаем значение в индексе
    \+ attempted(Value), % Если в нем нету попаданий
    calculateAdjacents(T, Board, X), % Идем дальше
    Num is X + 1,!. % Прибавляем дальше

calculateAdjacents([H|T], Board, Num) :-
    my_get(Board, H, Value), % Получаем значение в индексе
    attempted(Value), % Если туда уже стреляли
    calculateAdjacents(T, Board, Num). % Идем дальше
calculateAdjacents([], _, 0):-!. % Если список пустой



% take(+Spaces, +Num, -Index, -Taken)
% Spaces - лист
% Num - количество
% Index -
% X
take(Spaces, Num, L, X) :- take(Spaces, Num, [], L, X).

take(_, Num, L, L, 0) :- Num < 1. % Если количество меньше 1
take([(Index, _)|T], Num, L1, [Index|L2], X1) :-
    Num1 is Num - 1, % Уменьшаем
    take(T, Num1, L1, L2, X),
    X1 is X + 1.


%-------------------------------------------------------------------

% Если компьютер находится в режиме уничтожения и промахивается,
% продолжаем
react :-
    % Ход компьютера
    turn(computer),

    % Добавляем в базу режим атаки
    computer_mode(destroy(_)),

    % Обновляем выстрел как промах
    hit_attempt(miss),
    !
    .

react :-
    % Ход компьютера
    turn(computer),

    % Добавляем в базу режим атаки
    computer_mode(destroy(_)),

    % Обновляем выстрел как попадание
    hit_attempt(hit),

    % Убираем все режимы
    retract( computer_mode(_) ),

    % Добавляем режим поиска
    assert( computer_mode(hunt) ),
    !
    .


react :-
    % Ход компьютера
    turn(computer),

    % Проверяем, что режим поиска
    computer_mode(hunt),

    % Обновляем выстрел как промах
    hit_attempt(miss),
    !
    .

react :-
    % Ход компьютера
    turn(computer),

    % Проверяем, что режим поиска
    computer_mode(hunt),

    % Обновляем выстрел как попадание
    hit_attempt(hit),

    % Убираем все режимы
    retract( computer_mode(_) ),

    % Получаем текущий индекс выстрела
    current_move(Index),

    % Добавляем в базу режим уничтожения
    assert( computer_mode(destroy(Index)) ),
    !
    .







% ---------------------------------------------------------------------------------------
% Очистка всех добавленных предикатов
clean :-
    clean_player_primary,
    clean_player_tracking,
    clean_computer_primary,
    clean_computer_tracking,
    clean_turn,
    clean_attempt,
    clean_current_move,
    clean_computer_mode,
    !.

clean_player_primary :- repeat, (retract( board(player_primary,_) ) -> false; true).
clean_player_tracking :- repeat, (retract( board(player_tracking,_) ) -> false; true).
clean_computer_primary :- repeat, (retract( board(computer_primary,_) ) -> false; true).
clean_computer_tracking :- repeat, (retract( board(computer_tracking,_) ) -> false; true).
clean_turn :- repeat, (retract( turn(_) ) -> false; true).
clean_attempt :- repeat, (retract( hit_attempt(_) ) -> false; true).
clean_current_move :- repeat, (retract( current_move(_, _) ) -> false; true).
clean_computer_mode :- repeat, (retract( computer_mode(_) ) -> false; true).

% ---------------------------------------------------------------------------
% Вспомогательные функции


random_number(N1,N2,Value):-random_between(N1,N2,Value).

% Пустая матрицы 10 на 10
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
