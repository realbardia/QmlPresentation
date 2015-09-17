import QtQuick 2.0

SlideAbstract {
    id: ideh_logo
    width: 100
    height: 62

    onStart: {
        back.x = 0
        point.height = parent.width*2 * 1.2
        start_timer.restart()
    }

    onStop: {
        destroy_timer.restart()
    }

    Timer {
        id: destroy_timer
        interval: 600
        onTriggered: parent.destroy()
    }

    Timer {
        id: start_timer
        interval: 599
        onTriggered: back.visible = true
    }

    Rectangle {
        id: back
        width: parent.width
        height: parent.height
        color: "#814FDD"
        visible: false
    }

    Rectangle {
        id: point
        x: 100*globalScales - width/2
        y: 100*globalScales - height/2
        width: height
        height: 0
        radius: width/2
        color: back.color
        scale: 1
        transformOrigin: Item.TopLeft

        Behavior on height {
            NumberAnimation{ easing.type: Easing.OutCubic; duration: destroy_timer.interval }
        }
    }

    Column {
        anchors.centerIn: parent
        spacing: 10*globalScales

        Text {
            font.family: "Free Sans"
            font.pixelSize: 20*globalScales
            color: "#bbffffff"
            text: qsTr("Email:")
            smooth: true
        }

        Text {
            font.family: "Free Sans"
            font.pixelSize: 18*globalScales
            color: "#ffffff"
            text: qsTr("bardia.daneshvar@gmail.com")
            smooth: true
        }

        Item {
            width: 5
            height: 20*globalScales
        }

        Text {
            font.family: "Free Sans"
            font.pixelSize: 20*globalScales
            color: "#bbffffff"
            text: qsTr("Github:")
            smooth: true
        }

        Text {
            font.family: "Free Sans"
            font.pixelSize: 18*globalScales
            color: "#ffffff"
            text: qsTr("http://github.com/realbardia")
            smooth: true
        }

        Text {
            font.family: "Free Sans"
            font.pixelSize: 18*globalScales
            color: "#ffffff"
            text: qsTr("https://github.com/Aseman-Land")
            smooth: true
        }
    }
}
