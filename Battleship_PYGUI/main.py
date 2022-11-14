from __future__ import unicode_literals
import sys
from pyswip import Prolog, Functor, Variable, Query
import bat
import Manually
from PyQt5 import QtCore, QtGui, QtWidgets
from PyQt5.QtCore import Qt
from PyQt5.QtWidgets import QMainWindow, QPushButton, QApplication, QMessageBox
from PyQt5.QtGui import QTextCursor
import sys
import time
import numpy as np

class Battleship(bat.Ui_MainWindow):
    # Установка
    def setupUi(self, MainWindow):

        # Установка формы
        super().setupUi(MainWindow)

        # Создание формы для заполнения кораблей вручную
        self.manual = Manually.Manually()

        # Определение заполненого поля игрока
        self.setup_board_player = False

        # Подключаем пролог
        self.prolog = Prolog()

        # Файл с игрой
        self.prolog.consult("prototype_game.pl")

        # Подключаем кодировку
        self.prolog.query("set_prolog_flag(encoding, utf8)")

        # Создаем списки с объектами
        self.board_player_primary = list()
        self.board_player_tracking = list()

        # Получаем ссылки на поля игрока
        for a in dir(self):
            if a.startswith('p') and len(a) == 3:
                self.board_player_primary.append(getattr(self, a))

        # Получаем ссылки на поля соперника
        for a in dir(self):
            if a.startswith('c') and len(a) == 3:
                self.board_player_tracking.append(getattr(self, a))

        # Получаем курсор
        self.cursor = QTextCursor(self.messageBox.document())

        # Ход не требуется
        self.next_move = False

        self.board = [0] * 100

        # Добавляем функционал
        self.add_functions()

    # Обработчик событий
    def add_functions(self):
        # Кнопка 'Начать игру'
        self.Start.clicked.connect(self.start_game)

        # Кнопка 'Перезапустить'
        self.Reset.clicked.connect(self.reset_game)

        # Кнопка 'Сдаться'
        self.GiveUp.clicked.connect(self.give_up)

        # Кнопка 'Расставить корабли вручную'
        self.Manually.clicked.connect(self.manually_board)

        # Кнопка 'Расставить корабли случайно'
        self.Accidentally.clicked.connect(self.accidentally_board)

        # Кнопки для хода у противника
        for but in self.board_player_tracking:
            but.clicked.connect(self.move)

        self.manual.Start_3.clicked.connect(self.apply)

        # Кнопка 'Очистить'
        self.manual.Clear.clicked.connect(self.manual.clear)

        # Кнопка 'Отмена'
        self.manual.Cancel.clicked.connect(self.manual.cancel)

        # Кнопки для расстановки кораблей
        for but in self.manual.board:
            but.clicked.connect(self.manual.click)



    # Старт игры
    def start_game(self):
        # Проверка, что поле игрока заполнено
        if self.setup_board_player == False:
            self.messageBox.setText("Заполните поле игрока перед началом!\n")
            return

        # Очистка буфера
        clean = list(self.prolog.query("clean"))
        # Запуск игры
        # Ход не требуется
        self.check_move = False

        # Начало игры
        player_game = list(self.prolog.query("play_game"))

        # Обновляем поля
        self.update_board()

        # Выводим сообщение
        self.messageBox.setText("Добро пожаловать в морской бой!\n")

        # Игрок ходит первым
        self.next_move = True

        self.player_move()

    # Ход игрока
    def player_move(self):
        # Проверяем что ход игрока
        if self.next_move == False:
            return

        # Обновляем поля
        self.update_board()

        # Выполняем проверку на выигрышь
        check_win = list(self.prolog.query("game_won(player)"))
        if (len(check_win) > 0):
            self.update_board()
            self.win()
            # Очистка буфера
            clean = list(self.prolog.query("clean"))
            # Очищаем поля игрока
            clean_board = list(self.prolog.query("clean_player_primary"))
            clean_ships = list(self.prolog.query("clean_ships"))
            self.clean_board()
            return

        # Получаем входящие сообщения
        message = list(self.prolog.query("message(Mes)"))

        mes = message[0]["Mes"]
        if(len(mes)>0):
            # Кодировка
            mes = str(mes,'UTF-8')

        # Выводим текст в окошко
        # Устанавливаем, курсов вверху
        self.cursor.setPosition(0)
        self.messageBox.setTextCursor(self.cursor)

        # Вывод текста
        self.messageBox.insertPlainText("Ход игрока\nВыберите клетку противника\n\n")

        # Устанавливаем, курсов вверху
        self.cursor.setPosition(0)
        self.messageBox.setTextCursor(self.cursor)

        # Вывод текста
        self.messageBox.insertPlainText(mes + "\n")

        player_turn_first = list(self.prolog.query("player_turn_1"))

        # Обновляем ход
        self.current_move = [-1, -1]
        self.check_move = True

    # Продолжение хода игрока
    def player_move_continue(self):
        # Проверяем что ход игрока
        if self.next_move == False:
            return

        # Обновляем поля
        self.update_board()

        # Производим расчеты
        player_turn_second = list(self.prolog.query("player_turn_2"))

        hit = list(self.prolog.query("hit_attempt(hit)"))  # Получаем попадание

        if len(hit) > 0:
            # Если игрок попал
            self.next_move = True
            self.player_move()
            return

        else:
            # Если игрок промазал
            self.next_move = False
            self.computer_move()
            return

    # Ход компьютера
    def computer_move(self):
        # Проверяем что ход компьютера
        if self.next_move == True:
            return

        # Выполняем проверку на выигрышь
        check_win = list(self.prolog.query("game_won(computer)"))
        if (len(check_win) > 0):
            self.update_board()
            self.lose()
            # Очистка буфера
            clean = list(self.prolog.query("clean"))
            # Очищаем поля игрока
            clean_board = list(self.prolog.query("clean_player_primary"))
            clean_ships = list(self.prolog.query("clean_ships"))
            self.clean_board()
            return

        computer_turn = list(self.prolog.query("computer_turn"))

        hit = list(self.prolog.query("hit_attempt(hit)"))  # Получаем попадание

        # Проверка что противник попал
        if (len(hit) > 0):
            self.next_move = False
            self.computer_move()
            return
        # Если противник промазал
        else:
            self.next_move = True
            self.player_move()
            return

    # Обработчик хода игрока
    def move(self):

        # Проверяем что ход игрока
        if self.next_move == False:

            # Устанавливаем, курсов вверху
            self.cursor.setPosition(0)
            self.messageBox.setTextCursor(self.cursor)

            # Вывод текста
            self.messageBox.insertPlainText("Ход в данный момент не доступен!\n")

            return

        btn = self.Centralwidget.sender()  # Откуда пришел сигнал

        self.current_move = [btn.objectName()[1], btn.objectName()[2]]  # Запоминаем выбранную клетку

        i = self.board_player_tracking.index(btn)  # Получаем индекс кнопки

        # Получаем поля
        player_tracking = list(self.prolog.query("board(player_tracking, PlayerTracking)"))
        player_tracking = player_tracking[0]["PlayerTracking"]

        # Выполняем проверку, что ход корректен
        if (player_tracking[i] == 1 or player_tracking[i] == 4 or player_tracking[i] == 0) and self.check_move == True:
            # Ход не требуется
            self.check_move = False

            # Добавляем в базу ход
            self.prolog.assertz((f"current_move({self.current_move[0]}, {self.current_move[1]})"))

            # Вызываем продолжение
            self.player_move_continue()
        else:
            # Ход требуется
            self.check_move = True

            # Устанавливаем, курсов вверху
            self.cursor.setPosition(0)
            self.messageBox.setTextCursor(self.cursor)

            # Выводим текст в окошко
            self.messageBox.insertPlainText("Клетка уже поражена\nВыберите другую клетку противника\n\n")

    # Перезапустить игру
    def reset_game(self):
        # Проверка, что поле игрока заполнено
        if self.setup_board_player == False:
            self.messageBox.setText("Заполните поле игрока перед началом!\n")
            return

        # Очищаем поля игрока
        clean_board = list(self.prolog.query("clean_player_primary"))
        clean_ships = list(self.prolog.query("clean_ships"))

        # Добавление в базу расстановки кораблей
        self.prolog.asserta(f"board(player_primary, {self.board})")
        self.prolog.asserta(f"ship(player, {self.ships})")

        # Обновляем поле игрока
        self.update_solo_board(self.board)

        # Обновляем поле игрока
        self.update_solo_board(self.board)

        # Вызов старта игры
        self.start_game()

    # Сдаться
    def give_up(self):
        self.lose()
        # Очистка буфера
        clean = list(self.prolog.query("clean"))
        # Очищаем поля игрока
        clean_board = list(self.prolog.query("clean_player_primary"))
        clean_ships = list(self.prolog.query("clean_ships"))
        self.clean_board()

    # Расставить корабли вручную
    def manually_board(self):
        self.manual.board_returned = self.board
        self.manual.update()
        self.manual.show()

    # Кнопка нажатия применить в форме Manually
    def apply(self):
        # Прячем окно
        self.manual.hide()
        # Получаем матрицу поля с кораблями
        self.board = self.manual.board_returned
        #self.location_ships(self.board)
        # Обновляем поле игрока
        self.update_solo_board(self.board)


    # Функции определяющая позиции кораблей
    def location_ships(self, board):
        print(board)
        board_around = [ [0] * 10] * 10

        board = np.reshape(board, (-1, 10))
        board = np.insert(board, 10, [0] * 10, axis = 1)
        board = np.insert(board, 0, [0] * 10, axis=1)

        # board = np.insert(board, 9, [0] * 10, axis = 2)
        # board = np.insert(board, 0, [0] * 10, axis=2)
        # for i in range(10):
        #     for j in range(10):
        #         board_around[i][j] = board[i][j] + board[i + 1][j] + board[i - 1][j] + board[i][j + 1] + board[i][j - 1]

        print(board)

    # Игрок выиграл
    def win(self):
        msg = QMessageBox()
        msg.setWindowTitle("Победа")
        msg.setText("Вы выиграли!!! Нажмите начать игру, чтобы начать сначала")
        msg.setIcon(QMessageBox.Information)
        msg.setStandardButtons(QMessageBox.Ok)
        msg.exec_()

    # Игрок проиграл
    def lose(self):
        msg = QMessageBox()
        # Название окна
        msg.setWindowTitle("Проигрышь")
        # Техт
        msg.setText("К сожалению, вы проиграли. Нажмите начать игру, чтобы начать сначала")

        # Иконка
        msg.setIcon(QMessageBox.Information)
        msg.setStandardButtons(QMessageBox.Close)
        msg.exec_()

    # Расставить корабли случайно
    def accidentally_board(self):
        self.setup_board_player = True

        # Очищаем поля игрока
        clean_board = list(self.prolog.query("clean_player_primary"))
        clean_ships = list(self.prolog.query("clean_ships"))

        # Выполняем запрос к прологу для генерации поля
        generateBoard = list(self.prolog.query("generatePlayerBoard(Board,Ship)"))

        # Получаем полученную расстановку
        self.ships = generateBoard[0]["Ship"]
        self.board = generateBoard[0]["Board"]

        # Добавление в базу расстановки кораблей
        self.prolog.asserta(f"board(player_primary, {self.board})")
        self.prolog.asserta(f"ship(player, {self.ships})")

        # Обновляем поле игрока
        self.update_solo_board(self.board)

    # Обновление одного поля
    def update_solo_board(self, board):

        for i in range(100):
            # Если корабль
            if board[i] == 1:
                self.board_player_primary[i].setStyleSheet("background-color: rgb(255, 255, 255);\n"
                                                           "border: 4px solid blue;")
            # Область вокруг корабля
            if board[i] == 4:
                self.board_player_primary[i].setStyleSheet("background-color: rgb(255, 255, 255);")
            # Пустая клетка
            if board[i] == 0:
                self.board_player_primary[i].setStyleSheet("background-color: rgb(255, 255, 255);")

    # Обновление двух полей
    def update_board(self):
        # Получение информации о текущем состоянии полей
        player_tracking = list(self.prolog.query("board(player_tracking, PlayerTracking)"))
        player_primary = list(self.prolog.query("board(player_primary, PlayerBoard)"))

        player_tracking = player_tracking[0]["PlayerTracking"]
        player_primary = player_primary[0]["PlayerBoard"]

        for i in range(100):
            #  Коды ячеек
            #     0 - Пустая, без попадания
            #     1 - Занятая, без попадания
            #     2 - Пустая, с попаданием
            #     3 - Занятая, с попадание
            #     4 - Зона вокруг корабля, без попадания

            # Поле игрока
            # Если клетка пустая без попадания
            if player_primary[i] == 0:
                self.board_player_primary[i].setStyleSheet("background-color: rgb(255, 255, 255);")

            # Если клетка занята кораблем без попадания
            if player_primary[i] == 1:
                self.board_player_primary[i].setStyleSheet("background-color: rgb(255, 255, 255);\n"
                                                           "border: 4px solid blue;")

            # Если пустая с попаданием
            if player_primary[i] == 2:
                self.board_player_primary[i].setStyleSheet("""background-image: url(block.png);
                                                          background-repeat: no-repeat;
                                                          background-position: center center;
                                                          background-attachment: fixed;
                                                          -webkit-background-size: cover;
                                                          -moz-background-size: cover;
                                                          -o-background-size: cover;
                                                          background-size: cover;""")
            # Если клетка занята кораблем с попаданием
            if player_primary[i] == 3:
                self.board_player_primary[i].setStyleSheet("""background-image: url(3_my.png);
                                                          background-repeat: no-repeat;
                                                          background-position: center center;
                                                          background-attachment: fixed;
                                                          -webkit-background-size: cover;
                                                          -moz-background-size: cover;
                                                          -o-background-size: cover;
                                                          background-size: cover;
                                                          """)

                # Если клетка занята кораблем с попаданием
                if player_primary[i] == 4:
                    self.board_player_primary[i].setStyleSheet("""background-image: url(block1.png);
                                                                      background-repeat: no-repeat;
                                                                      background-position: center center;
                                                                      background-attachment: fixed;
                                                                      -webkit-background-size: cover;
                                                                      -moz-background-size: cover;
                                                                      -o-background-size: cover;
                                                                      background-size: cover;
                                                                      """)

            # Поле противника
            # Если клетка пустая без попадания
            if player_tracking[i] == 0:
                self.board_player_tracking[i].setStyleSheet("background-color: rgb(255, 255, 255);")

            # Если клетка занята кораблем без попадания
            if player_tracking[i] == 1:
                self.board_player_tracking[i].setStyleSheet("background-color: rgb(255, 255, 255);\n"
                                                           "border: 4px solid blue;")

            # Если пустая с попаданием
            if player_tracking[i] == 2:
                self.board_player_tracking[i].setStyleSheet("""background-image: url(block.png);
                                                                  background-repeat: no-repeat;
                                                                  background-position: center center;
                                                                  background-attachment: fixed;
                                                                  -webkit-background-size: cover;
                                                                  -moz-background-size: cover;
                                                                  -o-background-size: cover;
                                                                  background-size: cover;""")
            # Если клетка занята кораблем с попаданием
            if player_tracking[i] == 3:
                self.board_player_tracking[i].setStyleSheet("""background-image: url(4.png);
                                                                  background-repeat: no-repeat;
                                                                  background-position: center center;
                                                                  background-attachment: fixed;
                                                                  -webkit-background-size: cover;
                                                                  -moz-background-size: cover;
                                                                  -o-background-size: cover;
                                                                  background-size: cover;""")
            # Клетка вокруг утонувшего корабля
            if player_tracking[i] == 4:
                self.board_player_tracking[i].setStyleSheet("""background-image: url(block.png);
                                                                  background-repeat: no-repeat;
                                                                  background-position: center center;
                                                                  background-attachment: fixed;
                                                                  -webkit-background-size: cover;
                                                                  -moz-background-size: cover;
                                                                  -o-background-size: cover;
                                                                  background-size: cover;
                                                                  """)

    # Очистка полей
    def clean_board(self):
        self.setup_board_player = False
        self.next_move = False
        self.messageBox.setText("")
        for i in range(100):
            self.board_player_primary[i].setStyleSheet("background-color: rgb(255, 255, 255);\n"
                                                       "border: 1px solid black;")
            self.board_player_tracking[i].setStyleSheet("background-color: rgb(255, 255, 255);\n"
                                                        "border: 1px solid black;")


def main():
    app = QtWidgets.QApplication(sys.argv)
    MainWindow = QtWidgets.QMainWindow()
    ui = Battleship()
    ui.setupUi(MainWindow)
    MainWindow.show()
    sys.exit(app.exec_())



if __name__ == "__main__":
    main()
