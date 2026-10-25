import QtQuick
import Quickshell // for SystemClock
import "../components"

Panel {

    customX: parent.width / 2
    customY: parent.height

    implicitWidth: 300
    implicitHeight: 50

    Text {
        anchors.centerIn: parent
        text: Qt.formatDateTime(_clock.date, "hh:mm")
        color: parent.textColor
        font.family: parent.font.family
        font.pixelSize: parent.font.pixelSize
        font.bold: parent.font.bold
        SystemClock {
            id: _clock
            precision: SystemClock.Minutes
        }
    }
}
