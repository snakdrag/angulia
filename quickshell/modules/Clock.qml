import QtQuick
import Quickshell // for SystemClock
import "../components"

Panel {

    anchors.margins: 5
    customX: parent.width / 2
    customY: parent.height

    implicitWidth: 300
    implicitHeight: 50

    radius: 12

    property color textColor: ("#ffffff")
    property font font: ({
        family: "Inter",
        pixelSize: 15
    })

    Text {
        anchors.centerIn: parent
        text: Qt.formatDateTime(_clock.date, "hh:mm")
        color: parent.textColor
        font.family: parent.font.family
        font.pixelSize: parent.font.pixelSize
        SystemClock {
            id: _clock
            precision: SystemClock.Minutes
        }
    }
}
