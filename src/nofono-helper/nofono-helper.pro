PROJECT = harbour-nofono
TARGET = nofonohelper
QT -= gui
#CONFIG += sailfishapp

target.path = /usr/share/$$PROJECT/helper

SOURCES += \
    nofono-helper.c

INSTALLS += target
