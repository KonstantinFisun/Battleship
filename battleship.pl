% Сгенерировать поле с кораблями матрица 10 на 10, где 1 расположение
% корабля в пространстве

% Создание матрицы заполненая 0
matrix(Nrows, Ncols, Matrix) :-
    length(Matrix, Nrows),
    length(Row, Ncols),
    maplist(=(0), Row),
    maplist(=(Row), Matrix).

% Получение элемента матрицы
get_matrix_element(Matrix, RowIndex, ColumnIndex, Element):-
  nth0(RowIndex, Matrix, Row),
  nth0(ColumnIndex, Row, Element).
  
% Корректный вывод матрицы
printMatrix(M) :- printRows(M, 0).
printRows([], _).
printRows([H|T], R) :-
  printRow(H, R, 0),
  Rpp is R + 1,
  printRows(T, Rpp).
printRow([], _, _) :- nl.
printRow([H|T], R, C) :-
  write(H),
  write(" "),
  Cpp is C + 1,
  printRow(T, R, Cpp).

% Точка запуска игры
start:-matrix(10,10,Matrix),printMatrix(Matrix).

