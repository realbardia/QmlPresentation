import QtQuick 2.0
import QtGraphicalEffects 1.0

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

    property variant goodTexts: ["Qml is simple, easy and understandable",
                             "C++ backend",
                             "Qml supports JavaScript v4",
                             "Perfect documents",
                             "Great performance because of OpenGL",
                             "Full of the modules",
                             "Free and OpenSource",
                             "You can build and test it on your desktop.",
                             "Multi platform"]
    property variant goodImages: ["Easy",
                                  "C++",
                                  "JavaScript",
                                  "Documents",
                                  "Performance",
                                  "Modules",
                                  "Free",
                                  "Desktop",
                                  "Multi-Platform"]

    property variant badTexts: ["It's incomplete",
                                "Poor load time on the old android devices.",
                                "Size of the final packages.",
                                "JavaScript problems like debug problems."]
    property variant badImages: ["Incomplete",
                                 "Load-Time",
                                 "Size",
                                 "Debug"]

    property variant qmlModules: ["Qt3D", "AudioEngine", "Bluetooth", "Location", "Multimedia",
                                  "Nfc", "Positioning", "QtQuick", "Particles", "Controls",
                                  "LocalStorage", "XmlListModel", "Models", "Sensors", "Test",
                                  "Webkit", "WebSockets"]

    property int current: -1

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
        id: point
        x: 100*globalScales - width/2
        y: 100*globalScales - height/2
        width: height
        height: 0
        radius: width/2
        color: "#eeeeee"
        scale: 1
        transformOrigin: Item.TopLeft

        Behavior on height {
            NumberAnimation{ easing.type: Easing.OutCubic; duration: destroy_timer.interval }
        }
    }

    DynamicText {
        id: back
        anchors.fill: parent
        color: "#eeeeee"
        font.family: "Free Sans"
        font.pixelSize: 25*globalScales
        textColor: "#333333"
        smooth: true
        visible: false
    }

    Column {
        id: left_column
        anchors.left: parent.left
        y: parent.height/2 - height/2
        spacing: 10*globalScales

        Behavior on y {
            NumberAnimation {easing.type: Easing.OutCubic; duration: 400}
        }
    }

    Column {
        id: right_column
        anchors.right: parent.right
        y: parent.height/2 - height/2
        spacing: 10*globalScales

        Behavior on y {
            NumberAnimation {easing.type: Easing.OutCubic; duration: 400}
        }
    }

    Component {
        id: ticked_text_component

        Item {
            width: 10*globalScales
            height: td_txt.height

            property alias text: td_txt.text
            property bool rightItem: false

            Text {
                id: td_txt
                x: parent.rightItem? parent.width : -width
                font.family: "Free Sans"
                font.pixelSize: 17*globalScales
                color: parent.rightItem? "#9D1F1F" : "#4966B6"
                opacity: 0

                Behavior on x {
                    NumberAnimation {easing.type: Easing.OutCubic; duration: 400}
                }
                Behavior on opacity {
                    NumberAnimation {easing.type: Easing.OutCubic; duration: 400}
                }
            }

            Component.onCompleted: {
                td_txt.x = (rightItem? -td_txt.width : width)
                td_txt.opacity = 1
            }
        }
    }

    function next() {

        current++
        if(current > badTexts.length+goodTexts.length )
            return false
        if(back.text.length != 0) {
            var idx = current-1
            var text
            if(idx<goodImages.length) {
                text = goodImages[idx]
                ticked_text_component.createObject(left_column, {"text": text})
            } else {
                text = badImages[idx-goodImages.length]
                ticked_text_component.createObject(right_column, {"text": text, "rightItem": true})
            }
        }
        if( current == badTexts.length+goodTexts.length ) {
            back.text = ""
            current++
            return true
        }

        back.text = (current<goodTexts.length? goodTexts[current] : badTexts[current-goodTexts.length])
        return true
    }

    function previous() {
        current--
        if( current < -1 )
            return false
        if( current == -1 ) {
            back.text = ""
            current--
            return true
        }

        back.text = (current<goodTexts.length? goodTexts[current] : badTexts[current-goodTexts.length])
        return true
    }
}
