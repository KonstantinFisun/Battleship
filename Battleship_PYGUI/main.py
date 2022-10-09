from __future__ import unicode_literals
import sys
from pyswip import Prolog
import bat
from PyQt5 import QtCore, QtGui, QtWidgets
from PyQt5.QtCore import Qt


class Battleship(bat.Ui_MainWindow):


    def setupUi(self, MainWindow):
        # Установка формы
        super().setupUi(MainWindow)

        # Подключаем пролог
        prolog = Prolog()

        # Файл с игрой
        # prolog.consult("1.pl")

        # Создаем списки с объектами
        self.board_player_primary = list()
        self.board_player_tracking = list()

        # Получаем ссылки на поля игрока
        for a in dir(self):
            if a.startswith('p'):
                self.board_player_primary.append(getattr(self, a))

        # Получаем ссылки на поля соперника
        for a in dir(self):
            if a.startswith('c'):
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

    # Старт игры
    def start_game(self):
        # Запуск игры

        print(self.board_player_primary)
        print(self.board_player_tracking)

        # getattr(self, self.board_player_primary[0]).setStyleSheet("background-color: rgb(0, 0, 0);")
        # .setStyleSheet("background-color: rgb(0, 0, 0);\n"
        #                                                           "border: 1px solid black;")

        # Игрок начинает первым
        move = 1

    # Перезапустить игру
    def reset_game(self):
        print("Перезапустил")

    # Сдаться
    def give_up(self):
        print("Сдался")

    # Расставить корабли вручную
    def manually_board(self):
        print("Вручную")

    # Расставить корабли вручную
    def accidentally_board(self):




    # Обновление полей
    def update_board(self):
        # Вывод информации о текущем состоянии полей
        # player_tracking = list(prolog.query("board(player_tracking, PlayerTracking)"))
        # player_primary = list(prolog.query("board(player_primary, PlayerBoard)"))

        print(self.board_player_primary)
        # print(self.board_player_tracking)




def main():
    app = QtWidgets.QApplication(sys.argv)
    MainWindow = QtWidgets.QMainWindow()
    ui = Battleship()
    ui.setupUi(MainWindow)
    # ui.update_board()
    MainWindow.show()
    sys.exit(app.exec_())

    # # Запуск игры
    # run = list(prolog.query("run"))
    #
    # # Игрок начинает первым
    # move = 1
    #
    # show_player = list(prolog.query("show_player"))
    #
    # # Вывод информации о текущем состоянии полей
    # player_tracking = list(prolog.query("board(player_tracking, PlayerTracking)"))
    # player_primary = list(prolog.query("board(player_primary, PlayerBoard)"))
    #
    # player_turn = list(prolog.query("player_turn"))
    #
    # # Получаем значение матриц
    # # print(player_tracking[0]["PlayerTracking"]) # Поле противника
    # # print(player_primary[0]["PlayerBoard"]) # Поле игрока
    #
    # while (True):
    #
    #     turn = list(prolog.query("turn(player)"))  # Получаем ход игрока
    #     hit = list(prolog.query("hit_attempt(hit)"))  # Получаем попадание
    #     # Проверка, что ход игрока
    #     if len(turn) > 0 or move == 1:
    #         move = 0
    #         print("Ход игрока")
    #
    #         # Показываем ход
    #         show_player = list(prolog.query("show_player"))
    #
    #         # Показываем сообщение
    #         show_message = list(prolog.query("message(Mes),write(Mes)"))
    #
    #         print(show_message[0]["Mes"].decode("UTF-8"))
    #
    #         # Удаляем ход игрока
    #         delete_turn = list(prolog.query("retract(turn(player))"))
    #
    #         # Проверка что игрок попал
    #         if (len(hit) > 0):
    #             player_turn = list(prolog.query("player_turn"))
    #         # Если игрок промазал
    #         else:
    #             computer_turn = list(prolog.query("computer_turn"))
    #
    #     # Ход компьютера
    #     else:
    #         print("Ход противника")
    #
    #         # Удаляем ход противника
    #         delete_turn = list(prolog.query("retract(turn(computer))"))
    #
    #         # Проверка что компьютер попал
    #         if (len(hit) > 0):
    #             player_turn = list(prolog.query("player_turn"))
    #
    #         # Если компьютер промазал
    #         else:
    #             computer_turn = list(prolog.query("computer_turn"))
    #
    #     # Вывод информации о текущем состоянии полей
    #     # player_tracking = list(prolog.query("board(player_tracking, PlayerTracking)"))
    #     # player_primary = list(prolog.query("board(player_primary, PlayerBoard)"))
    #
    #     # Получаем значение матриц
    #     # print(player_tracking[0]["PlayerTracking"])  # Поле противника
    #     # print(player_primary[0]["PlayerBoard"])  # Поле игрока


if __name__ == "__main__":
    main()