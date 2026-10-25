import QtQuick
import Quickshell // for SystemClock
import "../components"

Panel {

    sets: Datas.settings.clock
    implicitWidth: this.sets.width
    implicitHeight: this.sets.height

    Text {
        anchors.centerIn: parent
        text: Qt.formatDateTime(_clock.date, "hh:mm")
        color: parent.textColor
        font: parent.font
        SystemClock {
            id: _clock
            precision: SystemClock.Minutes
        }
    }
}
