from __future__ import unicode_literals
import sys
from pyswip import Prolog, Functor, Variable, Query
import bat
from PyQt5 import QtCore, QtGui, QtWidgets
from PyQt5.QtCore import Qt
from PyQt5.QtWidgets import QMainWindow, QPushButton, QApplication
from PyQt5.QtGui import QTextCursor

import time

class Battleship(bat.Ui_MainWindow):

    def setupUi(self, MainWindow):
        # Установка формы
        super().setupUi(MainWindow)

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

    # Старт игры
    def start_game(self):
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
        print("Ход игрока")
        # Проверяем что ход игрока
        if self.next_move == False:
            return

        # Обновляем поля
        self.update_board()

        # Выполняем проверку на выигрышь
        check_win = list(self.prolog.query("game_won(player)"))
        if (len(check_win) > 0):
            return

        # Получаем входящие сообщения
        message = list(self.prolog.query("message(Mes)"))

        mes = message[0]["Mes"]
        if(len(mes)>0):
            # Кодировка
            mes = str(mes,'UTF-8')

        # Выводим текст в окошко
        # Получаем курсор
        self.cursor = QTextCursor(self.messageBox.document())

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
        print("Продолжение хода игрока")
        # Проверяем что ход игрока
        if self.next_move == False:
            return

        # Обновляем поля
        self.update_board()

        # Производим расчеты
        player_turn_second = list(self.prolog.query("player_turn_2"))

        hit = list(self.prolog.query("hit_attempt(hit)"))  # Получаем попадание
        print(hit)
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
        print("Ход компьютера")
        # Проверяем что ход компьютера
        if self.next_move == True:
            return

        # Выполняем проверку на выигрышь
        check_win = list(self.prolog.query("game_won(computer)"))
        if (len(check_win) > 0):
            return

        computer_turn = list(self.prolog.query("computer_turn"))

        hit = list(self.prolog.query("hit_attempt(hit)"))  # Получаем попадание

        print(hit)
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
            return

        btn = self.Centralwidget.sender()  # Откуда пришел сигнал

        self.current_move = [btn.objectName()[1], btn.objectName()[2]]  # Запоминаем выбранную клетку

        i = self.board_player_tracking.index(btn)  # Получаем индекс кнопки

        # Получаем поля
        player_tracking = list(self.prolog.query("board(player_tracking, PlayerTracking)"))
        player_tracking = player_tracking[0]["PlayerTracking"]

        # Выполняем проверку, что ход корректен
        if (player_tracking[i] == 1 or player_tracking[i] == 4 or player_tracking[i] == 0) and self.check_move == True:
            print("Ход корректен")
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
        # clean_board()
        computer_primary = list(self.prolog.query("board(computer_primary, ComputerBoard)"))
        computer_primary = computer_primary[0]["ComputerBoard"]
        for i in range(100):
            print(computer_primary[i])


    # Сдаться
    def give_up(self):
        clean_board()
        print("Сдался")

    # Расставить корабли вручную
    def manually_board(self):
        print("Вручную")

    # Расставить корабли случайно
    def accidentally_board(self):

        # Очищаем поля игрока
        clean = list(self.prolog.query("clean_player_primary"))

        # Выполняем запрос к прологу для генерации поля
        generateBoard = list(self.prolog.query("generatePlayerBoard(Board,Ship)"))

        # Добавляем в базу данные
        ships = generateBoard[0]["Ship"]
        board = generateBoard[0]["Board"]

        self.prolog.assertz(f"board(player_primary, {board})")
        self.prolog.assertz(f"ships(player, {ships})")

        # Обновляем поле игрока
        self.update_solo_board(board)

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

        computer_primary = list(self.prolog.query("board(computer_tracking, ComputerBoard)"))

        player_tracking = player_tracking[0]["PlayerTracking"]
        player_primary = player_primary[0]["PlayerBoard"]
        computer_primary = computer_primary[0]["ComputerBoard"]
        for i in range(100):
            # Если корабль
            if player_primary[i] == 1:
                self.board_player_primary[i].setStyleSheet("background-color: rgb(255, 255, 255);\n"
                                                           "border: 4px solid blue;")

            # Если пустая с попаданием
            if computer_primary[i] == 2:
                self.board_player_primary[i].setStyleSheet("""background-image: url(4.png);
                                                          background-repeat: no-repeat;
                                                          background-position: center center;
                                                          background-attachment: fixed;
                                                          -webkit-background-size: cover;
                                                          -moz-background-size: cover;
                                                          -o-background-size: cover;
                                                          background-size: cover;""")
            if computer_primary[i] == 3:
                self.board_player_primary[i].setStyleSheet("""background-image: url(3_my.png);
                                                          background-repeat: no-repeat;
                                                          background-position: center center;
                                                          background-attachment: fixed;
                                                          -webkit-background-size: cover;
                                                          -moz-background-size: cover;
                                                          -o-background-size: cover;
                                                          background-size: cover;
                                                          """)
            if computer_primary[i] == 4:
                self.board_player_primary[i].setStyleSheet("""background-image: url(2.png);
                                                          background-repeat: no-repeat;
                                                          background-position: center center;
                                                          background-attachment: fixed;
                                                          -webkit-background-size: cover;
                                                          -moz-background-size: cover;
                                                          -o-background-size: cover;
                                                          background-size: cover;
                                                          """)

            # Если корабль
            if player_tracking[i] == 1:
                self.board_player_tracking[i].setStyleSheet("background-color: rgb(255, 255, 255);\n"
                                                            "border: 4px solid red;")

            # Если пустая с попаданием
            if player_tracking[i] == 2:
                self.board_player_tracking[i].setStyleSheet("""background-image: url(4.png);
                                                                  background-repeat: no-repeat;
                                                                  background-position: center center;
                                                                  background-attachment: fixed;
                                                                  -webkit-background-size: cover;
                                                                  -moz-background-size: cover;
                                                                  -o-background-size: cover;
                                                                  background-size: cover;""")
            if player_tracking[i] == 3:
                self.board_player_tracking[i].setStyleSheet("""background-image: url(4.png);
                                                                  background-repeat: no-repeat;
                                                                  background-position: center center;
                                                                  background-attachment: fixed;
                                                                  -webkit-background-size: cover;
                                                                  -moz-background-size: cover;
                                                                  -o-background-size: cover;
                                                                  background-size: cover;
                                                                  border: 4px solid red;""")
            # Область вокруг корабля
            if player_tracking[i] == 0:
                self.board_player_tracking[i].setStyleSheet("background-color: rgb(255, 255, 255);\n"
                "border: 1px solid black;")
            if player_tracking[i] == 4:
                self.board_player_tracking[i].setStyleSheet("""background-image: url(2.png);
                                                                  background-repeat: no-repeat;
                                                                  background-position: center center;
                                                                  background-attachment: fixed;
                                                                  -webkit-background-size: cover;
                                                                  -moz-background-size: cover;
                                                                  -o-background-size: cover;
                                                                  background-size: cover;
                                                                  """)
                self.board_player_primary[i].setStyleSheet("""background-image: url(2.png);
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
