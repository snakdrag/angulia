import QtQuick
import Quickshell
import Quickshell.Widgets
import "../components"
import "../states"

Panel {
    id: _

    customX: parent.width / 2
    customY: 0

    implicitWidth: Math.max(_list.contentWidth, this.cardWidth) + this.space * 2
    implicitHeight: _field.height + this.space * 2 + (
        _list.contentWidth === 0 || _list.contentHeight === 0 ?
        0: Math.max(_list.contentHeight, this.cardHeight) + this.space
    )

    cardWidth: 120
    cardHeight: 80

    property bool inputAtTop: (true)
    property int inputHeight: (30)
    property bool myMode: (true)

    show: Launcher.open
    onShowChanged: {
        if (this.show)
        {
            _field.forceActiveFocus()
        }
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
            if (_list.count > 0)
            {
                _list.currentItem.modelData.execute()
            }
            Ipc.closeAll()
        }
        Keys.onEscapePressed: Ipc.closeAll()
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
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: parent.space
        implicitHeight: parent.height - _field.height - _.space * 3
        radius: parent.radius
        color: parent.backgroundColor
        visible: parent.show
        List {
            id: _list
            spacing: _.space
            displaced: null
            orientation: _.myMode ? ListView.Horizontal: ListView.Vertical
            model: ScriptModel { values: _.show ? Launcher.search(_field.text).sort((a, b) => a.name.localeCompare(b.name)): [] }
            delegate: Item {
                required property var modelData
                required property int index
                implicitWidth: _main.width
                implicitHeight: _main.height
                Card {
                    id: _main
                    implicitWidth: _.cardWidth
                    implicitHeight: this.myMode ? _.cardHeight: Math.max(this.image.height, this.textHeight) + this.space * 2

                    active: this.hovered || parent.index === _list.currentIndex

                    color: _.cardColor
                    space: _.space
                    radius: _.radius

                    myMode: _.myMode

                    cover.color: _.textColor

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

                    image.width: _.iconSize
                    image.height: _.iconSize
                    image.source: Quickshell.iconPath(parent.modelData.icon, true)

                    onClicked: {
                        parent.modelData.execute()
                        Ipc.closeAll()
                    }
                }
            }
        }
    }
}