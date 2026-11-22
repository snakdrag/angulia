import QtQuick
import Quickshell
import "../components"
import "../states" as States


ClippingRectangle {
    id: _

    property int space: (parent.space || 0)
    property int iconSize: (parent.iconSize || 0)
    property color textColor: (parent.textColor || "#ffffff")
    property color cardColor: (parent.cardColor || "#888888")
    property font font: (parent.font || {family: "Inter", pixelSize: 12, bold: false, })
    readonly property ObjectModel menuData: (States.Popup.menuData)
    readonly property int contentHeight: (_list.contentHeight)

    color: "transparent"
    radius: parent.radius

    List {
        id: _list

        interactive: false
        spacing: _.space

        model: ScriptModel { values: _.menuData === null ? []: _.menuData.values }
        delegate: Item {

            required property var modelData

            implicitWidth: _.width
            implicitHeight: (
                this.modelData.isSeparator ?
                1:
                Math.max(_main.image.height, _main.textHeight) + _.space
            )

            Card {
                id: _main

                anchors.centerIn: parent
                implicitWidth: parent.width - (parent.modelData.isSeparator ? this.space: 0)
                implicitHeight: parent.height

                color: parent.modelData.isSeparator ? _.textColor: "transparent"

                myMode: false
                radius: _.radius
                space: _.space
                opacity: parent.modelData.isSeparator ? 0.5: 1

                cover.color: _.textColor
                cover.visible: !parent.modelData.isSeparator

                image.anchors.topMargin: 0
                image.anchors.bottomMargin: 0
                image.width: _.iconSize
                image.height: _.iconSize
                image.source: parent.modelData.icon || ""

                item.anchors.topMargin: 0
                item.anchors.bottomMargin: 0

                mouseArea.cursorShape: parent.modelData.isSeparator ? Qt.ArrowCursor: Qt.PointingHandCursor

                topText.font: _.font
                topText.text: parent.modelData.text
                topText.color: _.textColor
                topText.maximumLineCount: 1

                onClicked: { parent.modelData.triggered(); States.Popup.close() }
            }
        }
    }
}
