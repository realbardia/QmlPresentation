import QtQuick 2.0

Rectangle {
    id: dtxt
    width: 100
    height: 62

    property alias text: txt.text
    property alias font: txt.font
    property color textColor: "#333333"

    onTextChanged: text_switch_timer.restart()

    QtObject {
        id: privates
        property variant objects: new Array
    }

    Timer {
        id: text_switch_timer
        interval: 100
        repeat: false
        onTriggered: refresh()
    }

    Text {
        id: txt
        anchors.centerIn: parent
        color: parent.color
    }

    Timer {
        id: refresh_timer
        interval: 50
        onTriggered: {
            var objects = new Array
            for( var j=0; j<privates.objects.length; j++ )
                objects[j] = privates.objects[j]


            if( pointer < text.length ) {
                var object = char_component.createObject(dtxt)
                object.x = lastX
                object.text = text[pointer]
                lastX += object.width
                restart()

                objects[pointer] = object
            }

            pointer++
            privates.objects = objects
        }

        property int pointer: 0
        property real lastX: 0
    }

    Timer {
        id: refresh_delay_timer
        interval: 800
        onTriggered: refresh_timer.restart()
    }

    function refresh() {
        for( var j=0; j<privates.objects.length; j++ )
            privates.objects[j].finish()

        privates.objects = new Array
        refresh_timer.lastX = txt.x
        refresh_timer.pointer = 0
        if( privates.objects.length != 0 )
            refresh_delay_timer.restart()
        else
            refresh_timer.restart()
    }

    Component {
        id: char_component

        Item {
            width: char_txt.width + dtxt.font.wordSpacing
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            property alias text: char_txt.text
            property bool down: false

            Text {
                id: char_txt
                x: dtxt.font.wordSpacing/2
                y: down? parent.height - height : parent.height/2 - height/2
                font: dtxt.font
                color: dtxt.textColor
                smooth: true
                scale: 20
                opacity: 1-(scale-1)/19
                transformOrigin: Item.Center
                rotation: 0

                property real yduration: Math.random()*400 + 200
                property real xduration: Math.random()*500 + 1000
                property real rduration: Math.random()*2000

                Behavior on scale {
                    NumberAnimation{ easing.type: Easing.OutCubic; duration: 400 }
                }
                Behavior on y {
                    NumberAnimation{ easing.type: Easing.OutBounce; duration: char_txt.yduration }
                }
                Behavior on x {
                    NumberAnimation{ easing.type: Easing.OutSine; duration: char_txt.xduration }
                }
                Behavior on rotation {
                    NumberAnimation{ easing.type: Easing.OutQuad; duration: char_txt.xduration }
                }

                Component.onCompleted: scale = 1
            }

            Timer {
                id: down_timer
                repeat: false
                onTriggered: {
                    down = true
                    char_txt.rotation = Math.random()*180 - 90
                    x_ch_timer.restart()
                }
            }

            Timer {
                id: x_ch_timer
                interval: char_txt.yduration - 100
                onTriggered: {
                    var newX = Math.random()*500*globalScales - 250*globalScales
                    char_txt.rduration = char_txt.xduration
                    char_txt.x = newX
                    char_txt.rotation = newX>0? Math.random()*2000 : -Math.random()*2000
                }
            }

            function finish() {
                down_timer.interval = Math.floor(Math.random()*500)
                down_timer.restart()
            }
        }
    }

    Component.onCompleted: refresh()
}
