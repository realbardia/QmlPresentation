import QtQuick 2.0

SlideAbstract {
    id: ideh_logo
    width: 100
    height: 62
    opacity: 1

    Behavior on opacity {
        NumberAnimation{ easing.type: Easing.OutCubic; duration: destroy_timer.interval }
    }

    onStart: {
        back.x = 0
        txt.scale = 150
        start_timer.restart()
    }

    onStop: {
        destroy_timer.restart()
        opacity = 0
    }

    Timer {
        id: destroy_timer
        interval: 600
        onTriggered: parent.destroy()
    }

    Timer {
        id: start_timer
        interval: 200
        onTriggered: txt.scale = 1
    }

    Rectangle {
        id: back
        x: mainwindow.width
        width: parent.width
        height: parent.height
        color: "#4A004F"

        Behavior on x {
            NumberAnimation{ easing.type: Easing.OutCubic; duration: destroy_timer.interval }
        }
    }

    Text {
        id: txt
        anchors.centerIn: parent
        font.pixelSize: 40*globalScales
        color: "#ffffff"
        text: qsTr("QML (Qt Meta Language)")
        scale: 150
        opacity: 1-scale/150
        smooth: true
        Behavior on scale {
            NumberAnimation{ easing.type: Easing.OutCubic; duration: 600 }
        }
    }
}
