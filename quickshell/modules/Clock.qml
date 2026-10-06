import QtQuick
import Quickshell
import "../custom" as Custom

Custom.Rectangle {
    id: _

    property int clcokWidth: (Custom.Data.settings.clcokWidth)
    property int clcokHeight: (Custom.Data.settings.clcokHeight)
    property font clockFont: (Custom.Data.settings.clockFont)

    implicitWidth: clcokWidth
    implicitHeight: clcokHeight
    Text {
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
