import QtQuick 2.0
import Sailfish.Silica 1.0
import QtSensors 5.0 as Sensors

Page 
{
    id: page

    property real roll: 0.0
    property real pitch: 0.0

    Sensors.Accelerometer
    {
        id: accel
        dataRate: 100
        active: applicationActive && page.status === PageStatus.Active

        onReadingChanged:
        {
            roll = calcRoll(accel.reading.x, accel.reading.y, accel.reading.z)
            pitch = calcPitch(accel.reading.x, accel.reading.y, accel.reading.z)

            var newX = target.x + roll * 0.1
            if (newX > 0 && newX < page.width-target.width)
                target.x = newX
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
            
            Slider
            {
                width: parent.width - 2*Theme.paddingLarge
                anchors.horizontalCenter: parent.horizontalCenter
                label: ""
                minimumValue: 0
                maximumValue: 180
                value: roll + 90.0
                valueText: roll.toFixed(2)
            }
            Slider
            {
                width: parent.width - 2*Theme.paddingLarge
                anchors.horizontalCenter: parent.horizontalCenter
                label: ""
                minimumValue: 0
                maximumValue: 180
                value: pitch + 90.0
                valueText: pitch.toFixed(2)
            }
        }
    }
    Image
    {
        id: sight
        source: "../images/sight-white.png"

        x: page.width/2 - sight.width/2
        y: page.height/2 - sight.height/2

        MouseArea
        {
            anchors.fill: parent
            onPressed: sight.source = "../images/sight-red.png"
            onReleased: sight.source = "../images/sight-white.png"
        }
    }

    Image
    {
        id: target
        source: "../images/grinch.png"
        x: randomNumber(0, page.width - target.width)
        y: randomNumber(0, page.height - target.height)
        scale: 1
    }

}
