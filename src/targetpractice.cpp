/*
    Target practice
*/


#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <sailfishapp.h>
#include <QtQml>
#include <QScopedPointer>
#include <QQuickView>
#include <QQmlEngine>
#include <QGuiApplication>
#include <QQmlContext>
#include <QCoreApplication>
#include "target.h"


int main(int argc, char *argv[])
{
    qmlRegisterType<Target>("harbour.targetpractice.Target", 1, 0, "Target");

    QScopedPointer<QGuiApplication> app(SailfishApp::application(argc, argv));
    QScopedPointer<QQuickView> view(SailfishApp::createView());
    view->setSource(SailfishApp::pathTo("qml/targetpractice.qml"));
    view->show();

    return app->exec();
}

