TEMPLATE = app

TARGET = harbour-nofono
CONFIG += sailfishapp

#QT += declarative

SOURCES += nofono.cpp \
    settings.cpp \
    osread.cpp

HEADERS += \
    settings.h \
    osread.h

CONFIG(release, debug|release) {
    DEFINES += QT_NO_DEBUG_OUTPUT
}

OTHER_FILES +=

