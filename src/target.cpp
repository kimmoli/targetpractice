/*
    Target practice
*/

#include "target.h"
#include <sys/ioctl.h>
#include <fcntl.h>
#include <unistd.h>

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

void Target::flash()
{
    int fd = open("/sys/kernel/debug/flash_adp1650/mode", O_WRONLY);

    if (!(fd < 0))
    {
        write (fd, "1", 1);
        close(fd);
    }
    QThread::msleep(10);

    fd = open("/sys/kernel/debug/flash_adp1650/mode", O_WRONLY);

    if (!(fd < 0))
    {
        write (fd, "0", 1);
        close(fd);
    }
}
