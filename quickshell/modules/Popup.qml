import QtQuick
import Quickshell
import Quickshell.Widgets
import "../components"
import "../states"

Panel {
    id: _

    sets: Datas.settings.popup

    customX: Popup.customX
    customY: Popup.customY

    implicitWidth: this.cardWidth + this.space * 2
    implicitHeight: _list.contentHeight + this.space * 2

    exclusiveZoneIgnore: false

    readonly property ObjectModel menuData: (Popup.menuData)
    onMenuDataChanged: countWidth()

    TextMetrics {
        id: _textMetrics
        font: _.font
    }

    function countWidth()
    {
        this.cardWidth = 0
        for (let i = 0; i < this.menuData.values.length; ++i) {
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
    show: Popup.open

    ClippingRectangle {
        anchors.fill: parent
        anchors.margins: parent.space
        color: parent.backgroundColor
        radius: parent.radius
        visible: parent.show
        List {
            id: _list
            interactive: false
            model: ScriptModel { values: _.menuData === null ? []: _.menuData.values }
            delegate: Item {
                required property var modelData
                implicitWidth: _.cardWidth
                implicitHeight: this.modelData.isSeparator ? _.space: _main.height
                Card {
                    id: _main
                    implicitWidth: _.cardWidth
                    implicitHeight: Math.max(this.image.height, this.textHeight) + this.space * 2
                    color: parent.modelData.isSeparator ? "transparent": _.cardColor
                    cover.color: _.textColor
                    cover.visible: !parent.modelData.isSeparator
                    myMode: false
                    space: _.space

                    image.anchors.topMargin: 0
                    image.anchors.bottomMargin: 0
                    image.width: _.iconSize
                    image.height: _.iconSize
                    image.source: parent.modelData.icon

                    topText.font.family: _.font.family
                    topText.font.pixelSize: _.font.pixelSize
                    topText.font.bold: _.font.bold
                    topText.text: parent.modelData.text
                    topText.color: _.textColor
                    topText.maximumLineCount: 1

                    mouseArea.cursorShape: parent.modelData.isSeparator ? Qt.ArrowCursor: Qt.PointingHandCursor
                    onClicked: {parent.modelData.triggered(); Popup.close()}
                }
            }
        }
    }
}
