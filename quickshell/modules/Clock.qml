import QtQuick
import Quickshell // for SystemClock
import "../components"

Panel {

    implicitWidth: this.sets.width
    implicitHeight: this.sets.height

    exclusiveZoneIgnore: true
    sets: Datas.settings.clock

    Text {

        anchors.centerIn: parent

        color: parent.textColor

        font: parent.font
        text: Qt.formatDateTime(_clock.date, "hh:mm")

        SystemClock { id: _clock; precision: SystemClock.Minutes }
    }
}
