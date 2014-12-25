#
# Project target practice
#

TARGET = harbour-targetpractice

CONFIG += sailfishapp

DEFINES += "APPVERSION=\\\"$${SPECVERSION}\\\""

message($${DEFINES})

SOURCES += src/targetpractice.cpp \
	src/target.cpp
	
HEADERS += src/target.h

OTHER_FILES += qml/targetpractice.qml \
    qml/cover/CoverPage.qml \
    qml/pages/targetpractice.qml \
    rpm/targetpractice.spec \
    harbour-targetpractice.desktop \
    harbour-targetpractice.png


