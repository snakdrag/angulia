import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Io
import "../services"
import "../angulia"
import "../../settings"

Angulia {
    id: _

    _data: Settings.wallpaperswitcher

    implicitWidth: Math.max(_list.contentWidth, cardWidth) + space * 2
    implicitHeight: (noContent ? 0: Math.max(_list.contentHeight, (isVertical ? 0: cardHeight)) + space) + _field.height

    property bool noContent: (_list.contentWidth === 0 || _list.contentHeight === 0)

    property int selectedIndex: (0)

    show: false
    readonly property IpcHandler ipc: (_ipc)

    IpcHandler {
        id: _ipc
        target: "wallpaperswitcher"
        function open()
        {
            ipcCloseAll()
            _.show = true
            _.selectedIndex = 0
            _field.searchText = ""
            _field.forceActiveFocus()
        }
        function close()
        {
            _.show = false
        }
        function toggle()
        {
            if (_.show)
            {
                close()
            }
            else {
                open()
            }
        }
    }

    TextField {
        id: _field
        y: _._data.inputAtTop ? 0: Math.max(parent.height - height - anchors.bottomMargin, 0)
        anchors.left: parent.left
        anchors.right: parent.right
        implicitHeight: _.bar.height
        radius: _.radius
        space: _.space
        textColor: _.textColor
        inputColor: _.cardColor
        clearText: "Search..."
        visible: _.show
        font: _._data.font
        onTextChanged: {_.selectedIndex = 0}
        onEscapePressed: {_ipc.close()}
        onUpPressed: {
            if (_list.count > 0)
            {
                _.selectedIndex = Math.max(_.selectedIndex - 1, 0)
                _list.positionViewAtIndex(_.selectedIndex, ListView.Contain)
            }
        }
        onDownPressed: {
            if (_list.count > 0)
            {
                _.selectedIndex = Math.min(_.selectedIndex + 1, _list.count - 1)
                _list.positionViewAtIndex(_.selectedIndex, ListView.Contain)
            }
        }
        onLeftPressed: {
            if (_list.count > 0)
            {
                _.selectedIndex = Math.max(_.selectedIndex - 1, 0)
                _list.positionViewAtIndex(_.selectedIndex, ListView.Contain)
            }
        }
        onRightPressed: {
            if (_list.count > 0)
            {
                _.selectedIndex = Math.min(_.selectedIndex + 1, _list.count - 1)
                _list.positionViewAtIndex(_.selectedIndex, ListView.Contain)
            }
        }
        onReturnPressed: {
            if (_list.count > 0)
            {
                _list.currentItem.modelData.execute()
                _ipc.close()
            }
            else {_ipc.close()}
        }
    }
    ClippingRectangle {
        anchors.fill: parent
        anchors.margins: _.space
        anchors.topMargin: _._data.inputAtTop ? _field.height: _.space
        anchors.bottomMargin: _._data.inputAtTop ? _.space: _field.height
        radius: _.radius
        color: _.backgroundColor
        visible: _.show
        List {
            id: _list
            spacing: _.space
            isVertical: _.isVertical
            currentIndex: _.selectedIndex
            displaced: null
            model: ScriptModel { values: WallpaperSwitcher.search(_field.searchText).sort((a, b) => a.name.localeCompare(b.name)) }
            delegate: Card {
                id: _card
                required property var modelData
                required property int index

                active: _card.index === _.selectedIndex
                activeColor: _.textColor
                color: _.cardColor

                implicitWidth: _.cardWidth
                implicitHeight: _.cardHeight

                space: _.space
                radius: _.radius
                isVertical: _.isVertical
                centerIn: true

                imageWidth: _.imageWidth
                imageHeight: _.imageHeight
                imageSource: modelData.path
                imageFillMode: Image.PreserveAspectCrop

                Mouse {
                    onClicked: {
                        _card.modelData.execute()
                        _ipc.close()
                    }
                }
            }
        }
    }
}
