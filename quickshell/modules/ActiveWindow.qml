import QtQuick
import Quickshell.Widgets
import "../components"
import "../states" as States

Panel {

    sets: Datas.settings.activewindow

    implicitWidth: this.sets.width
    implicitHeight: this.sets.height

    exclusiveZoneIgnore: true

    Card {
        anchors.fill: parent
        anchors.margins: this.space

        myMode: true

        cover.color: parent.textColor

        topText.font.family: parent.font.family
        topText.font.pixelSize: parent.font.pixelSize
        topText.font.bold: parent.font.bold
        topText.text: States.ActiveWindow.activeToplevel === null ? "DeskTop": States.ActiveWindow.activeToplevel.title
        topText.color: parent.textColor
        topText.wrapMode: Text.WordWrap
        topText.maximumLineCount: 1

        color: parent.cardColor
        radius: parent.radius
        space: parent.space

        visible: parent.show

        onClicked: {
            if (!States.ActiveWindowManager.open)
            {
                States.ActiveWindowManager.call(parent.x + parent.width / 2, parent.y + parent.height / 2, 300, 300);
            }
            else
            {
                States.ActiveWindowManager.close();
            }
        }
    }
}