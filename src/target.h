/*
    Target practice
*/

#ifndef TARGET_H
#define TARGET_H
#include <QObject>

class Target : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString version READ readVersion NOTIFY versionChanged())

public:
    explicit Target(QObject *parent = 0);
    ~Target();

    QString readVersion();

signals:
    void versionChanged();

    //private:

};


#endif // TARGET_H

