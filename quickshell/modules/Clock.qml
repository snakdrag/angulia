import QtQuick
import Quickshell // for SystemClock
import "../components"

Panel {

    sets: Datas.settings.clock

    implicitWidth: this.sets.width
    implicitHeight: this.sets.height

    exclusiveZoneIgnore: true

    Card {
        anchors.fill: parent
        anchors.margins: parent.space

        myMode: true

        cover.color: parent.textColor

        topText.font: parent.font
        topText.text: Qt.formatDateTime(_clock.date, "hh:mm")
        topText.color: parent.textColor
        topText.wrapMode: Text.WordWrap
        topText.maximumLineCount: 1

        color: parent.cardColor
        radius: parent.radius

        SystemClock {
            id: _clock
            precision: SystemClock.Minutes
        }

        visible: parent.show
    }
}
