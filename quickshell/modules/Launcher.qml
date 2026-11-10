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

    sets: Datas.settings.launcher
    show: States.Launcher.open

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

        onTextChanged: _list.currentIndex = 0
        Keys.onUpPressed: if (_list.count > 0) _list.currentIndex = Math.max(_list.currentIndex - 1, 0)
        Keys.onDownPressed: if (_list.count > 0) _list.currentIndex = Math.min(_list.currentIndex + 1, _list.count - 1)
        Keys.onLeftPressed: if (_list.count > 0) _list.currentIndex = Math.max(_list.currentIndex - 1, 0)
        Keys.onRightPressed: if (_list.count > 0) _list.currentIndex = Math.min(_list.currentIndex + 1, _list.count - 1)
        Keys.onReturnPressed: { if (_list.count > 0) Quickshell.execDetached(_list.currentItem.modelData.command); States.Ipc.closeAll() }
        Keys.onEscapePressed: States.Ipc.closeAll()
    }
    ClippingRectangle {

        customY: parent.inputAtTop ? parent.height: 0
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: parent.space
        implicitWidth: parent.width - parent.space * 2
        implicitHeight: parent.height - _field.height - parent.space * 3

        radius: parent.radius
        color: parent.backgroundColor

        List {
            id: _list

            spacing: _.space
            displaced: null
            myMode: _.myMode

            model: ScriptModel {
                values: States.Launcher.search(_field.text).sort((a, b) => a.name.localeCompare(b.name))
            }
            delegate: Item {

                required property var modelData
                required property int index

                implicitWidth: _main.width
                implicitHeight: _main.height

                Card {
                    id: _main

                    implicitWidth: _.cardWidth
                    implicitHeight: this.myMode ? _.cardHeight: Math.max(_.cardHeight, this.textHeight) + this.space * 2

                    color: _.cardColor
                    radius: _.radius

                    active: this.hovered || parent.index === _list.currentIndex
                    myMode: _.myMode
                    space: _.space

                    cover.color: _.textColor

                    image.width: _.iconSize
                    image.height: _.iconSize
                    image.source: Quickshell.iconPath(parent.modelData.icon, true)

                    topText.font.family: _.font.family
                    topText.font.pixelSize: _.font.pixelSize
                    topText.font.bold: true
                    topText.text: parent.modelData.name
                    topText.color: _.textColor
                    topText.maximumLineCount: 1

                    bottomText.font.family: _.font.family
                    bottomText.font.pixelSize: _.font.pixelSize
                    bottomText.font.bold: false
                    bottomText.text: parent.modelData.comment || ""
                    bottomText.color: _.textColor
                    bottomText.maximumLineCount: 1

                    onClicked: { Quickshell.execDetached(parent.modelData.command); States.Ipc.closeAll() }
                }
            }
        }
    }
}