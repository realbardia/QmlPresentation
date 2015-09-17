import QtQuick 2.0

SlideAbstract {
    id: ideh_logo
    width: 100
    height: 62

    onStart: {
        start_timer.start()
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
        onTriggered: event_loop.restart()
    }

    Timer {
        id: event_loop
        interval: 25
        repeat: true
        onTriggered: {
            count++
            obj_component.createObject(ideh_logo)
            txt.text = count + " Objects"
        }

        property int count: 0
    }

    Rectangle {
        id: back
        width: parent.width
        height: parent.height
        color: "#ffffff"
    }

    Text {
        id: txt
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 10*globalScales
        font.family: "Free Sans"
        font.pixelSize: 15*globalScales
        style: Text.Outline
        styleColor: "#ffffff"
        z: 10
    }

    Component {
        id: obj_component

        Rectangle {
            id: rect
            color: Qt.rgba(Math.random(),Math.random(),Math.random(),Math.random())
            x: Math.random()*ideh_logo.width
            y: Math.random()*ideh_logo.width
            width: Math.random()*200*globalScales
            height: Math.random()*200*globalScales
            rotation: Math.random()*360
            scale: Math.random()*20
            opacity: 0
            smooth: true

            property int duration: Math.random()+300

            Behavior on x {
                NumberAnimation{ easing.type: Easing.OutCubic; duration: rect.duration }
            }
            Behavior on y {
                NumberAnimation{ easing.type: Easing.OutCubic; duration: rect.duration }
            }
            Behavior on width {
                NumberAnimation{ easing.type: Easing.OutCubic; duration: rect.duration }
            }
            Behavior on height {
                NumberAnimation{ easing.type: Easing.OutCubic; duration: rect.duration }
            }
            Behavior on rotation {
                NumberAnimation{ easing.type: Easing.OutCubic; duration: rect.duration }
            }
            Behavior on scale {
                NumberAnimation{ easing.type: Easing.OutCubic; duration: rect.duration }
            }
            Behavior on opacity {
                NumberAnimation{ easing.type: Easing.OutCubic; duration: rect.duration }
            }

            Component.onCompleted: {
                x = Math.random()*(ideh_logo.width-width)
                y = Math.random()*(ideh_logo.height-height)
                rotation = Math.random()*360
                scale = 1
                opacity = 1
            }
        }
    }
}
