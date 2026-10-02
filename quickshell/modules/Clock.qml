import QtQuick
import Quickshell
import "../custom" as Custom

Custom.Rectangle {
    id: _

    implicitWidth: clcokWidth
    implicitHeight: clcokHeight
    Text {
        id: _text
        anchors.centerIn: parent
        text: Qt.formatDateTime(_clock.date, "hh:mm")
        color: _.textColor
        font: _.clockFont
        SystemClock {
            id: _clock
            precision: SystemClock.Minutes
        }
    }
}
