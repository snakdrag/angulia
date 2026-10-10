import QtQuick
import Quickshell
import "../angulia"
import "../../settings"

Angulia {
    id: _

    property var clock: (Settings.clock)
    readonly property var bar: (Settings.bar)
    readonly property var fonts: (Settings.fonts)

    implicitWidth: isVertical ? bar.width: clock.width
    implicitHeight: isVertical ? clock.height: bar.height

    AnguliaDragHandler { item: _ }
    Text {
        anchors.centerIn: parent
        rotation: _.textRotation
        text: Qt.formatDateTime(_clock.date, "hh:mm")
        color: _.textColor
        font: fonts.body
        SystemClock {
            id: _clock
            precision: SystemClock.Minutes
        }
    }
}
