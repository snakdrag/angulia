import QtQuick
import Quickshell.Widgets
import "../components"
import "../states"

Panel {

    sets: Datas.settings.activewindow

    implicitWidth: this.sets.width
    implicitHeight: this.sets.height

    exclusiveZoneIgnore: true

    Card {
        anchors.fill: parent
        anchors.margins: this.space

        myMode: parent.myMode

        cover.color: parent.textColor

        topText.font.family: parent.font.family
        topText.font.pixelSize: parent.font.pixelSize
        topText.font.bold: parent.font.bold
        topText.text: ActiveWindow.activeToplevel === null ? "DeskTop": ActiveWindow.activeToplevel.title
        topText.color: parent.textColor
        topText.wrapMode: Text.WordWrap
        topText.maximumLineCount: 1

        color: parent.cardColor
        radius: parent.radius
        space: parent.space

        visible: parent.show
    }
}