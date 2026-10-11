import QtQuick
import Quickshell // for SystemClock
import "../angulia"
import "../../settings"

Angulia {
    id: _

    _data: Settings.clock

    implicitWidth: isVertical ? bar.width: _data.width
    implicitHeight: isVertical ? _data.height: bar.height

    Text {
        anchors.centerIn: parent
        text: Qt.formatDateTime(_clock.date, "hh:mm")
        color: _.textColor
        font: _._data.font
        SystemClock {
            id: _clock
            precision: SystemClock.Minutes
        }
    }
}
