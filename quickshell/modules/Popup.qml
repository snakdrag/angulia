import QtQuick
import Quickshell
import Quickshell.Widgets
import "../angulia"
import "../../settings"

Angulia {
    id: _

    _data: Settings.popup
    property ObjectModel menuData: (_menu.children)
    property QtObject menu
    exclusiveZoneIgnore: false
    implicitWidth: this.cardWidth + this.space * 2
    implicitHeight: _list.contentHeight + this.space * 2

    onMenuDataChanged: countWidth()

    QsMenuOpener {
        id: _menu
        menu: _.menu
    }

    function call(x, y, data)
    {
        this.menu = data
        this.customX = x
        this.customY = y
        this.show = true
    }
    function close()
    {
        this.show = false
    }

    TextMetrics {
        id: _textMetrics
        font: _._data.font
    }

    function countWidth()
    {
        this.cardWidth = 0
        for (let i = 0; i < this.menuData.values.length; ++i) {
            let modelData = this.menuData.values[i];
            if (!modelData) continue
            if (modelData.isSeparator) continue;
            let w = 0;
            if (modelData.text)
            {
                _textMetrics.text = modelData.text
                w += _textMetrics.width
            }
            if (modelData.icon && modelData.icon !== "")
            {
                w += _.cardHeight
            }
            w += _.space * 3
            if (w > this.cardWidth)
            {
                this.cardWidth = w;
            }
        }
    }

    show: false

    ClippingRectangle {
        anchors.fill: parent
        anchors.margins: _.space
        radius: _.radius
        color: _.cardColor
        visible: _.show
        List {
            id: _list
            isVertical: true
            displaced: null
            interactive: false
            model: ScriptModel { values: _.menuData === null ? []: _.menuData.values }
            delegate: Card {
                required property var modelData
                required property int index

                activeColor: _.textColor
                color: this.modelData.isSeparator ? _.color: _.cardColor

                implicitWidth: _.cardWidth
                implicitHeight: this.modelData.isSeparator ? this.space: _.cardHeight

                space: _.space
                radius: 0
                isVertical: true

                imageWidth: this.height - this.space
                imageHeight: this.height - this.space
                imageSource: this.modelData.icon

                topText: this.modelData.text
                topFont: _._data.font
                topMaximumLineCount: 1

                mouseArea.cursorShape: this.modelData.isSeparator ? Qt.ArrowCursor: Qt.PointingHandCursor
                mouseArea.onClicked: {
                    this.modelData.triggered()
                    _.close()
                }
                mouseArea.onEntered: this.active = this.modelData.isSeparator ? false: true
                mouseArea.onExited: this.active = false
            }
        }
    }
}
