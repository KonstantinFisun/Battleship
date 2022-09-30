from __future__ import unicode_literals

from pyswip import Prolog

prolog = Prolog()

prolog.consult("1.pl")

# Запуск игры
run = list(prolog.query("run"))

# Игрок начинает первым
move = 1

show_player = list(prolog.query("show_player"))

# Вывод информации о текущем состоянии полей
player_tracking = list(prolog.query("board(player_tracking, PlayerTracking)"))
player_primary = list(prolog.query("board(player_primary, PlayerBoard)"))

player_turn = list(prolog.query("player_turn"))

# Получаем значение матриц
# print(player_tracking[0]["PlayerTracking"]) # Поле противника
# print(player_primary[0]["PlayerBoard"]) # Поле игрока



while(True):

    turn = list(prolog.query("turn(player)")) # Получаем ход игрока
    hit = list(prolog.query("hit_attempt(hit)")) # Получаем попадание
    # Проверка, что ход игрока
    if len(turn) > 0 or move == 1:
        move = 0
        print("Ход игрока")


        # Показываем ход
        show_player = list(prolog.query("show_player"))

        # Показываем сообщение
        show_message = list(prolog.query("message(Mes),write(Mes)"))

        print(show_message[0]["Mes"].decode("UTF-8"))

        # Удаляем ход игрока
        delete_turn = list(prolog.query("retract(turn(player))"))

        # Проверка что игрок попал
        if (len(hit) > 0):
            player_turn = list(prolog.query("player_turn"))
        # Если игрок промазал
        else:
            computer_turn = list(prolog.query("computer_turn"))

    # Ход компьютера
    else:
        print("Ход противника")

        # Удаляем ход противника
        delete_turn = list(prolog.query("retract(turn(computer))"))

        # Проверка что компьютер попал
        if (len(hit) > 0):
            player_turn = list(prolog.query("player_turn"))

        # Если компьютер промазал
        else:
            computer_turn = list(prolog.query("computer_turn"))





    # Вывод информации о текущем состоянии полей
    # player_tracking = list(prolog.query("board(player_tracking, PlayerTracking)"))
    # player_primary = list(prolog.query("board(player_primary, PlayerBoard)"))

    # Получаем значение матриц
    # print(player_tracking[0]["PlayerTracking"])  # Поле противника
    # print(player_primary[0]["PlayerBoard"])  # Поле игрока




# Вызов
# c = list(prolog.query("run"))
# Основной цикл программы
# while(c):
#
#     # r = list(prolog.query(board(computer_primary,R)))
#     print("1")
#     # print(r)
#     print("2")
#
#     c = list(prolog.query(input()))

