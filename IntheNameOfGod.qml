import QtQuick 2.0
import "Bubbles"

SlideAbstract {
    id: inthe_name
    width: 100
    height: 62
    opacity: 0

    Behavior on opacity {
        NumberAnimation{ easing.type: Easing.OutCubic; duration: destroy_timer.interval }
    }

    onStart: {
        opacity = 1
        start_timer.restart()
    }

    onStop: {
        destroy_timer.restart()
        back.x = -width
        txt.opacity = 0
    }

    Timer {
        id: destroy_timer
        interval: 600
        onTriggered: parent.destroy()
    }

    Timer {
        id: start_timer
        interval: 1000
        onTriggered: txt.scale = 1
    }

    Rectangle {
        id: back
        width: parent.width
        height: parent.height
        color: "#ffffff"

        Behavior on x {
            NumberAnimation{ easing.type: Easing.OutCubic; duration: destroy_timer.interval }
        }

        Bubbles {
            anchors.fill: parent
            Component.onCompleted: start()
        }
    }

    Text {
        id: txt
        anchors.centerIn: parent
        font.family: defaultFont
        font.pixelSize: 50*globalScales
        color: "#000033"
        text: qsTr("IN THE NAME OF GOD")
        smooth: true

        Behavior on opacity {
            NumberAnimation{ easing.type: Easing.OutCubic; duration: destroy_timer.interval }
        }
    }
}
