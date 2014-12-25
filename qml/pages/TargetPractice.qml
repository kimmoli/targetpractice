import QtQuick 2.0
import Sailfish.Silica 1.0
import QtSensors 5.0 as Sensors

Page 
{
    id: page

    Sensors.Accelerometer
    {
        id: accel
        dataRate: 100
        active: applicationActive && page.status === PageStatus.Active

        onReadingChanged:
        {
            var newX = (thisflake.x + calcRoll(accel.reading.x, accel.reading.y, accel.reading.z) * thisflake.sz/overdrive + (randomNumber(0,350)-175)/overdrive)
            var newY = (thisflake.y - calcPitch(accel.reading.x, accel.reading.y, accel.reading.z) * thisflake.sz/overdrive + (randomNumber(0,350)-175)/overdrive)
        }
    }


    function randomNumber(from, to)
    {
       return Math.floor(Math.random() * (to - from + 1) + from);
    }

    function calcPitch(x,y,z)
    {
        return -(Math.atan(y / Math.sqrt(x * x + z * z)) * 57.2957795);
    }

    function calcRoll(x,y,z)
    {
         return -(Math.atan(x / Math.sqrt(y * y + z * z)) * 57.2957795);
    }
    
    SilicaFlickable
    {
        anchors.fill: parent

        PullDownMenu
        {
            MenuItem
            {
                text: "About..."
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"),
                                          { "version": target.version,
                                              "year": "2014",
                                              "name": "Target practice",
                                              "imagelocation": "/usr/share/icons/hicolor/86x86/apps/harbour-targetpractice.png"} )
            }
        }

        contentHeight: column.height

        Column
        {
            id: column

            width: page.width
            spacing: Theme.paddingSmall
            PageHeader
            {
                title: "Target practice"
            }
            
            
        }
    }        

}
