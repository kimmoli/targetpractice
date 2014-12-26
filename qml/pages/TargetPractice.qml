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

//    Sensors.Accelerometer
//    {
//        id: accel
//        dataRate: 100
//        active: applicationActive && page.status === PageStatus.Active

//        onReadingChanged:
//        {
//            roll = calcRoll(accel.reading.x, accel.reading.y, accel.reading.z)
//            pitch = calcPitch(accel.reading.x, accel.reading.y, accel.reading.z)

//            var newX = targetImage.x + pitch * -0.125
//            if (newX > 0 && newX < page.width-targetImage.width)
//                targetImage.x = newX
//        }
//    }


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

        contentHeight: page.height

        Label
        {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            text: roll.toFixed(2) + " " + pitch.toFixed(2)
            z:2
        }

        Media.VideoOutput
        {
            id: videoPreview
            source: camera
            width: page.height
            anchors.centerIn: parent
            rotation: -90
            z: 1
        }

        Image
        {
            id: grinch
            source: "../images/grinch.png"
            x: 10
            y: 10
            z: 2
        }

        Rectangle
        {
            id: maskImage
            width: 1400
            height: 1400
            color: "transparent"
            Rectangle
            {
                anchors.centerIn: parent
                width: 200
                height: width
                radius: width/2
                color: "white"
            }
        }

        ShaderEffect
        {
            id: shader

            anchors.centerIn: parent
            height: maskImage.height
            width: maskImage.width
            rotation: -90
            z: 3

            property variant videoSource: ShaderEffectSource { sourceItem: videoPreview; hideSource: false }
            property variant mask: ShaderEffectSource { sourceItem: maskImage; hideSource: true }

            smooth: false /* afaik this sets GL_NEAREST  (true sets GL_LINEAR) */

            fragmentShader:
                "
                varying highp vec2 qt_TexCoord0;

                uniform sampler2D videoSource;
                uniform sampler2D mask;

                void main()
                {
                    // gl_FragColor =  texture2D(videoSource, qt_TexCoord0);
                    gl_FragColor = texture2D(videoSource, qt_TexCoord0.st) * (texture2D(mask, qt_TexCoord0.st).a);
                }
                "
        }


    }
    Media.Camera
    {
        id: camera
        flash.mode: Media.Camera.FlashOff
        captureMode: Media.Camera.CaptureStillImage
        focus.focusMode: Media.Camera.FocusContinuous
        onError:
        {
            console.error("error: " + camera.errorString);
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
                    target.flash()
                }
                else
                {
                    sight.source = "../images/sight-white.png"
                    misses++
                }
            }
        }
    }

//    Image
//    {
//        id: targetImage
//        source: "../images/grinch.png"
//        x: randomNumber(0, page.width - targetImage.width)
//        y: page.height/2 - targetImage.height/2
//        scale: 1
//    }

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
