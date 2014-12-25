#
# Project target practice
#

TARGET = harbour-targetpractice

CONFIG += sailfishapp

DEFINES += "APPVERSION=\\\"$${SPECVERSION}\\\""

message($${DEFINES})

SOURCES += src/target.cpp \
    src/targetpractice.cpp
	
HEADERS += src/target.h

OTHER_FILES += qml/targetpractice.qml \
    qml/cover/CoverPage.qml \
    rpm/targetpractice.spec \
    harbour-targetpractice.desktop \
    harbour-targetpractice.png \
    qml/pages/TargetPractice.qml \
    qml/images/sight-white.png \
    qml/images/sight-red.png \
    qml/images/grinch.png \
    qml/sounds/rifle.mp3 \
    qml/sounds/sotgun.mp3 \
    qml/sounds/raygun.mp3 \
    qml/sounds/toke.mp3 \
    qml/sounds/cheer.wav \
    qml/sounds/toke.wav \
    qml/sounds/raygun.wav \
    qml/sounds/rifle.wav \
    qml/sounds/shotgun.wav


