import sys
from PyQt5.QtWidgets import *

app = QApplication(sys.argv)
label = QLabel("안녕하세요, PyQt")
label.show()

app.exec_()
