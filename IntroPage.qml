import QtQuick 2.0

SlideAbstract {
    id: ideh_logo
    width: 100
    height: 62
    opacity: 1

    property int step: 0
    property int lastStep: 5

    Behavior on opacity {
        NumberAnimation{ easing.type: Easing.OutCubic; duration: destroy_timer.interval }
    }

    onStart: {
        back.x = 0
        txt.opacity = 1
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
        interval: 200
        onTriggered: txt.scale = 1
    }

    Rectangle {
        id: back
        x: mainwindow.width
        width: parent.width
        height: parent.height
        color: "#0074C1"

        Behavior on x {
            NumberAnimation{ easing.type: Easing.OutCubic; duration: destroy_timer.interval }
        }
    }

    Item {
        id: main_scene
        width: parent.width
        height: parent.height
        transform: Scale {
            origin.x: 50*globalScales + 0.15*taxis.axisWidth
            origin.y: height-20*globalScales
            yScale: xScale
            xScale: {
                if(step!=lastStep)
                    return 1

                return 3.6
            }
            Behavior on xScale {
                NumberAnimation{easing.type: Easing.InOutCubic; duration: 600}
            }
        }

        Item {
            id: title_scene
            width: parent.width
            height: parent.height
            transformOrigin: Item.Top
            scale: {
                if(step == 0)
                    return 1
                else
                    return 0.7
            }
            y: {
                if(step == 0)
                    return 0
                else
                    return -100*globalScales
            }

            Behavior on scale {
                NumberAnimation{easing.type: Easing.OutCubic; duration: 400}
            }
            Behavior on y {
                NumberAnimation{easing.type: Easing.OutCubic; duration: 400}
            }

            Text {
                id: txt
                anchors.centerIn: parent
                font.family: defaultFont
                font.pixelSize: 40*globalScales
                color: "#ffffff"
                text: qsTr("Presentation Intro")
                opacity: 0
                smooth: true

                Behavior on opacity {
                    NumberAnimation{ easing.type: Easing.OutCubic; duration: 600 }
                }
            }
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: qsTr("20min")
            font.family: defaultFont
            font.italic: true
            font.pixelSize: 40*globalScales
            color: "#ffffff"
            x: {
                if(step == 0)
                    return parent.width
                else
                    return parent.width - width - 20*globalScales
            }
            visible: step != 0

            Behavior on x {
                NumberAnimation{ easing.type: Easing.OutCubic; duration: 400 }
            }
        }

        IntroPageTimeAxis {
            id: taxis
            width: parent.width
            height: 80*globalScales
            anchors.bottom: parent.bottom
            transformOrigin: Item.Top
            step: ideh_logo.step-1
            steps: [0.1, 0.3, 0.5, 0.1]
            names: ["", qsTr("What is QML?"), qsTr("Advantages and Disadvantages"), qsTr("Conclusion")]
            scale: {
                if(ideh_logo.step == 0)
                    return 2
                else
                    return 1
            }
            opacity: {
                if(ideh_logo.step == 0)
                    return 0
                else
                    return 1
            }
            axisOpacity: ideh_logo.step==lastStep? 0 : 1

            Behavior on scale {
                NumberAnimation{easing.type: Easing.OutCubic; duration: 400}
            }
            Behavior on opacity {
                NumberAnimation{easing.type: Easing.OutCubic; duration: 400}
            }
            Behavior on axisOpacity {
                NumberAnimation{easing.type: Easing.InCubic; duration: 1000}
            }
        }
    }

    function next() {
        if(step >= lastStep)
            return false

        step++
        return true
    }

    function previous() {
        if(step <= 0)
            return false

        step--
        return true
    }
}
