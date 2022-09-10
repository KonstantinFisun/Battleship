% Сгенерировать поле с кораблями матрица 10 на 10, где 1 расположение
% корабля в пространстве

% Создание матрицы заполненая 0
matrix(Nrows, Ncols, Matrix) :-
    length(Matrix, Nrows),
    length(Row, Ncols),
    maplist(=(0), Row),
    maplist(=(Row), Matrix).

% Точка запуска игры
start:-matrix(10,10,Matrix),get_matrix_element(Matrix,1,1,Y),write(Y).

% Получение элемента матрицы
get_matrix_element(Matrix, RowIndex, ColumnIndex, Element):-
  nth0(RowIndex, Matrix, Row),
  nth0(ColumnIndex, Row, Element).
