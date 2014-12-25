import QtQuick 2.0
import Sailfish.Silica 1.0
import QtSensors 5.0 as Sensors
import QtMultimedia 5.0 as Media

Page 
{
    id: page
    allowedOrientations: Orientation.Landscape

    property real roll: 0.0
    property real pitch: 0.0

    property var weapons: ["rifle", "shotgun", "raygun"]
    property int currentWeapon: 0

    property int hits: 0
    property int misses: 0

    Sensors.Accelerometer
    {
        id: accel
        dataRate: 100
        active: applicationActive && page.status === PageStatus.Active

        onReadingChanged:
        {
            roll = calcRoll(accel.reading.x, accel.reading.y, accel.reading.z)
            pitch = calcPitch(accel.reading.x, accel.reading.y, accel.reading.z)

            var newX = target.x + pitch * -0.125
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
            MenuItem
            {
                text: "Change weapon to " + weapons[(currentWeapon+1) % weapons.length]
                onClicked: currentWeapon = (currentWeapon+1) % weapons.length
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
            
            Label
            {
                anchors.horizontalCenter: parent.horizontalCenter
                text: roll.toFixed(2) + " " + pitch.toFixed(2)
            }
        }
    }
    Image
    {
        id: sight
        source: "../images/sight-white.png"

        x: page.width/2 - sight.width/2
        y: page.height/2 - sight.height/2
        z: 100

        MouseArea
        {
            anchors.fill: parent
            onPressedChanged:
            {
                if (pressed)
                {
                    sight.source = "../images/sight-red.png"
                    weaponSound.play()
                }
                else
                {
                    sight.source = "../images/sight-white.png"
                    misses++
                }
            }
        }
    }

    Image
    {
        id: target
        source: "../images/grinch.png"
        x: randomNumber(0, page.width - target.width)
        y: page.height/2 - target.height/2
        scale: 1

    }

    Media.SoundEffect
    {
        id: cheer
        source: "../sounds/cheer.wav"
    }

    Media.SoundEffect
    {
        id: weaponSound
        source: "../sounds/" + weapons[currentWeapon] + ".wav"
    }

    Media.SoundEffect
    {
        id: toke
        source: "../sounds/toke.wav"
    }

    Timer
    {
        running: applicationActive && page.status === PageStatus.Active
        repeat: true
        interval: randomNumber(10000, 60000)
        onTriggered:
        {
            interval = randomNumber(10000, 60000)
            cheer.play()
        }
    }

    onMissesChanged:
    {
        if (misses === 10)
        {
            toke.play()
            misses = 0
        }
    }
}
