import QtQuick 2.0
import QtGraphicalEffects 1.0

SlideAbstract {
    id: ideh_logo
    width: 100
    height: 62

    onStart: {
        point.height = parent.width*2 * 1.2
        start_timer.restart()
    }

    onStop: {
        destroy_timer.restart()
    }

    property bool qtAnswerStep: false
    property bool qquickAnswerStep: false

    Timer {
        id: destroy_timer
        interval: 600
        onTriggered: parent.destroy()
    }

    Timer {
        id: start_timer
        interval: 599
        onTriggered: back.color = "#ffffff"
    }

    Rectangle {
        id: point
        x: 100*globalScales - width/2
        y: 100*globalScales - height/2
        width: height
        height: 0
        radius: width/2
        color: "#ffffff"
        scale: 1
        transformOrigin: Item.TopLeft

        Behavior on height {
            NumberAnimation{ easing.type: Easing.OutCubic; duration: destroy_timer.interval }
        }
    }

    Rectangle {
        id: back
        anchors.fill: parent
        color: "#00000000"

        Row {
            y: collab_feature.y/2 - height/2
            x: parent.width/2 - width*0.8

            Timer {
                interval: 1500
                onTriggered: {
                    wi_txt.opacity = 0.6
                    txt_qs.opacity = 0.6
                }
                Component.onCompleted: start()
            }

            Text {
                id: wi_txt
                font.family: "Free Sans"
                font.pixelSize: 33*globalScales
                color: "#333333"
                text: qsTr("What is ")
                smooth: true
                opacity: 0
                Behavior on opacity {
                    NumberAnimation{easing.type: Easing.OutCubic; duration: 1600}
                }
            }

            Text {
                id: txt
                font.family: "Free Sans"
                font.pixelSize: 33*globalScales
                color: "#333333"
                text: qsTr("Qt")
                smooth: true
            }

            Text {
                id: txt_qs
                font.family: "Free Sans"
                font.pixelSize: 33*globalScales
                color: "#333333"
                text: qsTr("?")
                smooth: true
                opacity: 0
                Behavior on opacity {
                    NumberAnimation{easing.type: Easing.OutCubic; duration: 1600}
                }
            }
        }

        Text {
            y: collab_feature.y/2 - height/2
            x: parent.width - width - 10*globalScales
            font.family: "Free Sans"
            font.pixelSize: 20*globalScales
            color: "#333333"
            text: qsTr("1991")
        }

        Row {
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: 60*globalScales
            spacing: 40*globalScales

            Text {
                font.family: "Free Sans"
                font.pixelSize: 20*globalScales
                color: "#333333"
                text: qsTr("C++")
                opacity: qtAnswerStep? 1 : 0

                Behavior on opacity {
                    NumberAnimation{easing.type: Easing.OutCubic; duration: 400}
                }
            }

            Text {
                font.family: "Free Sans"
                font.pixelSize: 20*globalScales
                color: "#333333"
                text: qsTr("Multi-Platform")
                opacity: qtAnswerStep? 1 : 0

                Behavior on opacity {
                    NumberAnimation{easing.type: Easing.OutCubic; duration: 400}
                }
            }

            Text {
                font.family: "Free Sans"
                font.pixelSize: 20*globalScales
                color: "#333333"
                text: qsTr("Modules")
                opacity: qtAnswerStep? 1 : 0

                Behavior on opacity {
                    NumberAnimation{easing.type: Easing.OutCubic; duration: 400}
                }
            }

            Text {
                font.family: "Free Sans"
                font.pixelSize: 20*globalScales
                color: "#333333"
                text: qsTr("LGPL")
                opacity: qtAnswerStep? 1 : 0

                Behavior on opacity {
                    NumberAnimation{easing.type: Easing.OutCubic; duration: 400}
                }
            }
        }

        Rectangle {
            id: collab_feature
            width: parent.width
            height: 0
            anchors.bottom: parent.bottom
            color: "#554488"

            Text {
                id: collab_txt
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.margins: 20*globalScales
                font.family: "Free Sans"
                font.pixelSize: 30*globalScales
                color: "#ffffff"
                text: qsTr("QtQuick Project")
                smooth: true
            }

            Text {
                anchors.top: parent.top
                anchors.margins: 25*globalScales
                x: parent.width - width - 10*globalScales
                font.family: "Free Sans"
                font.pixelSize: 20*globalScales
                color: "#ffffff"
                text: qsTr("2010")
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 40*globalScales
                font.family: "Free Sans"
                font.pixelSize: 20*globalScales
                lineHeight: 1.5
                color: "#ffffff"
                text: qsTr("- Started by Nokia\n" + "- Highly dynamic UserInterface\n" +
                           "- Mobile and Touch devices\n")
                opacity: qquickAnswerStep? 1 : 0

                Behavior on opacity {
                    NumberAnimation{easing.type: Easing.OutCubic; duration: 400}
                }
            }


            Behavior on height {
                NumberAnimation{ easing.type: Easing.OutCubic; duration: 600 }
            }
        }

        Rectangle {
            id: git_feature
            width: parent.width
            height: 0
            anchors.bottom: parent.bottom
            color: "#3EC043"
            clip: true

            Text {
                id: git_txt
                width: parent.width
                anchors.verticalCenter: parent.verticalCenter
                font.family: "Free Sans"
                font.pixelSize: 100*globalScales
                horizontalAlignment: Text.AlignHCenter
                color: "#ffffff"
                text: qsTr("QML")
                smooth: true
            }

            Text {
                id: git_but_txt
                width: parent.width
                anchors.top: git_txt.bottom
                font.family: "Free Sans"
                font.pixelSize: 20*globalScales
                horizontalAlignment: Text.AlignHCenter
                color: "#ffffff"
                text: qsTr("A Java-Script based, declarative language for designing user-interface.")
                smooth: true
                scale: git_txt.scale
                opacity: 0
                Behavior on opacity {
                    NumberAnimation{ easing.type: Easing.OutCubic; duration: 600 }
                }
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                x: parent.width - width - 10*globalScales
                font.family: "Free Sans"
                font.pixelSize: 20*globalScales
                color: "#ffffff"
                text: qsTr("2010")
            }

            Behavior on height {
                NumberAnimation{ easing.type: Easing.OutCubic; duration: 600 }
            }
            Behavior on color {
                ColorAnimation{ easing.type: Easing.OutCubic; duration: 600 }
            }
        }
    }

    function next() {
        if(!qtAnswerStep) {
            qtAnswerStep = true
            return true
        }
        if( collab_feature.height == 0 ) {
            collab_feature.height = height-80*globalScales
            wi_txt.opacity = 0
            txt_qs.opacity = 0
            return true
        }
        if(!qquickAnswerStep) {
            qquickAnswerStep = true
            return true
        }
        if( git_feature.height == 0 ) {
            collab_feature.height = height
            git_feature.height = height-80*globalScales
            return true
        }
        if( git_but_txt.opacity == 0 ) {
            git_but_txt.opacity = 1
            return true
        }

        return false
    }

    function previous() {
        if( git_but_txt.opacity != 0 ) {
            git_but_txt.opacity = 0
            return true
        }
        if( git_feature.height != 0 ) {
            collab_feature.height = height-80*globalScales
            git_feature.height = 0
            return true
        }
        if(qquickAnswerStep) {
            qquickAnswerStep = false
            return true
        }
        if( collab_feature.height != 0 ) {
            collab_feature.height = 0
            return true
        }
        if(qtAnswerStep) {
            qtAnswerStep = false
            return true
        }

        return false
    }
}
