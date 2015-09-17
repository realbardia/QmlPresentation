import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Window 2.0

ApplicationWindow {
    id: mainwindow
    title: qsTr("Qml Presentation")
    width: 1024
    height: 600
    visible: true

    property string defaultFont: "Ubuntu"
    property real globalScales: width/1024
    property variant slides: ["IntheNameOfGod.qml","PresentationLogo.qml","IntroPage.qml",
                              "WhatsQml.qml","QmlStart.qml",
                              "QmlProjectCreation.qml","Github.qml","ThankYou.qml"]
    property int currentSlide: -1

    onCurrentSlideChanged: {
        if( privates.currentSlideItem )
            privates.currentSlideItem.stop()
        if( currentSlide >= slides.length || currentSlide < 0 )
            return

        var component = Qt.createComponent(slides[currentSlide])
        var object = component.createObject(mainframe)
        object.anchors.fill = mainframe

        privates.currentSlideItem = object
        privates.currentSlideItem.start()
    }

    QtObject {
        id: privates
        property variant currentSlideItem
    }

    Timer {
        id: double_enter_timer
        interval: 400
        onTriggered: next()
    }

    Rectangle {
        id: mainframe
        anchors.fill: parent
        color: "#000000"
        focus: true

        Keys.onPressed: {
            if( event.key == Qt.Key_Return && event.modifiers == Qt.NoModifier ) {
                if( double_enter_timer.running ) {
                    previous()
                    double_enter_timer.stop()
                } else {
                    double_enter_timer.restart()
                }

                event.accepted = true
            }
            else
            if( event.key == Qt.Key_Backspace && event.modifiers == Qt.NoModifier ) {
                previous()
                event.accepted = true
            }
            else
            if( event.key == Qt.Key_Escape )
            {
                mainwindow.visibility = Window.Windowed
                event.accepted = true
            }
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.BlankCursor
            onDoubleClicked: {
                if( mainwindow.visibility == Window.FullScreen )
                    mainwindow.visibility = Window.Windowed
                else
                    mainwindow.visibility = Window.FullScreen
            }
        }
    }

    Timer {
        id: double_blocker
        interval: 400
    }

    function next() {
        if(double_blocker.running)
            return

        double_blocker.restart()
        if( privates.currentSlideItem && privates.currentSlideItem.next ) {
            var res = privates.currentSlideItem.next()
            if( res )
                return
        }
        if( currentSlide >= slides.length )
            return

        currentSlide++
    }

    function previous() {
        if(double_blocker.running)
            return

        double_blocker.restart()
        if( privates.currentSlideItem && privates.currentSlideItem.previous ) {
            var res = privates.currentSlideItem.previous()
            if( res )
                return
        }
        if( currentSlide < 0 )
            return

        currentSlide--
    }

    Component.onCompleted: {

        Qt.application.setName("Qml Presentation")
    }
}
