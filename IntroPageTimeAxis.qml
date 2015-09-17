import QtQuick 2.0

Item {
    width: 200
    height: 100

    property alias steps: list.model
    property variant names: new Array
    property int step

    property alias axisWidth: axis.width
    property real axisOpacity

    ListView {
        id: list
        interactive: false
        anchors.left: axis.left
        anchors.right: axis.right
        anchors.top: parent.top
        anchors.bottom: axis.bottom
        orientation: ListView.Horizontal
        delegate: Item {
            width: list.width*steps[index]
            height: list.height

            Rectangle {
                height: parent.height*0.5
                x: -width/2
                width: height
                radius: width/2
                anchors.verticalCenter: parent.verticalCenter
                visible: index != 0
                color: "#00000000"
                border.width: 2*globalScales
                border.color: "#ffffff"
                opacity: axisOpacity
            }

            Text {
                text: names[index]
                font.family: defaultFont
                font.pixelSize: 20*globalScales
                color: "#ffffff"
                x: step>=index? parent.width/2 - width/2 : parent.width*0.4 - width/2
                y: -parent.height
                opacity: step>=index? 1 : 0

                Behavior on opacity {
                    NumberAnimation{easing.type: Easing.OutCubic; duration: 400}
                }
                Behavior on x {
                    NumberAnimation{easing.type: Easing.OutCubic; duration: 400}
                }
            }
        }
    }

    Rectangle {
        id: axis
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 50*globalScales
        height: 4*globalScales
        radius: height/2
        opacity: axisOpacity

        Image {
            source: "files/arrow.svg"
            anchors.bottom: parent.top
            anchors.bottomMargin: 5*globalScales
            x: parent.width*0.04
            width: 30*globalScales
            height: 100*globalScales
            sourceSize: Qt.size(width*2, height*2)

            Text {
                anchors.bottom: parent.top
                anchors.horizontalCenter: parent.right
                text: qsTr("We're here")
                font.family: defaultFont
                font.pixelSize: 30*globalScales
                color: "#ffffff"
            }
        }
    }
}
