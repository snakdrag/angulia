import QtQuick
import Quickshell
import qs.angulia.theme

Item {
    id: _
    property font clockFont: (Settings.clockFont)

    property real radius: (Settings.radius)
    property color color: (Colors.surface)
    property color textColor: (Colors.on_surface)
    property int edge: (Settings.edge)
    property int float: (Settings.float)

    implicitWidth: (_text.width)
    implicitHeight: (_text.height)

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