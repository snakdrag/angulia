import QtQuick
import Quickshell
import Quickshell.Widgets
import "../components"
import "../states" as States

Panel {
    id: _

    sets: Datas.settings.wallpaperswitcher

    implicitWidth: Math.max(_list.contentWidth, this.cardWidth) + this.space * 2
    implicitHeight: _field.height + this.space * 2 + (
        _list.contentWidth === 0 || _list.contentHeight === 0 ?
        0: Math.max(_list.contentHeight, this.cardHeight) + this.space
    )

    show: States.WallpaperSwitcher.open
    onShowChanged: {
        if (this.show) _field.forceActiveFocus();
        _field.text = "";
    }

    TextField {
        id: _field
        customY: parent.inputAtTop ? 0: parent.height
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.inputHeight
        space: parent.space

        font: parent.font

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
            model: ScriptModel { values: _.show ? States.WallpaperSwitcher.search(_field.text).sort((a, b) => a.name.localeCompare(b.name)): [] }
            delegate: Item {
                required property var modelData
                required property int index
                implicitWidth: _.cardWidth
                implicitHeight: _.cardHeight
                Card {
                    anchors.fill: parent

                    active: this.hovered || parent.index === _list.currentIndex

                    color: _.cardColor
                    radius: _.radius

                    myMode: _.myMode

                    cover.color: _.textColor

                    image.width: this.width
                    image.height: this.height
                    image.source: parent.modelData.path
                    image.fillMode: Image.PreserveAspectCrop

                    onClicked: {parent.modelData.execute(); States.Ipc.closeAll()}
                }
            }
        }
    }
}