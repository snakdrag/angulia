import QtQuick
import Quickshell // for SystemClock
import "../angulia"
import "../../settings"

Angulia {
    id: _

    property var clock: (Settings.clock)
    readonly property var bar: (Settings.bar)

    implicitWidth: isVertical ? bar.width: clock.width
    implicitHeight: isVertical ? clock.height: bar.height

    customX: parent.width / 2 - implicitWidth / 2
    customY: parent.height

    Text {
        anchors.centerIn: parent
        rotation: _.textRotation
        text: Qt.formatDateTime(_clock.date, "hh:mm")
        color: _.textColor
        font: _.clock.font
        SystemClock {
            id: _clock
            precision: SystemClock.Minutes
        }
    }
}
