/*
    Target practice
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.targetpractice.Target 1.0

ApplicationWindow
{
    id: targetpractice

    initialPage: Qt.resolvedUrl("pages/TargetPage.qml")
    cover: Qt.resolvedUrl("cover/CoverPage.qml")

    Target
    {
        id: target
    }
}


