/*
    Target practice
*/

#include "target.h"

Target::Target(QObject *parent) :
    QObject(parent)
{
    emit versionChanged();
}

Target::~Target()
{
}

QString Target::readVersion()
{
    return APPVERSION;
}

