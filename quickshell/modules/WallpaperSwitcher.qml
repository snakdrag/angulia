import QtQuick
import Quickshell
import "../components"
import "../states" as States

Panel {
    id: _

    implicitWidth: Math.max(_list.contentWidth, this.cardWidth) + this.space * 2
    implicitHeight: _field.height + this.space * 2 + (
        _list.contentWidth === 0 || _list.contentHeight === 0 ?
        0: Math.max(_list.contentHeight, this.cardHeight) + this.space
    )

    sets: Datas.settings.wallpaperswitcher
    show: States.WallpaperSwitcher.open
    onShowChanged: { if (this.show) _field.forceActiveFocus(); _field.text = "" }

    TextField {
        id: _field

        customY: parent.inputAtTop ? 0: parent.height
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.inputHeight

        color: parent.textColor

        space: parent.space

        font: parent.font
        placeholderText: "Search..."

        background.color: parent.cardColor
        background.radius: parent.radius

        onTextChanged: Qt.callLater(() => {_list.currentIndex = 0})
        Keys.onUpPressed: if (_list.count > 0) _list.currentIndex = Math.max(_list.currentIndex - 1, 0)
        Keys.onDownPressed: if (_list.count > 0) _list.currentIndex = Math.min(_list.currentIndex + 1, _list.count - 1)
        Keys.onLeftPressed: if (_list.count > 0) _list.currentIndex = Math.max(_list.currentIndex - 1, 0)
        Keys.onRightPressed: if (_list.count > 0) _list.currentIndex = Math.min(_list.currentIndex + 1, _list.count - 1)
        Keys.onReturnPressed: { if (_list.count > 0) _list.currentItem.modelData.execute(); States.Ipc.closeAll() }
        Keys.onEscapePressed: States.Ipc.closeAll()
    }
    ClippingRectangle {

        customY: parent.inputAtTop ? parent.height: 0
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: parent.space
        implicitWidth: parent.width - parent.space * 2
        implicitHeight: parent.height - _field.height - parent.space * 3

        color: parent.backgroundColor
        radius: parent.radius

        List {
            id: _list

            spacing: _.space
            displaced: null
            myMode: _.myMode

            model: ScriptModel {
                values: States.WallpaperSwitcher.search(_field.text).sort((a, b) => a.name.localeCompare(b.name))
            }
            delegate: Item {

                required property var modelData
                required property int index

                implicitWidth: _.cardWidth
                implicitHeight: _.cardHeight

                Card {

                    anchors.fill: parent

                    color: _.cardColor
                    radius: _.radius

                    active: this.hovered || parent.index === _list.currentIndex
                    myMode: _.myMode

                    cover.color: _.textColor

                    image.width: this.width
                    image.height: this.height
                    image.source: parent.modelData.path
                    image.fillMode: Image.PreserveAspectCrop

                    onClicked: { parent.modelData.execute(); States.Ipc.closeAll() }
                }
            }
        }
    }
}