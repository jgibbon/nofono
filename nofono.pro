# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop on filename must be changed
#   -  filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-nofono

DEPLOYMENT_PATH = /usr/share/$${TARGET}

translations.files = translations
translations.path = $${DEPLOYMENT_PATH}

CONFIG += sailfishapp

TEMPLATE = subdirs
SUBDIRS = src/nofono-helper src

OTHER_FILES += qml/nofono.qml \
    qml/cover/CoverPage.qml \
    rpm/nofono.spec \
    translations/*.ts \
    harbour-nofono.desktop \
    qml/pages/About.qml \
    qml/pages/MainPage.qml \
    rpm/nofono.spec

INSTALLS += translations

TRANSLATIONS = translations/harbour-nofono-de.ts \
               translations/harbour-nofono-nl.ts \
               translations/harbour-nofono-sv.ts

# only include these files for translation:
lupdate_only {
    SOURCES = qml/*.qml \
              qml/pages/*.qml
}

script.files = helper/*
script.path = /usr/share/harbour-nofono/helper

icon86.files += icons/86x86/harbour-nofono.png
icon86.path = /usr/share/icons/hicolor/86x86/apps

icon108.files += icons/108x108/harbour-nofono.png
icon108.path = /usr/share/icons/hicolor/108x108/apps

icon128.files += icons/128x128/harbour-nofono.png
icon128.path = /usr/share/icons/hicolor/128x128/apps

icon256.files += icons/256x256/harbour-nofono.png
icon256.path = /usr/share/icons/hicolor/256x256/apps

INSTALLS += icon86 icon108 icon128 icon256 script

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

DISTFILES += \
    rpm/nofono.changes
