from PyQt5.QtWidgets import *
from PyQt5.QtCore import *
from PyQt5 import QtCore, QtGui, QtWidgets
import sys

class Manually(QWidget):
    # Конструктор
    def __init__(self):
        super(Manually, self).__init__()
        self.setObjectName("Manually")
        self.resize(640, 500)
        self.setStyleSheet("background-color: rgb(64, 65, 66);")
        self.p91 = QtWidgets.QPushButton(self)
        self.p91.setGeometry(QtCore.QRect(120, 350, 30, 30))
        self.p91.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p91.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p91.setText("")
        self.p91.setObjectName("p91")
        self.p01 = QtWidgets.QPushButton(self)
        self.p01.setGeometry(QtCore.QRect(120, 80, 30, 30))
        self.p01.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p01.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p01.setText("")
        self.p01.setObjectName("p01")
        self.p92 = QtWidgets.QPushButton(self)
        self.p92.setGeometry(QtCore.QRect(150, 350, 30, 30))
        self.p92.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p92.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p92.setText("")
        self.p92.setObjectName("p92")
        self.p95 = QtWidgets.QPushButton(self)
        self.p95.setGeometry(QtCore.QRect(240, 350, 30, 30))
        self.p95.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p95.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p95.setText("")
        self.p95.setObjectName("p95")
        self.p85 = QtWidgets.QPushButton(self)
        self.p85.setGeometry(QtCore.QRect(240, 320, 30, 30))
        self.p85.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p85.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p85.setText("")
        self.p85.setObjectName("p85")
        self.p57 = QtWidgets.QPushButton(self)
        self.p57.setGeometry(QtCore.QRect(300, 230, 30, 30))
        self.p57.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p57.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p57.setText("")
        self.p57.setObjectName("p57")
        self.p00 = QtWidgets.QPushButton(self)
        self.p00.setGeometry(QtCore.QRect(90, 80, 30, 30))
        self.p00.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p00.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p00.setText("")
        self.p00.setObjectName("p00")
        self.p23 = QtWidgets.QPushButton(self)
        self.p23.setGeometry(QtCore.QRect(180, 140, 30, 30))
        self.p23.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p23.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p23.setText("")
        self.p23.setObjectName("p23")
        self.p38 = QtWidgets.QPushButton(self)
        self.p38.setGeometry(QtCore.QRect(330, 170, 30, 30))
        self.p38.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p38.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p38.setText("")
        self.p38.setObjectName("p38")
        self.p84 = QtWidgets.QPushButton(self)
        self.p84.setGeometry(QtCore.QRect(210, 320, 30, 30))
        self.p84.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p84.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p84.setText("")
        self.p84.setObjectName("p84")
        self.p16 = QtWidgets.QPushButton(self)
        self.p16.setGeometry(QtCore.QRect(270, 110, 30, 30))
        self.p16.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p16.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p16.setText("")
        self.p16.setObjectName("p16")
        self.p63 = QtWidgets.QPushButton(self)
        self.p63.setGeometry(QtCore.QRect(180, 260, 30, 30))
        self.p63.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p63.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p63.setText("")
        self.p63.setObjectName("p63")
        self.p47 = QtWidgets.QPushButton(self)
        self.p47.setGeometry(QtCore.QRect(300, 200, 30, 30))
        self.p47.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p47.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p47.setText("")
        self.p47.setObjectName("p47")
        self.p97 = QtWidgets.QPushButton(self)
        self.p97.setGeometry(QtCore.QRect(300, 350, 30, 30))
        self.p97.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p97.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p97.setText("")
        self.p97.setObjectName("p97")
        self.p72 = QtWidgets.QPushButton(self)
        self.p72.setGeometry(QtCore.QRect(150, 290, 30, 30))
        self.p72.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p72.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p72.setText("")
        self.p72.setObjectName("p72")
        self.p76 = QtWidgets.QPushButton(self)
        self.p76.setGeometry(QtCore.QRect(270, 290, 30, 30))
        self.p76.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p76.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p76.setText("")
        self.p76.setObjectName("p76")
        self.p26 = QtWidgets.QPushButton(self)
        self.p26.setGeometry(QtCore.QRect(270, 140, 30, 30))
        self.p26.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p26.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p26.setText("")
        self.p26.setObjectName("p26")
        self.p60 = QtWidgets.QPushButton(self)
        self.p60.setGeometry(QtCore.QRect(90, 260, 30, 30))
        self.p60.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p60.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p60.setText("")
        self.p60.setObjectName("p60")
        self.p49 = QtWidgets.QPushButton(self)
        self.p49.setGeometry(QtCore.QRect(360, 200, 30, 30))
        self.p49.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p49.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p49.setText("")
        self.p49.setObjectName("p49")
        self.p79 = QtWidgets.QPushButton(self)
        self.p79.setGeometry(QtCore.QRect(360, 290, 30, 30))
        self.p79.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p79.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p79.setText("")
        self.p79.setObjectName("p79")
        self.p09 = QtWidgets.QPushButton(self)
        self.p09.setGeometry(QtCore.QRect(360, 80, 30, 30))
        self.p09.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p09.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p09.setText("")
        self.p09.setObjectName("p09")
        self.p48 = QtWidgets.QPushButton(self)
        self.p48.setGeometry(QtCore.QRect(330, 200, 30, 30))
        self.p48.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p48.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p48.setText("")
        self.p48.setObjectName("p48")
        self.p42 = QtWidgets.QPushButton(self)
        self.p42.setGeometry(QtCore.QRect(150, 200, 30, 30))
        self.p42.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p42.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p42.setText("")
        self.p42.setObjectName("p42")
        self.p28 = QtWidgets.QPushButton(self)
        self.p28.setGeometry(QtCore.QRect(330, 140, 30, 30))
        self.p28.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p28.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p28.setText("")
        self.p28.setObjectName("p28")
        self.p18 = QtWidgets.QPushButton(self)
        self.p18.setGeometry(QtCore.QRect(330, 110, 30, 30))
        self.p18.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p18.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p18.setText("")
        self.p18.setObjectName("p18")
        self.p07 = QtWidgets.QPushButton(self)
        self.p07.setGeometry(QtCore.QRect(300, 80, 30, 30))
        self.p07.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p07.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p07.setText("")
        self.p07.setObjectName("p07")
        self.p22 = QtWidgets.QPushButton(self)
        self.p22.setGeometry(QtCore.QRect(150, 140, 30, 30))
        self.p22.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p22.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p22.setText("")
        self.p22.setObjectName("p22")
        self.p46 = QtWidgets.QPushButton(self)
        self.p46.setGeometry(QtCore.QRect(270, 200, 30, 30))
        self.p46.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p46.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p46.setText("")
        self.p46.setObjectName("p46")
        self.p68 = QtWidgets.QPushButton(self)
        self.p68.setGeometry(QtCore.QRect(330, 260, 30, 30))
        self.p68.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p68.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p68.setText("")
        self.p68.setObjectName("p68")
        self.p03 = QtWidgets.QPushButton(self)
        self.p03.setGeometry(QtCore.QRect(180, 80, 30, 30))
        self.p03.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p03.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p03.setText("")
        self.p03.setObjectName("p03")
        self.p15 = QtWidgets.QPushButton(self)
        self.p15.setGeometry(QtCore.QRect(240, 110, 30, 30))
        self.p15.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p15.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p15.setText("")
        self.p15.setObjectName("p15")
        self.p10 = QtWidgets.QPushButton(self)
        self.p10.setGeometry(QtCore.QRect(90, 110, 30, 30))
        self.p10.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p10.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p10.setText("")
        self.p10.setObjectName("p10")
        self.p93 = QtWidgets.QPushButton(self)
        self.p93.setGeometry(QtCore.QRect(180, 350, 30, 30))
        self.p93.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p93.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p93.setText("")
        self.p93.setObjectName("p93")
        self.p62 = QtWidgets.QPushButton(self)
        self.p62.setGeometry(QtCore.QRect(150, 260, 30, 30))
        self.p62.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p62.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p62.setText("")
        self.p62.setObjectName("p62")
        self.p75 = QtWidgets.QPushButton(self)
        self.p75.setGeometry(QtCore.QRect(240, 290, 30, 30))
        self.p75.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p75.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p75.setText("")
        self.p75.setObjectName("p75")
        self.p25 = QtWidgets.QPushButton(self)
        self.p25.setGeometry(QtCore.QRect(240, 140, 30, 30))
        self.p25.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p25.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p25.setText("")
        self.p25.setObjectName("p25")
        self.p20 = QtWidgets.QPushButton(self)
        self.p20.setGeometry(QtCore.QRect(90, 140, 30, 30))
        self.p20.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p20.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p20.setText("")
        self.p20.setObjectName("p20")
        self.p24 = QtWidgets.QPushButton(self)
        self.p24.setGeometry(QtCore.QRect(210, 140, 30, 30))
        self.p24.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p24.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p24.setText("")
        self.p24.setObjectName("p24")
        self.p08 = QtWidgets.QPushButton(self)
        self.p08.setGeometry(QtCore.QRect(330, 80, 30, 30))
        self.p08.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p08.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p08.setText("")
        self.p08.setObjectName("p08")
        self.p12 = QtWidgets.QPushButton(self)
        self.p12.setGeometry(QtCore.QRect(150, 110, 30, 30))
        self.p12.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p12.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p12.setText("")
        self.p12.setObjectName("p12")
        self.p94 = QtWidgets.QPushButton(self)
        self.p94.setGeometry(QtCore.QRect(210, 350, 30, 30))
        self.p94.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p94.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p94.setText("")
        self.p94.setObjectName("p94")
        self.p58 = QtWidgets.QPushButton(self)
        self.p58.setGeometry(QtCore.QRect(330, 230, 30, 30))
        self.p58.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p58.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p58.setText("")
        self.p58.setObjectName("p58")
        self.p37 = QtWidgets.QPushButton(self)
        self.p37.setGeometry(QtCore.QRect(300, 170, 30, 30))
        self.p37.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p37.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p37.setText("")
        self.p37.setObjectName("p37")
        self.p55 = QtWidgets.QPushButton(self)
        self.p55.setGeometry(QtCore.QRect(240, 230, 30, 30))
        self.p55.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p55.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p55.setText("")
        self.p55.setObjectName("p55")
        self.p41 = QtWidgets.QPushButton(self)
        self.p41.setGeometry(QtCore.QRect(120, 200, 30, 30))
        self.p41.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p41.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p41.setText("")
        self.p41.setObjectName("p41")
        self.p90 = QtWidgets.QPushButton(self)
        self.p90.setGeometry(QtCore.QRect(90, 350, 30, 30))
        self.p90.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p90.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p90.setText("")
        self.p90.setObjectName("p90")
        self.p05 = QtWidgets.QPushButton(self)
        self.p05.setGeometry(QtCore.QRect(240, 80, 30, 30))
        self.p05.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p05.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p05.setText("")
        self.p05.setObjectName("p05")
        self.p52 = QtWidgets.QPushButton(self)
        self.p52.setGeometry(QtCore.QRect(150, 230, 30, 30))
        self.p52.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p52.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p52.setText("")
        self.p52.setObjectName("p52")
        self.p74 = QtWidgets.QPushButton(self)
        self.p74.setGeometry(QtCore.QRect(210, 290, 30, 30))
        self.p74.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p74.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p74.setText("")
        self.p74.setObjectName("p74")
        self.p83 = QtWidgets.QPushButton(self)
        self.p83.setGeometry(QtCore.QRect(180, 320, 30, 30))
        self.p83.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p83.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p83.setText("")
        self.p83.setObjectName("p83")
        self.p69 = QtWidgets.QPushButton(self)
        self.p69.setGeometry(QtCore.QRect(360, 260, 30, 30))
        self.p69.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p69.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p69.setText("")
        self.p69.setObjectName("p69")
        self.p98 = QtWidgets.QPushButton(self)
        self.p98.setGeometry(QtCore.QRect(330, 350, 30, 30))
        self.p98.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p98.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p98.setText("")
        self.p98.setObjectName("p98")
        self.p89 = QtWidgets.QPushButton(self)
        self.p89.setGeometry(QtCore.QRect(360, 320, 30, 30))
        self.p89.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p89.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p89.setText("")
        self.p89.setObjectName("p89")
        self.p61 = QtWidgets.QPushButton(self)
        self.p61.setGeometry(QtCore.QRect(120, 260, 30, 30))
        self.p61.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p61.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p61.setText("")
        self.p61.setObjectName("p61")
        self.p59 = QtWidgets.QPushButton(self)
        self.p59.setGeometry(QtCore.QRect(360, 230, 30, 30))
        self.p59.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p59.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p59.setText("")
        self.p59.setObjectName("p59")
        self.p80 = QtWidgets.QPushButton(self)
        self.p80.setGeometry(QtCore.QRect(90, 320, 30, 30))
        self.p80.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p80.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p80.setText("")
        self.p80.setObjectName("p80")
        self.p36 = QtWidgets.QPushButton(self)
        self.p36.setGeometry(QtCore.QRect(270, 170, 30, 30))
        self.p36.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p36.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p36.setText("")
        self.p36.setObjectName("p36")
        self.p30 = QtWidgets.QPushButton(self)
        self.p30.setGeometry(QtCore.QRect(90, 170, 30, 30))
        self.p30.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p30.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p30.setText("")
        self.p30.setObjectName("p30")
        self.p32 = QtWidgets.QPushButton(self)
        self.p32.setGeometry(QtCore.QRect(150, 170, 30, 30))
        self.p32.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p32.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p32.setText("")
        self.p32.setObjectName("p32")
        self.p33 = QtWidgets.QPushButton(self)
        self.p33.setGeometry(QtCore.QRect(180, 170, 30, 30))
        self.p33.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p33.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p33.setText("")
        self.p33.setObjectName("p33")
        self.p40 = QtWidgets.QPushButton(self)
        self.p40.setGeometry(QtCore.QRect(90, 200, 30, 30))
        self.p40.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p40.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p40.setText("")
        self.p40.setObjectName("p40")
        self.p71 = QtWidgets.QPushButton(self)
        self.p71.setGeometry(QtCore.QRect(120, 290, 30, 30))
        self.p71.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p71.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p71.setText("")
        self.p71.setObjectName("p71")
        self.p87 = QtWidgets.QPushButton(self)
        self.p87.setGeometry(QtCore.QRect(300, 320, 30, 30))
        self.p87.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p87.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p87.setText("")
        self.p87.setObjectName("p87")
        self.p64 = QtWidgets.QPushButton(self)
        self.p64.setGeometry(QtCore.QRect(210, 260, 30, 30))
        self.p64.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p64.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p64.setText("")
        self.p64.setObjectName("p64")
        self.p34 = QtWidgets.QPushButton(self)
        self.p34.setGeometry(QtCore.QRect(210, 170, 30, 30))
        self.p34.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p34.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p34.setText("")
        self.p34.setObjectName("p34")
        self.p11 = QtWidgets.QPushButton(self)
        self.p11.setGeometry(QtCore.QRect(120, 110, 30, 30))
        self.p11.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p11.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p11.setText("")
        self.p11.setObjectName("p11")
        self.p96 = QtWidgets.QPushButton(self)
        self.p96.setGeometry(QtCore.QRect(270, 350, 30, 30))
        self.p96.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p96.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p96.setText("")
        self.p96.setObjectName("p96")
        self.p19 = QtWidgets.QPushButton(self)
        self.p19.setGeometry(QtCore.QRect(360, 110, 30, 30))
        self.p19.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p19.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p19.setText("")
        self.p19.setObjectName("p19")
        self.p81 = QtWidgets.QPushButton(self)
        self.p81.setGeometry(QtCore.QRect(120, 320, 30, 30))
        self.p81.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p81.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p81.setText("")
        self.p81.setObjectName("p81")
        self.p73 = QtWidgets.QPushButton(self)
        self.p73.setGeometry(QtCore.QRect(180, 290, 30, 30))
        self.p73.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p73.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p73.setText("")
        self.p73.setObjectName("p73")
        self.p27 = QtWidgets.QPushButton(self)
        self.p27.setGeometry(QtCore.QRect(300, 140, 30, 30))
        self.p27.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p27.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p27.setText("")
        self.p27.setObjectName("p27")
        self.p78 = QtWidgets.QPushButton(self)
        self.p78.setGeometry(QtCore.QRect(330, 290, 30, 30))
        self.p78.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p78.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p78.setText("")
        self.p78.setObjectName("p78")
        self.p13 = QtWidgets.QPushButton(self)
        self.p13.setGeometry(QtCore.QRect(180, 110, 30, 30))
        self.p13.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p13.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p13.setText("")
        self.p13.setObjectName("p13")
        self.p66 = QtWidgets.QPushButton(self)
        self.p66.setGeometry(QtCore.QRect(270, 260, 30, 30))
        self.p66.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p66.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p66.setText("")
        self.p66.setObjectName("p66")
        self.p04 = QtWidgets.QPushButton(self)
        self.p04.setGeometry(QtCore.QRect(210, 80, 30, 30))
        self.p04.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p04.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p04.setText("")
        self.p04.setObjectName("p04")
        self.p39 = QtWidgets.QPushButton(self)
        self.p39.setGeometry(QtCore.QRect(360, 170, 30, 30))
        self.p39.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p39.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p39.setText("")
        self.p39.setObjectName("p39")
        self.p70 = QtWidgets.QPushButton(self)
        self.p70.setGeometry(QtCore.QRect(90, 290, 30, 30))
        self.p70.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p70.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p70.setText("")
        self.p70.setObjectName("p70")
        self.p51 = QtWidgets.QPushButton(self)
        self.p51.setGeometry(QtCore.QRect(120, 230, 30, 30))
        self.p51.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p51.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p51.setText("")
        self.p51.setObjectName("p51")
        self.p29 = QtWidgets.QPushButton(self)
        self.p29.setGeometry(QtCore.QRect(360, 140, 30, 30))
        self.p29.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p29.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p29.setText("")
        self.p29.setObjectName("p29")
        self.p54 = QtWidgets.QPushButton(self)
        self.p54.setGeometry(QtCore.QRect(210, 230, 30, 30))
        self.p54.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p54.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p54.setText("")
        self.p54.setObjectName("p54")
        self.p06 = QtWidgets.QPushButton(self)
        self.p06.setGeometry(QtCore.QRect(270, 80, 30, 30))
        self.p06.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p06.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p06.setText("")
        self.p06.setObjectName("p06")
        self.p56 = QtWidgets.QPushButton(self)
        self.p56.setGeometry(QtCore.QRect(270, 230, 30, 30))
        self.p56.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p56.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p56.setText("")
        self.p56.setObjectName("p56")
        self.p02 = QtWidgets.QPushButton(self)
        self.p02.setGeometry(QtCore.QRect(150, 80, 30, 30))
        self.p02.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p02.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p02.setText("")
        self.p02.setObjectName("p02")
        self.p45 = QtWidgets.QPushButton(self)
        self.p45.setGeometry(QtCore.QRect(240, 200, 30, 30))
        self.p45.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p45.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p45.setText("")
        self.p45.setObjectName("p45")
        self.p77 = QtWidgets.QPushButton(self)
        self.p77.setGeometry(QtCore.QRect(300, 290, 30, 30))
        self.p77.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p77.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p77.setText("")
        self.p77.setObjectName("p77")
        self.p82 = QtWidgets.QPushButton(self)
        self.p82.setGeometry(QtCore.QRect(150, 320, 30, 30))
        self.p82.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p82.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p82.setText("")
        self.p82.setObjectName("p82")
        self.p14 = QtWidgets.QPushButton(self)
        self.p14.setGeometry(QtCore.QRect(210, 110, 30, 30))
        self.p14.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p14.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p14.setText("")
        self.p14.setObjectName("p14")
        self.p50 = QtWidgets.QPushButton(self)
        self.p50.setGeometry(QtCore.QRect(90, 230, 30, 30))
        self.p50.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p50.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p50.setText("")
        self.p50.setObjectName("p50")
        self.p31 = QtWidgets.QPushButton(self)
        self.p31.setGeometry(QtCore.QRect(120, 170, 30, 30))
        self.p31.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p31.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p31.setText("")
        self.p31.setObjectName("p31")
        self.p67 = QtWidgets.QPushButton(self)
        self.p67.setGeometry(QtCore.QRect(300, 260, 30, 30))
        self.p67.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p67.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p67.setText("")
        self.p67.setObjectName("p67")
        self.p88 = QtWidgets.QPushButton(self)
        self.p88.setGeometry(QtCore.QRect(330, 320, 30, 30))
        self.p88.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p88.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p88.setText("")
        self.p88.setObjectName("p88")
        self.p43 = QtWidgets.QPushButton(self)
        self.p43.setGeometry(QtCore.QRect(180, 200, 30, 30))
        self.p43.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p43.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p43.setText("")
        self.p43.setObjectName("p43")
        self.p65 = QtWidgets.QPushButton(self)
        self.p65.setGeometry(QtCore.QRect(240, 260, 30, 30))
        self.p65.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p65.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p65.setText("")
        self.p65.setObjectName("p65")
        self.p99 = QtWidgets.QPushButton(self)
        self.p99.setGeometry(QtCore.QRect(360, 350, 30, 30))
        self.p99.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p99.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p99.setText("")
        self.p99.setObjectName("p99")
        self.p17 = QtWidgets.QPushButton(self)
        self.p17.setGeometry(QtCore.QRect(300, 110, 30, 30))
        self.p17.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p17.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p17.setText("")
        self.p17.setObjectName("p17")
        self.p53 = QtWidgets.QPushButton(self)
        self.p53.setGeometry(QtCore.QRect(180, 230, 30, 30))
        self.p53.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p53.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p53.setText("")
        self.p53.setObjectName("p53")
        self.p44 = QtWidgets.QPushButton(self)
        self.p44.setGeometry(QtCore.QRect(210, 200, 30, 30))
        self.p44.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p44.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p44.setText("")
        self.p44.setObjectName("p44")
        self.p21 = QtWidgets.QPushButton(self)
        self.p21.setGeometry(QtCore.QRect(120, 140, 30, 30))
        self.p21.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p21.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p21.setText("")
        self.p21.setObjectName("p21")
        self.p86 = QtWidgets.QPushButton(self)
        self.p86.setGeometry(QtCore.QRect(270, 320, 30, 30))
        self.p86.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p86.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p86.setText("")
        self.p86.setObjectName("p86")
        self.p35 = QtWidgets.QPushButton(self)
        self.p35.setGeometry(QtCore.QRect(240, 170, 30, 30))
        self.p35.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.p35.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                               "border: 1px solid black;")
        self.p35.setText("")
        self.p35.setObjectName("p35")
        self.title_game = QtWidgets.QLabel(self)
        self.title_game.setGeometry(QtCore.QRect(10, 20, 621, 41))
        font = QtGui.QFont()
        font.setFamily("Segoe UI Semibold")
        font.setPointSize(23)
        font.setBold(True)
        self.title_game.setFont(font)
        self.title_game.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.title_game.setStyleSheet("color: rgb(255, 255, 255);")
        self.title_game.setAlignment(QtCore.Qt.AlignCenter)
        self.title_game.setObjectName("title_game")
        self.but1_1 = QtWidgets.QPushButton(self)
        self.but1_1.setGeometry(QtCore.QRect(500, 110, 30, 30))
        self.but1_1.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.but1_1.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                                  "border: 4px solid blue;")
        self.but1_1.setText("")
        self.but1_1.setObjectName("but1_1")
        self.title_game_2 = QtWidgets.QLabel(self)
        self.title_game_2.setGeometry(QtCore.QRect(430, 100, 60, 40))
        font = QtGui.QFont()
        font.setFamily("Segoe UI Semibold")
        font.setPointSize(23)
        font.setBold(True)
        self.title_game_2.setFont(font)
        self.title_game_2.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.title_game_2.setStyleSheet("color: rgb(255, 255, 255);")
        self.title_game_2.setAlignment(QtCore.Qt.AlignCenter)
        self.title_game_2.setObjectName("title_game_2")
        self.but2_1 = QtWidgets.QPushButton(self)
        self.but2_1.setGeometry(QtCore.QRect(500, 180, 30, 30))
        self.but2_1.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.but2_1.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                                  "border-top: 4px solid blue;\n"
                                  "border-left: 4px solid blue;\n"
                                  "border-bottom: 4px solid blue;")
        self.but2_1.setText("")
        self.but2_1.setObjectName("but2_1")
        self.title_game_3 = QtWidgets.QLabel(self)
        self.title_game_3.setGeometry(QtCore.QRect(430, 170, 60, 40))
        font = QtGui.QFont()
        font.setFamily("Segoe UI Semibold")
        font.setPointSize(23)
        font.setBold(True)
        self.title_game_3.setFont(font)
        self.title_game_3.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.title_game_3.setStyleSheet("color: rgb(255, 255, 255);")
        self.title_game_3.setAlignment(QtCore.Qt.AlignCenter)
        self.title_game_3.setObjectName("title_game_3")
        self.but2_2 = QtWidgets.QPushButton(self)
        self.but2_2.setGeometry(QtCore.QRect(530, 180, 30, 30))
        self.but2_2.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.but2_2.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                                  "border-top: 4px solid blue;\n"
                                  "border-right: 4px solid blue;\n"
                                  "border-bottom: 4px solid blue;")
        self.but2_2.setText("")
        self.but2_2.setObjectName("but2_2")
        self.but3_1 = QtWidgets.QPushButton(self)
        self.but3_1.setGeometry(QtCore.QRect(500, 250, 30, 30))
        self.but3_1.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.but3_1.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                                  "border-top: 4px solid blue;\n"
                                  "border-left: 4px solid blue;\n"
                                  "border-bottom: 4px solid blue;")
        self.but3_1.setText("")
        self.but3_1.setObjectName("but3_1")
        self.title_game_4 = QtWidgets.QLabel(self)
        self.title_game_4.setGeometry(QtCore.QRect(430, 240, 60, 40))
        font = QtGui.QFont()
        font.setFamily("Segoe UI Semibold")
        font.setPointSize(23)
        font.setBold(True)
        self.title_game_4.setFont(font)
        self.title_game_4.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.title_game_4.setStyleSheet("color: rgb(255, 255, 255);")
        self.title_game_4.setAlignment(QtCore.Qt.AlignCenter)
        self.title_game_4.setObjectName("title_game_4")
        self.but3_2 = QtWidgets.QPushButton(self)
        self.but3_2.setGeometry(QtCore.QRect(530, 250, 30, 30))
        self.but3_2.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.but3_2.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                                  "border-top: 4px solid blue;\n"
                                  "border-bottom: 4px solid blue;")
        self.but3_2.setText("")
        self.but3_2.setObjectName("but3_2")
        self.but3_3 = QtWidgets.QPushButton(self)
        self.but3_3.setGeometry(QtCore.QRect(560, 250, 30, 30))
        self.but3_3.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.but3_3.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                                  "border-top: 4px solid blue;\n"
                                  "border-right: 4px solid blue;\n"
                                  "border-bottom: 4px solid blue;")
        self.but3_3.setText("")
        self.but3_3.setObjectName("but3_3")
        self.but4_2 = QtWidgets.QPushButton(self)
        self.but4_2.setGeometry(QtCore.QRect(530, 320, 30, 30))
        self.but4_2.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.but4_2.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                                  "border-top: 4px solid blue;\n"
                                  "border-bottom: 4px solid blue;")
        self.but4_2.setText("")
        self.but4_2.setObjectName("but4_2")
        self.title_game_5 = QtWidgets.QLabel(self)
        self.title_game_5.setGeometry(QtCore.QRect(430, 310, 60, 40))
        font = QtGui.QFont()
        font.setFamily("Segoe UI Semibold")
        font.setPointSize(23)
        font.setBold(True)
        self.title_game_5.setFont(font)
        self.title_game_5.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.title_game_5.setStyleSheet("color: rgb(255, 255, 255);")
        self.title_game_5.setAlignment(QtCore.Qt.AlignCenter)
        self.title_game_5.setObjectName("title_game_5")
        self.but4_1 = QtWidgets.QPushButton(self)
        self.but4_1.setGeometry(QtCore.QRect(500, 320, 30, 30))
        self.but4_1.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.but4_1.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                                  "border-top: 4px solid blue;\n"
                                  "border-left: 4px solid blue;\n"
                                  "border-bottom: 4px solid blue;")
        self.but4_1.setText("")
        self.but4_1.setObjectName("but4_1")
        self.but4_3 = QtWidgets.QPushButton(self)
        self.but4_3.setGeometry(QtCore.QRect(560, 320, 30, 30))
        self.but4_3.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.but4_3.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                                  "border-top: 4px solid blue;\n"
                                  "border-bottom: 4px solid blue;")
        self.but4_3.setText("")
        self.but4_3.setObjectName("but4_3")
        self.but4_4 = QtWidgets.QPushButton(self)
        self.but4_4.setGeometry(QtCore.QRect(590, 320, 30, 30))
        self.but4_4.setCursor(QtGui.QCursor(QtCore.Qt.ArrowCursor))
        self.but4_4.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                                  "border-top: 4px solid blue;\n"
                                  "border-right: 4px solid blue;\n"
                                  "border-bottom: 4px solid blue;")
        self.but4_4.setText("")
        self.but4_4.setObjectName("but4_4")
        self.Clear = QtWidgets.QPushButton(self)
        self.Clear.setGeometry(QtCore.QRect(245, 420, 150, 50))
        font = QtGui.QFont()
        font.setFamily("Segoe UI Semibold")
        font.setPointSize(12)
        font.setBold(True)
        self.Clear.setFont(font)
        self.Clear.setCursor(QtGui.QCursor(QtCore.Qt.PointingHandCursor))
        self.Clear.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                                 "border: 2px solid black;")
        self.Clear.setObjectName("Clear")
        self.Cancel = QtWidgets.QPushButton(self)
        self.Cancel.setGeometry(QtCore.QRect(75, 420, 150, 50))
        font = QtGui.QFont()
        font.setFamily("Segoe UI Semibold")
        font.setPointSize(12)
        font.setBold(True)
        self.Cancel.setFont(font)
        self.Cancel.setCursor(QtGui.QCursor(QtCore.Qt.PointingHandCursor))
        self.Cancel.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                                  "border: 2px solid black;")
        self.Cancel.setObjectName("Cancel")
        self.Start_3 = QtWidgets.QPushButton(self)
        self.Start_3.setGeometry(QtCore.QRect(415, 420, 150, 50))
        font = QtGui.QFont()
        font.setFamily("Segoe UI Semibold")
        font.setPointSize(12)
        font.setBold(True)
        self.Start_3.setFont(font)
        self.Start_3.setCursor(QtGui.QCursor(QtCore.Qt.PointingHandCursor))
        self.Start_3.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                                   "border: 2px solid black;")
        self.Start_3.setObjectName("Start_3")

        self.retranslateUi()
        QtCore.QMetaObject.connectSlotsByName(self)

        # Создаем списки с объектами
        self.board = list()

        # Получаем ссылки на поля игрока
        for a in dir(self):
            if a.startswith('p') and len(a) == 3 and a!="pos":
                self.board.append(getattr(self, a))

        # Добавляем каждому элементу кросс курсор
        for a in self.board:
            a.setCursor(QtGui.QCursor(QtCore.Qt.CrossCursor))

        # Возвращаемое поле
        self.board_returned = [0]*100

        # Добавляем функционал
        # self.add_functions()

    # Обработчик событий
    def add_functions(self):
        # Кнопка 'Очистить'
        self.Clear.clicked.connect(self.clear)

        # Кнопка 'Отмена'
        self.Cancel.clicked.connect(self.cancel)

        # Кнопки для расстановки кораблей
        for but in self.board:
            but.clicked.connect(self.click)

    # Кнопка очистки поля
    def clear(self):
        self.clear_board()

    # Кнопка отмены
    def cancel(self):
        self.clear_board()
        # Прячем окно
        self.hide()

    # Кнопки поля
    def click(self):
        btn = self.sender() # Откуда пришел сигнал

        i = self.board.index(btn)  # Получаем индекс кнопки

        # Проверяем, что в эту клетку ещё не ставили
        if(self.board_returned[i] == 0):
            btn.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                                                           "border: 4px solid blue;")
            self.board_returned[i] = 1
        else:
            btn.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                                 "border: 1px solid black;")
            self.board_returned[i] = 0

    def update(self):
        for i in range(100):
            if(self.board_returned[i] == 1):
                self.board[i].setStyleSheet("background-color: rgb(255, 255, 255);\n"
                                                           "border: 4px solid blue;")
            if (self.board_returned[i] == 4):
                self.board_returned[i] = 0

    # Очистка поля
    def clear_board(self):
        # Очитска содержимого полей
        for but in self.board:
            but.setStyleSheet("background-color: rgb(255, 255, 255);\n"
                                 "border: 1px solid black;")

        # Очистка массива клеток
        for elem in range(100):
            self.board_returned[elem] = 0

    # Возвращает поле
    def get_board(self):
        return self.board_returned

    def retranslateUi(self):
            _translate = QtCore.QCoreApplication.translate
            self.setWindowTitle(_translate("Manually", "Расстановка кораблей"))
            self.title_game.setText(_translate("Manually", "Расстановка кораблей"))
            self.title_game_2.setText(_translate("Manually", "4 - "))
            self.title_game_3.setText(_translate("Manually", "3 - "))
            self.title_game_4.setText(_translate("Manually", "2 - "))
            self.title_game_5.setText(_translate("Manually", "1 - "))
            self.Clear.setText(_translate("Manually", "Очистить"))
            self.Cancel.setText(_translate("Manually", "Отмена"))
            self.Start_3.setText(_translate("Manually", "Применить"))