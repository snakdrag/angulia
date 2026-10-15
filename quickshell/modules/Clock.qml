import QtQuick
import Quickshell // for SystemClock
import "../angulia"
import "../../settings"

Angulia {
    id: _

    _data: Settings.clock

    implicitWidth: this.isVertical ? this.bar.width: this._data.width
    implicitHeight: this.isVertical ? this._data.height: this.bar.height

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
