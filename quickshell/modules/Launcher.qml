import QtQuick
import Quickshell
import Quickshell.Widgets
import "../components"
import "../states" as States

Panel {
    id: _

    sets: Datas.settings.launcher

    implicitWidth: Math.max(_list.contentWidth, this.cardWidth) + this.space * 2
    implicitHeight: _field.height + this.space * 2 + (
        _list.contentWidth === 0 || _list.contentHeight === 0 ?
        0: Math.max(_list.contentHeight, this.cardHeight) + this.space
    )

    show: States.Launcher.open
    onShowChanged: {
        if (this.show) _field.forceActiveFocus();
        _field.text = ""
    }

    TextField {
        id: _field
        customY: parent.inputAtTop ? 0: parent.height
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.inputHeight
        space: parent.space

        font.family: parent.font.family
        font.pixelSize: parent.font.pixelSize
        font.bold: parent.font.bold

        background.color: parent.cardColor
        background.radius: parent.radius

        color: parent.textColor
        placeholderText: "Search..."

        onTextChanged: _list.currentIndex = 0
        Keys.onUpPressed: if (_list.count > 0) _list.currentIndex = Math.max(_list.currentIndex - 1, 0)
        Keys.onDownPressed: if (_list.count > 0) _list.currentIndex = Math.min(_list.currentIndex + 1, _list.count - 1)
        Keys.onLeftPressed: if (_list.count > 0) _list.currentIndex = Math.max(_list.currentIndex - 1, 0)
        Keys.onRightPressed: if (_list.count > 0) _list.currentIndex = Math.min(_list.currentIndex + 1, _list.count - 1)
        Keys.onReturnPressed: {
            if (_list.count > 0) _list.currentItem.modelData.execute();
            States.Ipc.closeAll()
        }
        Keys.onEscapePressed: States.Ipc.closeAll()
        visible: parent.show
    }
    ClippingRectangle {
        y: Math.max(
            this.anchors.topMargin,
            Math.min(
                parent.height - this.anchors.bottomMargin - this.height,
                (parent.inputAtTop ? parent.height: 0) - this.height / 2
            )
        )
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: parent.space
        implicitWidth: parent.width - parent.space * 2
        implicitHeight: parent.height - _field.height - parent.space * 3
        radius: parent.radius
        color: parent.backgroundColor
        visible: parent.show
        List {
            id: _list
            spacing: _.space
            displaced: null
            myMode: _.myMode
            model: ScriptModel { values: _.show ? States.Launcher.search(_field.text).sort((a, b) => a.name.localeCompare(b.name)): [] }
            delegate: Item {
                required property var modelData
                required property int index
                implicitWidth: _main.width
                implicitHeight: _main.height
                Card {
                    id: _main
                    implicitWidth: _.cardWidth
                    implicitHeight: this.myMode ? _.cardHeight: Math.max(_.cardHeight, this.textHeight) + this.space * 2

                    active: this.hovered || parent.index === _list.currentIndex

                    color: _.cardColor
                    space: _.space
                    radius: _.radius

                    myMode: _.myMode

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
                    bottomText.text: parent.modelData.comment
                    bottomText.color: _.textColor
                    bottomText.maximumLineCount: 1

                    onClicked: {parent.modelData.execute(); States.Ipc.closeAll()}
                }
            }
        }
    }
}