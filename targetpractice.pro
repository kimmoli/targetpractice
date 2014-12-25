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
    qml/images/grinch.png


