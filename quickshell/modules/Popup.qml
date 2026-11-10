import QtQuick
import Quickshell
import "../components"
import "../states" as States

Panel {
    id: _

    readonly property ObjectModel menuData: (States.Popup.menuData)

    customX: States.Popup.customX
    customY: States.Popup.customY
    implicitWidth: this.cardWidth + this.space * 2
    implicitHeight: _list.contentHeight + this.space * 2

    exclusiveZoneIgnore: false
    sets: Datas.settings.popup
    show: States.Popup.open

    onMenuDataChanged: this.countWidth()

    TextMetrics { id: _textMetrics; font: _.font }
    ClippingRectangle {

        anchors.fill: parent
        anchors.margins: parent.space

        color: parent.backgroundColor
        radius: parent.radius

        List {
            id: _list

            interactive: false

            model: ScriptModel { values: _.menuData === null ? []: _.menuData.values }
            delegate: Item {

                required property var modelData

                implicitWidth: _.cardWidth
                implicitHeight: (
                    this.modelData.isSeparator ?
                    _.space:
                    Math.max(_main.image.height, _main.textHeight) + _.space * 2
                )

                Card {
                    id: _main

                    anchors.fill: parent

                    color: parent.modelData.isSeparator ? "transparent": _.cardColor

                    myMode: false
                    space: _.space

                    cover.color: _.textColor
                    cover.visible: !parent.modelData.isSeparator

                    image.anchors.topMargin: 0
                    image.anchors.bottomMargin: 0
                    image.width: _.iconSize
                    image.height: _.iconSize
                    image.source: parent.modelData.icon

                    mouseArea.cursorShape: parent.modelData.isSeparator ? Qt.ArrowCursor: Qt.PointingHandCursor

                    topText.font.family: _.font.family
                    topText.font.pixelSize: _.font.pixelSize
                    topText.font.bold: _.font.bold
                    topText.text: parent.modelData.text
                    topText.color: _.textColor
                    topText.maximumLineCount: 1

                    onClicked: { parent.modelData.triggered(); States.Popup.close() }
                }
            }
        }
    }

    function countWidth()
    {
        this.cardWidth = 0
        for (let i = 0; i < this.menuData.values.length; ++i)
        {
            let modelData = this.menuData.values[i];
            if (!modelData) continue
            if (modelData.isSeparator) continue
            let w = this.space * 3;
            if (modelData.text)
            {
                _textMetrics.text = modelData.text
                w += _textMetrics.width
            }
            if (modelData.icon && modelData.icon !== "") w += this.iconSize + this.space
            if (w > this.cardWidth) this.cardWidth = w;
        }
    }
}
